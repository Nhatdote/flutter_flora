import 'dart:convert';
import 'package:crypto/crypto.dart';

class Fs {
  static String hash(text) {
    return sha256.convert(utf8.encode(text)).toString();
  }
}
