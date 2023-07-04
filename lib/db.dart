import 'dart:math';
import 'package:flora/constans/asset.dart';
import 'package:flora/constans/language.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DB {
  static const skipOnBoarding = 'skipOnBoarding';
  static const users = 'users';

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

  static List<String> get promotions {
    return [
      'assets/images/etc/promotion_1.png',
      'assets/images/etc/promotion_2.png',
      'assets/images/etc/promotion_3.png',
    ];
  }

  static List<Map<String, String>> get features {
    return [
      {
        'icon': 'assets/images/etc/feature_location.png',
        'label': 'Gần bạn',
      },
      {
        'icon': 'assets/images/etc/feature_design.png',
        'label': 'Thiết kế',
      },
      {
        'icon': 'assets/images/etc/feature_strange.png',
        'label': 'Độc lạ',
      },
      {
        'icon': 'assets/images/etc/feature_other.png',
        'label': 'Khác',
      }
    ];
  }

  static List<Map<String, dynamic>> getFlowers() {
    final List<String> names = [
      'Hoa hồng bó ruy băng',
      'Hoa mẫu đơn bó giấy',
      'Bó Hoa Hồng Tươi Elsie',
      'Bó Hoa Tươi Thạch Anh Ngọt Ngào',
      'Bó Hoa Tươi Aurora Ngọt Ngào',
      'Cẩm tú cầu',
      'Hoa cưới',
      'Bó hoa tươi Lovely',
      'Bó Hoa Tươi Hoa Anh Túc Tử Đinh Hương',
      'Bó Hoa Tươi Sophie Daisy',
      'Bó Hoa Everly tươi'
    ];

    List<Map<String, dynamic>> items = [];
    Random random = Random();

    for (int i = 1; i <= 11; i++) {
      items.add({
        'name': names[random.nextInt(names.length)],
        'image': 'assets/images/layout/flower_$i.png',
        'price': (((random.nextDouble() * 80).round() + 1) * 10000).toDouble(),
        'star': double.parse((random.nextDouble() * 1 + 4).toStringAsFixed(1)),
        'sold': random.nextInt(1000) + 50,
        'discount': i % 2 == 0 ? null : random.nextInt(32)
      });
    }

    items.shuffle(random);

    return items;
  }

  static List<Map<String, dynamic>> get shopList {
    return [
      {
        'image': 'assets/images/layout/shop_retro_vibes.png',
        'distance': '0.2km',
        'name': 'Retro Vibe',
        'star': 4.3,
        'evaluation': '10+',
        'discount': 22
      },
      {
        'image': 'assets/images/layout/shop_estelle.png',
        'distance': '1.2km',
        'name': 'Estelle',
        'star': 3.9,
        'evaluation': '10+'
      },
      {
        'image': 'assets/images/layout/shop_sweet_pea.png',
        'distance': '0.9km',
        'name': 'Sweet pea',
        'star': 4.8,
        'evaluation': '10+'
      },
      {
        'image': 'assets/images/layout/shop_petal_stem.png',
        'distance': '0.5km',
        'name': 'Petal & stem',
        'star': 4.2,
        'evaluation': '10+'
      }
    ];
  }
}
