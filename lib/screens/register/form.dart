import 'package:flora/constans/color.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/db.dart';
import 'package:flora/models/user.dart';
import 'package:flora/routes.dart';
import 'package:flora/screens/error.dart';
import 'package:flora/shared/functions.dart';
import 'package:flora/shared/toast.dart';
import 'package:flora/widgets/button/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class RegisterFormScreen extends StatefulWidget {
  final String phone;

  const RegisterFormScreen({
    super.key,
    required this.phone,
  });

  @override
  State<RegisterFormScreen> createState() => _RegisterFormScreenState();
}

class _RegisterFormScreenState extends State<RegisterFormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool showRePassword = false;
  bool btnDisabled = true;
  bool btnLoading = false;
  String? errorTextFullname;
  String? errorTextPassword;
  String? errorTextRepassword;

  Map<String, dynamic> regexPassword = {
    'min': {'label': 'Tối thiểu 6 ký tự', 'isPassed': false},
    'uppercase': {'label': 'Bao gồm 1 chữ hoa', 'isPassed': false},
    'lowercase': {'label': 'Bao gầm 1 chữ thường', 'isPassed': false},
    'digital': {'label': 'Bao gồm 1 số', 'isPassed': false},
    'special': {'label': 'Bao gồm 1 ký tự đặc biệt', 'isPassed': false},
  };

  late Map<String, TextEditingController> inputControllers = {};

  @override
  void initState() {
    super.initState();

    for (final field in ['fullname', 'password', 'rePassword']) {
      inputControllers[field] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (final field in ['fullname', 'password', 'rePassword']) {
      inputControllers[field]?.dispose();
    }

    super.dispose();
  }

  void updateButtonState() {
    // ignore: no_leading_underscores_for_local_identifiers
    bool _btnDisabled = false;

    if (errorTextFullname != null ||
        errorTextPassword != null ||
        errorTextRepassword != null) {
      _btnDisabled = true;
    } else {
      for (var entry in inputControllers.entries) {
        if (entry.value.text == '') {
          _btnDisabled = true;
          break;
        }
      }
    }

    if (_btnDisabled != btnDisabled) {
      setState(() {
        btnDisabled = _btnDisabled;
      });
    }
  }

  void _validFullname(String? value) {
    setState(() {
      errorTextFullname = value != null && value.length < 6
          ? 'Họ và tên phải lớn hơn 6 ký tự'
          : null;
    });

    updateButtonState();
  }

  void _validRePassword(String? value) {
    setState(() {
      errorTextRepassword = value != inputControllers['password']!.text
          ? 'Nhập lại mật khẩu không đúng'
          : null;
    });

    updateButtonState();
  }

  void onChangePassword(String? value) {
    if (value == null || value == '') {
      setState(() {
        errorTextPassword = null;
        regexPassword = Map.from(regexPassword).map((key, value) {
          return MapEntry(key, {
            'label': value['label'],
            'isPassed': false,
          });
        });
      });

      updateButtonState();
      return;
    }

    int totalPassed = 0;

    regexPassword['min']['isPassed'] = value.length > 6;
    regexPassword['uppercase']['isPassed'] = RegExp(r'[A-Z]').hasMatch(value);
    regexPassword['lowercase']['isPassed'] = RegExp(r'[a-z]').hasMatch(value);
    regexPassword['digital']['isPassed'] = RegExp(r'[\d]').hasMatch(value);
    regexPassword['special']['isPassed'] =
        RegExp(r'[\!@#\$%\^&\*\(\),\.\/\\]').hasMatch(value);

    for (final entry in regexPassword.entries) {
      if (entry.value['isPassed']) {
        totalPassed++;
      }
    }

    String rePassword = inputControllers['rePassword']!.text;
    setState(() {
      regexPassword = regexPassword;
      errorTextPassword = totalPassed == 5 ? null : 'Mật khẩu không hợp lệ';
      errorTextRepassword = rePassword == '' || rePassword == value
          ? null
          : 'Nhập lại mật khẩu không đúng';
    });

    updateButtonState();
  }

  void _submitForm(thisContext) async {
    setState(() {
      btnLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      btnLoading = false;
    });

    String fullname = inputControllers['fullname']!.text;
    String password = inputControllers['password']!.text;

    if (fullname.toLowerCase() == 'nhatdote' || User.isExist(widget.phone)) {
      Toast.showError('$fullname đã được sử dụng!');
      return;
    }

    SharedPreferences prefs = DB.prefs;
    prefs.setBool(DB.skipOnBoarding, true);

    bool store = await User.store(
      User(
        id: const Uuid().v4(),
        fullname: fullname,
        password: Fs.hash(password),
        phone: '0${widget.phone}',
      ),
    );

    if (store) {
      Navigator.pushNamedAndRemoveUntil(
          thisContext, AppRoute.registerSuccess, (route) => false);
    } else {
      Navigator.push(
        thisContext,
        MaterialPageRoute(
          builder: (_) => const ErrorScreen(
            messsage: "Oops... Tạo mới tài khoản không thành công!",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          color: AppColor.neutral,
        ),
        title: const Text(
          'Tạo tài khoản',
          style: TextStyle(
            color: AppColor.neutral,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: KeyboardDismissOnTap(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: AppSpace.md,
              horizontal: AppSpace.xl,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: AppSpace.xl),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: AppSpace.xl),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                      text: 'Họ và tên',
                                      style: AppStyle.textLabel,
                                      children: [
                                        TextSpan(
                                            text: ' *',
                                            style: TextStyle(color: Colors.red))
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: AppSpace.xs),
                                  TextFormField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    onChanged: _validFullname,
                                    controller: inputControllers['fullname'],
                                    decoration: InputDecoration(
                                        hintText: 'Điền tên của bạn ở đây',
                                        errorText: errorTextFullname),
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
                                  RichText(
                                    text: const TextSpan(
                                      text: 'Mật khẩu',
                                      style: AppStyle.textLabel,
                                      children: [
                                        TextSpan(
                                            text: ' *',
                                            style: TextStyle(color: Colors.red))
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: AppSpace.xs),
                                  TextFormField(
                                    obscureText: !showPassword,
                                    controller: inputControllers['password'],
                                    onChanged: onChangePassword,
                                    decoration: InputDecoration(
                                      hintText: 'Điền mật khẩu của bạn ở đây',
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
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Column(
                                      children: regexPassword.entries.map(
                                        (entry) {
                                          final value = entry.value;

                                          return RegexPasswordWidget(
                                            label: value['label'],
                                            isPassed: value['isPassed'],
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: const TextSpan(
                                    text: 'Nhập lại mật khẩu',
                                    style: AppStyle.textLabel,
                                    children: [
                                      TextSpan(
                                          text: ' *',
                                          style: TextStyle(color: Colors.red))
                                    ],
                                  ),
                                ),
                                const SizedBox(height: AppSpace.xs),
                                TextFormField(
                                  onChanged: _validRePassword,
                                  controller: inputControllers['rePassword'],
                                  obscureText: !showRePassword,
                                  decoration: InputDecoration(
                                    hintText: 'Điền mật khẩu của bạn ở đây',
                                    errorText: errorTextRepassword,
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          showRePassword = !showRePassword;
                                        });
                                      },
                                      child: Icon(
                                        showRePassword
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: AppColor.neutral40,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  AppButton(
                    label: 'Đăng ký',
                    onTab: () => _submitForm(context),
                    disable: btnDisabled,
                    loading: btnLoading,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RegexPasswordWidget extends StatelessWidget {
  final String label;
  final bool isPassed;

  const RegexPasswordWidget({
    super.key,
    required this.label,
    this.isPassed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: isPassed ? 2 : 0),
          child: isPassed
              ? const Icon(
                  Icons.check,
                  size: 18,
                  color: Colors.green,
                )
              : const Text(
                  ' ',
                  style: TextStyle(fontSize: 12),
                ),
        ),
        Text(
          label,
          style: TextStyle(
            color: isPassed ? Colors.green : AppColor.neutral40,
            fontSize: 12,
            fontWeight: isPassed ? FontWeight.w600 : FontWeight.normal,
          ),
        )
      ],
    );
  }
}
