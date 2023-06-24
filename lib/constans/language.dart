class Language {
  static const String vi = 'vi';
  static const String en = 'en';

  static List<Map<String, dynamic>> get languages {
    return [
      {'id': vi, 'label': 'Tiếng Việt'},
      {'id': en, 'label': 'Tiếng Anh'}
    ];
  }

  static String get currentLanguage {
    return vi;
  }
}
