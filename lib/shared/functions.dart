import 'dart:convert';
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';

class Fs {
  static String hash(text) {
    return sha256.convert(utf8.encode(text)).toString();
  }

  static String vndFormat(double value) {
    final format = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');

    return format.format(value);
  }
}
