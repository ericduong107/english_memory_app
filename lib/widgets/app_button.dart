import 'package:english_memory_app/values/app_colors.dart';
import 'package:english_memory_app/values/app_styles.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback opTap;
  const AppButton({super.key, required this.label, required this.opTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        opTap();
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          boxShadow: [
            BoxShadow(
                color: AppColors.shadowColor,
                offset: const Offset(0, 4),
                blurRadius: 4),
          ],
        ),
        child: Text(
          label,
          style: AppStyle.h5.copyWith(color: AppColors.textColor),
        ),
      ),
    );
  }
}
