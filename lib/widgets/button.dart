import 'package:flora/constans/color.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTab;
  final bool disable;
  final bool loading;

  const AppButton({
    super.key,
    required this.label,
    this.onTab,
    this.disable = false,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (disable || loading) ? null : onTab,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color:
                disable ? AppColor.primary.withOpacity(0.3) : AppColor.primary,
          ),
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 50,
            child: loading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ))
                : Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
