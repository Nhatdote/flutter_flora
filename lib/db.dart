import 'package:flora/constans/asset.dart';
import 'package:flora/constans/language.dart';

class DB {
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
