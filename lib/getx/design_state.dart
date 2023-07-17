import 'package:flora/models/shop_model.dart';
import 'package:get/get.dart';

class DesignState extends GetxController {
  Rx<ShopModel?> shop = Rx<ShopModel?>(null);

  Map<dynamic, dynamic> flowerIds = {}.obs;

  Rx<int?> wrap = Rx<int?>(null);

  Rx<int?> arrangement = Rx<int?>(null);

  void reset() {
    shop.value = null;
    flowerIds.clear();
    wrap.value = null;
    arrangement.value = null;
  }

  void incQuantity(id) {
    if (flowerIds.containsKey(id)) {
      flowerIds[id]++;
    } else {
      flowerIds[id] = 1;
    }
  }

  void decQuantity(id) {
    if (flowerIds.containsKey(id)) {
      if (flowerIds[id] == 1) {
        flowerIds.remove(id);
      } else {
        flowerIds[id]--;
      }
    }
  }
}
