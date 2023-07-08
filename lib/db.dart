import 'dart:math';
import 'package:flora/constans/asset.dart';
import 'package:flora/constans/language.dart';
import 'package:flora/widgets/card/product_card.dart';
import 'package:flora/widgets/card/shop_card.dart';
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

  static List<Map<String, String>> get promotions {
    return [
      {
        'title': 'Hello summer',
        'desc': 'Giảm giá vào hè với nhũng ưu đãi hấp dẫn',
        'banner': 'assets/images/etc/promotion_1.png',
      },
      {
        'title': 'Ngày lễ 8/3',
        'desc': 'Giảm giá nhân ngày Quốc tế Phụ nữ mùng 8/3',
        'banner': 'assets/images/etc/promotion_2.png',
      },
      {
        'title': 'Black Friday 4.4',
        'desc': 'Giảm giá nhân ngày Black Friday mùng 4 tháng 4',
        'banner': 'assets/images/etc/promotion_3.png',
      },
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

  static List<ProductModel> getFlowers() {
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

    List<ProductModel> items = [];
    Random random = Random();

    for (int i = 1; i <= 10; i++) {
      items.add(
        ProductModel(
          image: 'assets/images/layout/flower_$i.png',
          name: names[random.nextInt(names.length)],
          price: (((random.nextDouble() * 80).round() + 1) * 10000).toDouble(),
          star: double.parse((random.nextDouble() * 1 + 4).toStringAsFixed(1)),
          sold: random.nextInt(1000) + 50,
          discount: i % 2 == 0 ? null : random.nextInt(32),
        ),
      );
    }

    items.shuffle(random);

    return items;
  }

  static List<ShopModel> get shopList {
    List<String> images = [
      'assets/images/layout/shop_retro_vibes.png',
      'assets/images/layout/shop_estelle.png',
      'assets/images/layout/shop_sweet_pea.png',
      'assets/images/layout/shop_petal_stem.png',
    ];

    Random random = Random();

    List<ShopModel> items = [];

    for (int i = 0; i < images.length; i++) {
      String h = images[i];
      items.add(
        ShopModel(
          distance: '${random.nextDouble() * 10}km',
          name: h
              .split('/')
              .last
              .split('.')[0]
              .split('_')
              .skip(1)
              .map((h) => h.substring(0, 1).toUpperCase() + h.substring(1))
              .join(' '),
          star: double.parse((random.nextDouble() * 5).toStringAsFixed(1)),
          evaluation: '10+',
          image: h,
          discount: i != 0 ? null : random.nextInt(32),
        ),
      );
    }

    return items;
  }
}
