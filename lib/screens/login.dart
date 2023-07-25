import 'package:flora/constans/color.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/getx/auth_state.dart';
import 'package:flora/models/user.dart';
import 'package:flora/routes.dart';
import 'package:flora/shared/toast.dart';
import 'package:flora/widgets/button/app_button.dart';
import 'package:flora/widgets/logo.dart';
import 'package:flora/widgets/webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import '../constans/asset.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ScrollController scrollController = ScrollController();
  bool btnLoading = false;
  bool btnDisabled = true;
  bool showPassword = false;
  String? errorTextPhone;
  String? errorTextPassword;
  final AuthState auth = Get.find();

  onLogin(thisContext) async {
    String phone = phoneController.text;
    String password = passwordController.text;

    setState(() {
      btnLoading = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      btnLoading = false;
    });

    final User? check = User.verify(phone, password);

    if (check == null) {
      Toast.showError('Số điện thoại hoặc mật khẩu không đúng!');
      return;
    }

    auth.setLoginUser(check);
    Toast.show('Đăng nhập thành công!');
    Navigator.pushNamedAndRemoveUntil(
      thisContext,
      AppRoute.index,
      (route) => false,
    );
  }

  void onChangeInput(value) {
    String phone = phoneController.text;
    String password = passwordController.text;

    if (phone != '' && password != '') {
      setState(() {
        btnDisabled = false;
      });
    } else {
      setState(() {
        btnDisabled = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // phoneController = TextEditingController(text: '0353268673');
    // passwordController = TextEditingController(text: 'nhaT1379.');
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Toast.initialize(context);

    return Scaffold(
      body: KeyboardVisibilityBuilder(
        builder: (BuildContext context, isKeyboardVisible) {
          if (isKeyboardVisible) {
            scrollController.animateTo(
              100,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }

          return KeyboardDismissOnTap(
            child: SingleChildScrollView(
              controller: scrollController,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpace.xl),
                  child: Column(
                    children: [
                      const Spacer(),
                      const Logo(),
                      const Padding(
                        padding: EdgeInsets.only(top: AppSpace.xxl, bottom: 34),
                        child: Text(
                          'Đăng nhập để sử dụng\ndịch vụ của bạn',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Form(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: AppSpace.xl),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Số điện thoại',
                                      style: AppStyle.textLabel),
                                  const SizedBox(height: AppSpace.xs),
                                  TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller: phoneController,
                                    onChanged: (value) => onChangeInput(value),
                                    decoration: InputDecoration(
                                      hintText: 'Nhập số điện thoại của bạn',
                                      errorText: errorTextPhone,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: AppSpace.xl),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Mật khẩu',
                                      style: AppStyle.textLabel),
                                  const SizedBox(height: AppSpace.xs),
                                  TextFormField(
                                    obscureText: !showPassword,
                                    controller: passwordController,
                                    onChanged: (value) => onChangeInput(value),
                                    decoration: InputDecoration(
                                      hintText: 'Nhập mật khẩu của bạn',
                                      errorText: errorTextPhone,
                                      suffixIcon: InkWell(
                                        onTap: () {
                                          setState(() {
                                            showPassword = !showPassword;
                                          });
                                        },
                                        child: Icon(
                                          showPassword
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                          color: AppColor.neutral40,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      onTap: () {},
                                      child: const Text(
                                        'Quên mật khẩu?',
                                        style:
                                            TextStyle(color: AppColor.primary),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            AppButton(
                              label: 'Đăng nhập',
                              onTap: () => onLogin(context),
                              loading: btnLoading,
                              disable: btnDisabled,
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                color: AppColor.neutral70,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Hoặc',
                                style: TextStyle(color: AppColor.neutral40),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: AppColor.neutral70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: AppSpace.xxl),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SocialLoginWidget(
                              image: Asset.logoGoogle,
                              url: 'https://google.com',
                              title: 'Login with Google',
                            ),
                            SizedBox(width: AppSpace.xl),
                            SocialLoginWidget(
                              image: Asset.logoFacebook,
                              url: 'https://facebook.com',
                              title: 'Login with Facebook',
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SocialLoginWidget extends StatelessWidget {
  final String image;
  final String url;
  final String title;

  const SocialLoginWidget({
    super.key,
    required this.image,
    required this.url,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColor.neutral10,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        splashRadius: 26,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (_) => WebViewScreen(
                url: url,
                title: title,
              ),
            ),
          );
        },
        icon: Image.asset(
          image,
          height: 24,
        ),
      ),
    );
  }
}
