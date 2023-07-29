import 'dart:convert';
import 'package:flora/db.dart';
import 'package:flora/models/user.dart';
import 'package:get/get.dart';

class AuthState extends GetxController {
  Rx<User?> loginUser = Rx<User?>(null);
  RxDouble voucherCoint = 0.0.obs;
  RxDouble rankedMoney = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    getLoginUser();
    voucherCoint.value = 10000;
    rankedMoney.value = 5000000;
  }

  User? getLoginUser() {
    String? loginUserString = DB.prefs.getString(DB.keyLoginUser);
    loginUser.value =
        loginUserString == null ? null : User.fromJson(loginUserString);

    return loginUser.value;
  }

  void setLoginUser(User user) {
    loginUser.value = user;

    DB.prefs.setString(DB.keyLoginUser, user.toJson());
  }
}
