const typeFreeShip = 'FREESHIP';
const typeNormal = 'NORMAL';
const methodAll = 'ALL';
const methodCash = 'CASH';
const methodOnline = 'ONLINE';
const fromFlora = 'FLORA';
const fromShop = 'SHOP';

class VoucherModel {
  VoucherModel({
    required this.id,
    required this.image,
    required this.type,
    this.condition,
    required this.title,
    this.desc,
    this.content,
    required this.total,
    this.used = 0,
    this.canSaveVoucher = true,
    this.hasSavedVoucher = false,
    this.hasUsedVoucher = false,
    this.expiredAt,
    this.minPrice,
    required this.from,
    this.payMethod = methodAll,
  });

  final int id;
  final String image;
  final String type; // FREESHIP || NORMAL
  final String? condition;
  final String title;
  final String? desc;
  final String? content;
  final int total;
  final int used;
  final bool canSaveVoucher;
  final bool hasSavedVoucher;
  final bool hasUsedVoucher;
  final DateTime? expiredAt;
  final double? minPrice;
  final String from;
  final String payMethod;

  static String payMethodLabel(id) {
    Map<String, String> map = {
      methodAll: 'Mọi hình thức',
      methodCash: 'Tiền mặt',
      methodOnline: 'Online'
    };

    return map[id] ?? methodAll;
  }
}
