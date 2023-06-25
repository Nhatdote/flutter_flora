import 'package:flora/constans/asset.dart';
import 'package:flora/constans/language.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DB {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    // _prefs?.clear();
  }

  static SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception(
          'SharedPreferences has not been initialized. Call init() before accessing prefs.');
    }

    return _prefs!;
  }

  static const List<Map<String, dynamic>> onBoarding = [
    {
      'icon': Asset.onBoarding1,
      'title': 'Tinh tế, sang trọng,\nđầy tình yêu',
      'desc': 'Sở hữu, tìm hiểu và thiết kế bó hoa cho chính bạn'
    },
    {
      'icon': Asset.onBoarding2,
      'title': 'Tinh tế, sang trọng,\nđầy tình yêu',
      'desc': 'Sở hữu, tìm hiểu và thiết kế bó hoa cho chính bạn'
    },
    {
      'icon': Asset.onBoarding3,
      'title': 'Tinh tế, sang trọng,\nđầy tình yêu',
      'desc': 'Sở hữu, tìm hiểu và thiết kế bó hoa cho chính bạn'
    }
  ];

  static List<Map<String, dynamic>> get flags {
    final Map<String, dynamic> flags = {
      Language.vi: {'flag': Asset.flagVi, 'code': '+84'},
      Language.en: {'flag': Asset.flagEn, 'code': '+44'},
    };

    return Language.languages.map((h) {
      final Map<String, dynamic> flag = flags[h['id']];
      return {...h, ...flag};
    }).toList();
  }
}
