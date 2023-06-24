import 'package:flora/constans/asset.dart';
import 'package:flora/constans/color.dart';
import 'package:flora/constans/regex.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/db.dart';
import 'package:flora/routes.dart';
import 'package:flora/shared/toast.dart';
import 'package:flora/widgets/button.dart';
import 'package:flora/widgets/logo.dart';
import 'package:flora/widgets/webview.dart';
import 'package:flutter/material.dart';

class RegisterPhoneScreen extends StatefulWidget {
  const RegisterPhoneScreen({super.key});

  @override
  State<RegisterPhoneScreen> createState() => _RegisterPhoneScreenState();
}

class _RegisterPhoneScreenState extends State<RegisterPhoneScreen> {
  TextEditingController inputController = TextEditingController();
  String? phoneError;
  bool nextDisabled = true;
  bool loading = false;

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  onNext(thisContext) async {
    setState(() {
      loading = true;
    });

    Toast.show(
      'Hãy nhập mã OTP được gửi đến số điện thoại của bạn',
      duration: 5,
    );
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      loading = false;
    });
    Navigator.pushNamed(thisContext, AppRoute.registerOtp);
  }

  onChangeInput(value) {
    final pattern = RegExp(Regex.phone);
    bool isValid = pattern.hasMatch(inputController.text);

    if (isValid) {
      setState(() {
        nextDisabled = false;
        phoneError = null;
      });
    } else {
      setState(() {
        nextDisabled = true;
        phoneError =
            value.isEmpty ? null : 'Số điện thoại không đùng định dạng';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Toast.initialize(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(AppSpace.xl),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Logo(),
                        SizedBox(
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          child: const Text(' '),
                        ),
                        const Text(
                          'Nhập số điện thoại của bạn\nđể tiếp tục',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                            fontSize: 18,
                            color: AppColor.neutral70,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpace.xxl,
                          ),
                          child: TextField(
                            onChanged: (value) => onChangeInput(value),
                            controller: inputController,
                            keyboardType: TextInputType.phone,
                            cursorHeight: 14,
                            decoration: InputDecoration(
                              errorText: phoneError,
                              hintText: 'Số điện thoại',
                              hintStyle: const TextStyle(
                                color: AppColor.neutral10,
                              ),
                              prefixIcon: Container(
                                width: 88,
                                padding: const EdgeInsets.only(
                                  left: 4,
                                ),
                                child: const FlagWidget(),
                              ),
                              suffixIcon: !nextDisabled
                                  ? const Icon(
                                      Icons.check,
                                      color: AppColor.primary,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        AppButton(
                          loading: loading,
                          label: 'Tiếp tục',
                          onTab: () => onNext(context),
                          disable: nextDisabled,
                        )
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
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
                  padding: const EdgeInsets.symmetric(vertical: AppSpace.xxl),
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
  }
}

class FlagWidget extends StatefulWidget {
  const FlagWidget({super.key});

  @override
  State<FlagWidget> createState() => _FlagWidgetState();
}

class _FlagWidgetState extends State<FlagWidget> {
  final List flags = DB.flags;
  late Map<String, dynamic>? selectedLanguage = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedLanguage = flags[0];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  children: flags.map((h) {
                    return ListTile(
                      leading: Image.asset(h['flag']),
                      title: Text(h['label']),
                      onTap: () {
                        setState(() {
                          selectedLanguage = h;
                        });
                        Navigator.pop(context);
                      },
                    );
                  }).toList(),
                ),
              ),
            );
          },
        );
      },
      child: Row(
        children: [
          Image.asset(selectedLanguage!['flag']),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpace.xs,
            ),
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: AppColor.neutral10,
                ),
              ),
            ),
            child: Text(
              selectedLanguage!['code'],
              style: const TextStyle(
                color: AppColor.neutral70,
              ),
            ),
          )
        ],
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
