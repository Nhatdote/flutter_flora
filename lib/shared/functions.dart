import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';

class Fs {
  static String hash(text) {
    return sha256.convert(utf8.encode(text)).toString();
  }

  static String vndFormat(double value) {
    String formattedValue = value.toStringAsFixed(0); // Làm tròn số nguyên
    formattedValue = formattedValue.replaceAllMapped(
      RegExp(r'(\d{3})(?=\d)'),
      (Match match) => '${match.group(1)}.',
    ); // Thêm dấu chấm phẩy sau mỗi 3 chữ số
    formattedValue = '$formattedValueđ'; // Thêm ký hiệu đồng

    return formattedValue;
  }
}
