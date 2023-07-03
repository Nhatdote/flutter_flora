import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';

class Fs {
  static String hash(text) {
    return sha256.convert(utf8.encode(text)).toString();
  }
}
