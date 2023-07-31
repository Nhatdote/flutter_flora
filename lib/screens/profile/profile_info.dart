import 'package:flora/constans/asset.dart';
import 'package:flora/constans/color.dart';
import 'package:flora/constans/constant.dart';
import 'package:flora/constans/space.dart';
import 'package:flora/constans/style.dart';
import 'package:flora/getx/auth_state.dart';
import 'package:flora/models/user.dart';
import 'package:flora/shared/toast.dart';
import 'package:flora/widgets/app_header.dart';
import 'package:flora/widgets/button/icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  final AuthState auth = Get.find();

  @override
  Widget build(BuildContext context) {
    final User loginUser = auth.loginUser.value!;

    return Scaffold(
      appBar: const SimpleAppHeader('Thông tin cá nhân'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.xl),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: AppSpace.xl),
                width: 100,
                height: 100,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Image.asset(
                  'assets/images/avatar.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              InfoWidget(
                  label: 'Tên', value: loginUser.fullname, field: 'fullname'),
              InfoWidget(
                  label: 'Điện thoại',
                  value: '********${loginUser.phone.substring(8)}',
                  field: 'phone'),
              const InfoWidget(
                  label: 'Mật khẩu', value: '********', field: 'password'),
              InfoWidget(
                  label: 'Địa chỉ nhận hàng',
                  value: loginUser.address ?? '',
                  field: 'address'),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    super.key,
    required this.label,
    required this.value,
    required this.field,
  });

  final String label;
  final String value;
  final String field;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpace.xl),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.md,
          vertical: AppSpace.xs,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(AppConstant.borderRadius),
          ),
          boxShadow: [AppStyle.boxShadowSm],
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: AppSpace.xxl),
                child: Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: Text(value),
            ),
            AppIconButton(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return EditDialog(field);
                  },
                );
              },
              Image.asset(
                Asset.iconEdit,
                height: 20,
                color: AppColor.neutral,
                fit: BoxFit.contain,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EditDialog extends StatelessWidget {
  const EditDialog(this.editField, {super.key});

  final String editField;

  @override
  Widget build(BuildContext context) {
    final AuthState auth = Get.find();
    final User loginUser = auth.loginUser.value!;
    final TextEditingController controller = TextEditingController(
      text: loginUser.getFieldValue(editField),
    );

    final Map<String, String> map = {
      'fullname': 'tên hiển thị',
      'phone': 'số điện thoại',
      'password': 'mật khẩu',
      'address': 'Địa chỉ nhận hàng'
    };

    return AlertDialog(
      elevation: 0,
      title: Text('Cập nhật ${map[editField]}'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TextField(
          keyboardType: TextInputType.phone,
          controller: controller,
          onChanged: (value) => () {},
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Huỷ'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Toast.showSuccess('OK rồi đó, nhưng ấn cho vui thôi :))');
          },
          child: const Text('Lưu'),
        ),
      ],
    );
  }
}
