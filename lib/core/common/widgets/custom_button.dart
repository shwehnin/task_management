import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management/core/res/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final double? width;
  final double? height;
  final Color? color;
  final bool? isClose;
  const CustomButton({
    super.key,
    required this.label,
    required this.onTap,
    this.width,
    this.height,
    this.color,
    this.isClose = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Get.isDarkMode
                ? AppColors.darkBackground
                : isClose == true
                    ? Colors.transparent
                    : color,
            border: Border.all(
                width: 2,
                color: isClose == true
                    ? Get.isDarkMode
                        ? Colors.grey[600]!
                        : Colors.grey[300]!
                    : color!)),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.acme(
              textStyle: TextStyle(
                fontSize: 18,
                color: isClose == true
                    ? Get.isDarkMode
                        ? Colors.white
                        : Colors.grey[600]
                    : AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
