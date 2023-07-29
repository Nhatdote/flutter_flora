import 'dart:convert';
import 'package:flora/db.dart';
import 'package:flora/shared/functions.dart';
import 'package:path/path.dart';

class User {
  String id;
  String phone;
  String fullname;
  String password;
  String? address;

  User({
    required this.id,
    required this.phone,
    required this.fullname,
    required this.password,
    this.address,
  });

  static const key = 'users';

  dynamic getFieldValue(String field) {
    switch (field) {
      case 'fullname':
        return fullname;
      case 'phone':
        return phone;
      case 'password':
        return '';
      case 'address':
        return address;
      default:
        return id;
    }
  }

  dynamic setFieldValue(String field, dynamic value) {
    switch (field) {
      case 'fullname':
        fullname = value;
        break;
      case 'phone':
        // phone = value;
        break;
      case 'password':
        password = Fs.hash(value);
        break;
      case 'address':
        address = value;
        break;
    }

    List<String> all = User.getAll().map((h) {
      if (h.id == id) {
        return toJson();
      }
      return h.toJson();
    }).toList();

    DB.prefs.setStringList(key, all);
  }

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

  static User? verify(String phone, String password) {
    final Set<User> users = getAll();
    User? user;

    for (final User h in users) {
      if (h.phone == phone) {
        user = h;
        break;
      }
    }

    if (user == null) {
      return null;
    }

    if (Fs.hash(password) == user.password) {
      return user;
    }

    return null;
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
