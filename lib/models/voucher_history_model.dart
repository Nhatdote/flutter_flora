enum VoucherHistoryType { voucherHistoryIn, voucherHistoryOut }

const voucherHistoryIn = 'IN';
const voucherHistoryOut = 'OUT';

class VoucherHistoryModel {
  VoucherHistoryModel({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.date,
    required this.type,
    required this.amount,
  });

  final int productId;
  final String productName;
  final String productImage;
  final DateTime date;
  final VoucherHistoryType type;
  final double amount;
}
