import 'dart:math';
import 'package:flora/constans/asset.dart';
import 'package:flora/constans/language.dart';
import 'package:flora/models/arrangement_model.dart';
import 'package:flora/models/product_model.dart';
import 'package:flora/models/shop_model.dart';
import 'package:flora/models/voucher_history_model.dart';
import 'package:flora/models/voucher_model.dart';
import 'package:flora/models/wrap_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DB {
  static const skipOnBoarding = 'skipOnBoarding';
  static const users = 'users';
  static const keyLoginUser = 'loginUser';

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
        'route': '/near-you',
      },
      {
        'icon': 'assets/images/etc/feature_design.png',
        'label': 'Thiết kế',
        'route': '/design/select-shop',
      },
      {
        'icon': 'assets/images/etc/feature_strange.png',
        'label': 'Độc lạ',
        'route': '/strange',
      },
      {
        'icon': 'assets/images/etc/feature_other.png',
        'label': 'Khác',
        'route': '/other',
      }
    ];
  }

  static List<ProductModel> getFlowerByIds(List<int> ids) {
    List<ProductModel> items = getFlowers();

    List<ProductModel> filtered =
        items.where((h) => ids.contains(h.id)).toList();

    return filtered;
  }

  static List<ProductModel> getFlowers({bool shuffle = true}) {
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
          id: i + 1,
          image: 'assets/images/layout/flower_$i.png',
          name: names[i], //names[random.nextInt(names.length)],
          price: (((random.nextDouble() * 80).round() + 1) * 10000.toDouble())
              .toDouble(),
          star: double.parse((random.nextDouble() * 1 + 4).toStringAsFixed(1)),
          sold: random.nextInt(1000) + 50,
          discount: i % 2 == 0 ? null : random.nextInt(32),
        ),
      );
    }

    if (shuffle) {
      items.shuffle(random);
    }

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
          id: i + 1,
          distance:
              '${double.parse((random.nextDouble() * 10).toStringAsFixed(1))}km',
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

  static List<WrapModel> get wraps {
    return [
      WrapModel(
        id: 1,
        title: 'Giấy Kraft',
        price: 10000.toDouble(),
        image: 'assets/images/layout/wrap/kraft.png',
      ),
      WrapModel(
        id: 2,
        title: 'Giấy Mếch',
        price: 10000.toDouble(),
        image: 'assets/images/layout/wrap/mech.png',
      ),
      WrapModel(
        id: 3,
        title: 'Giấy Kraft 2',
        price: 10000.toDouble(),
        image: 'assets/images/layout/wrap/kraft.png',
      ),
      WrapModel(
        id: 4,
        title: 'Giấy Mếch 2',
        price: 10000.toDouble(),
        image: 'assets/images/layout/wrap/mech.png',
      ),
    ];
  }

  static List<ArrangementModel> get arrangements {
    return [
      ArrangementModel(
        id: 1,
        title: 'Bó tròn',
        price: 0.toDouble(),
        image: 'assets/images/layout/arrangement/rounded.png',
      ),
      ArrangementModel(
        id: 2,
        title: 'Bán Nguyệt',
        price: 0.toDouble(),
        image: 'assets/images/layout/arrangement/semicircle.png',
      ),
      ArrangementModel(
        id: 3,
        title: 'Bó tròn 2',
        price: 0.toDouble(),
        image: 'assets/images/layout/arrangement/rounded.png',
      ),
      ArrangementModel(
        id: 4,
        title: 'Bán Nguyệt 2',
        price: 0.toDouble(),
        image: 'assets/images/layout/arrangement/semicircle.png',
      ),
    ];
  }

  static List<VoucherModel> vouchers({String from = fromFlora}) {
    final String imagePath = from == fromFlora ? 'voucher_' : 'shop_';
    const String content =
        'Giảm 10% (tối đa 30k) cho mọi đơn hàng thoả mãn điều kiện ưu đãi khi mua hàng trên Flora. \n Số lượt sử dụng có hạn, chương trình và mã có thể kết thúc khi hết lượt ưu đãi hoặc khi hết hạn ưu đãi.';

    return [
      VoucherModel(
        id: 1,
        image: 'assets/images/layout/voucher/${imagePath}1.png',
        type: typeFreeShip,
        title: 'Giảm 10%',
        desc: 'Tối đa 30k',
        total: 100,
        used: 25,
        from: from,
        canSaveVoucher: true,
        hasUsedVoucher: false,
        expiredAt: DateTime(2023, 12),
        content: content,
      ),
      VoucherModel(
        id: 2,
        image: 'assets/images/layout/voucher/${imagePath}2.png',
        type: typeFreeShip,
        title: 'Giảm 10%',
        desc: 'Tối đa 30k',
        total: 100,
        used: 60,
        from: from,
        canSaveVoucher: false,
        hasSavedVoucher: true,
        hasUsedVoucher: false,
        content: content,
      ),
      VoucherModel(
        id: 3,
        image: 'assets/images/layout/voucher/${imagePath}2.png',
        type: typeFreeShip,
        title: 'Giảm 12%',
        desc: 'Tối đa 30k',
        total: 100,
        used: 88,
        from: from,
        canSaveVoucher: true,
        hasSavedVoucher: false,
        hasUsedVoucher: false,
        content: content,
      ),
      VoucherModel(
        id: 4,
        image: 'assets/images/layout/voucher/${imagePath}1.png',
        type: typeFreeShip,
        title: 'Giảm 20%',
        desc: 'Tối đa 50k',
        total: 100,
        used: 100,
        from: from,
        canSaveVoucher: false,
        hasSavedVoucher: true,
        hasUsedVoucher: false,
        content: content,
      )
    ];
  }

  static List<VoucherHistoryModel> get voucherHistories {
    return [
      VoucherHistoryModel(
        productId: 1,
        productName: 'Hoa Hồng Canada 1',
        productImage: 'assets/images/layout/flower_1.png',
        date: DateTime(2023, 08, 03, 15, 05, 00),
        type: VoucherHistoryType.voucherHistoryOut,
        amount: 3000,
      ),
      VoucherHistoryModel(
        productId: 2,
        productName: 'Hoa Hồng Canada 2',
        productImage: 'assets/images/layout/flower_2.png',
        date: DateTime(2023, 08, 03, 15, 05, 00),
        type: VoucherHistoryType.voucherHistoryOut,
        amount: 5000,
      ),
      VoucherHistoryModel(
        productId: 3,
        productName: 'Hoa Hồng Canada 3',
        productImage: 'assets/images/layout/flower_3.png',
        date: DateTime(2023, 08, 03, 15, 05, 00),
        type: VoucherHistoryType.voucherHistoryOut,
        amount: 1000,
      ),
      VoucherHistoryModel(
        productId: 4,
        productName: 'Hoa Hồng Canada 4',
        productImage: 'assets/images/layout/flower_4.png',
        date: DateTime(2023, 08, 03, 15, 05, 00),
        type: VoucherHistoryType.voucherHistoryIn,
        amount: 1000,
      ),
      VoucherHistoryModel(
        productId: 5,
        productName: 'Hoa Hồng Canada 5',
        productImage: 'assets/images/layout/flower_5.png',
        date: DateTime(2023, 08, 03, 15, 05, 00),
        type: VoucherHistoryType.voucherHistoryIn,
        amount: 1500,
      ),
    ];
  }
}
