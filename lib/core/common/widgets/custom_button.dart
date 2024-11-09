import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:task_management/core/res/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const CustomButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Get.isDarkMode
              ? AppColors.darkBackground
              : AppColors.primaryColor,
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
