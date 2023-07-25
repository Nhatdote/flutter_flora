import 'dart:convert';
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';

class Fs {
  static String hash(text) {
    return sha256.convert(utf8.encode(text)).toString();
  }

  static String vndFormat(double value, {Map<String, dynamic>? options}) {
    final String symbol = options?['symbol'] ?? 'đ';
    final format = NumberFormat.currency(locale: 'vi_VN', symbol: symbol);
    return format.format(value);
  }

  static String getAvatarLetter(String name) {
    return name.split(' ').last[0];
  }
}
