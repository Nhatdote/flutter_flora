import 'dart:convert';
import 'package:flora/db.dart';
import 'package:flora/shared/functions.dart';

class User {
  final String id;
  final String phone;
  final String fullname;
  final String password;

  const User({
    required this.id,
    required this.phone,
    required this.fullname,
    required this.password,
  });

  static const key = 'users';

  factory User.fromJson(String json) {
    Map<String, dynamic> user = jsonDecode(json);

    if (user['phone'] != null &&
        user['fullname'] != null &&
        user['password'] != null) {
      return User(
        id: user['id']!,
        phone: user['phone']!,
        fullname: user['fullname']!,
        password: user['password']!,
      );
    }

    throw Exception('Invalid JSON format');
  }

  String toJson() {
    return jsonEncode({
      'id': id,
      'phone': phone,
      'fullname': fullname,
      'password': password,
    });
  }

  static Set<User> getAll() {
    Set<String> users = (DB.prefs.getStringList(key) ?? []).toSet();

    return users.map((String h) {
      return User.fromJson(h);
    }).toSet();
  }

  static bool verify(String phone, String password) {
    final Set<User> users = getAll();
    User? user;

    for (final User h in users) {
      if (h.phone == phone) {
        user = h;
        break;
      }
    }

    if (user == null) {
      return false;
    }

    if (Fs.hash(password) == user.password) {
      return true;
    }

    return false;
  }

  static Future<bool> store(User user) async {
    Set<User> users = getAll();

    users.add(user);

    List<String> jsonUser = users.map((User h) {
      return h.toJson();
    }).toList();

    return await DB.prefs.setStringList(key, jsonUser);
  }

  static bool isExist(phone) {
    Set<User> users = getAll();

    return users.any((h) => h.phone == phone);
  }
}
