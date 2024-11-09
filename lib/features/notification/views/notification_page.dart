import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:task_management/core/res/app_colors.dart';

class NotificationPage extends StatelessWidget {
  final String label;
  const NotificationPage({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.isDarkMode ? Colors.grey[600] : AppColors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Get.isDarkMode ? AppColors.white : AppColors.darkGray,
          ),
        ),
        title: Text(
          label.split("|")[0],
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Get.isDarkMode ? AppColors.white : AppColors.darkBackground,
          ),
          child: Center(
            child: Text(
              label.split("|")[1],
              style: TextStyle(
                  color: Get.isDarkMode ? Colors.black : AppColors.white,
                  fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }
}
