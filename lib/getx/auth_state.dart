import 'dart:convert';
import 'package:flora/db.dart';
import 'package:flora/models/user.dart';
import 'package:get/get.dart';

class AuthState extends GetxController {
  Rx<User?> loginUser = Rx<User?>(null);
  RxDouble voucherCoint = 0.0.obs;
  RxDouble rankedMoney = 0.0.obs;
  RxMap settings = RxMap();

  @override
  void onInit() {
    super.onInit();
    getLoginUser();
    voucherCoint.value = 10000;
    rankedMoney.value = 5000000;
    settings.value = getUserSrtting();
  }

  User? getLoginUser() {
    String? loginUserString = DB.prefs.getString(DB.keyLoginUser);
    loginUser.value =
        loginUserString == null ? null : User.fromJson(loginUserString);

    return loginUser.value;
  }

  void setLoginUser(User? user) {
    loginUser.value = user;

    if (user == null) {
      DB.prefs.remove(DB.keyLoginUser);
    } else {
      DB.prefs.setString(DB.keyLoginUser, user.toJson());
    }
  }

  Map<String, dynamic> getUserSrtting() {
    String? settings = DB.prefs.getString(DB.keySetting);
    return settings != null ? jsonDecode(settings) : {};
  }

  Future<bool> setUserSetting(String key, dynamic value) async {
    Map<String, dynamic> settings = getUserSrtting();
    settings[key] = value;

    return await DB.prefs.setString(DB.keySetting, jsonEncode(settings));
  }
}
