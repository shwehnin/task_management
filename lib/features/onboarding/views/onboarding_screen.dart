import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_management/core/res/image_res.dart';
import 'package:task_management/core/res/app_colors.dart';
import 'package:task_management/core/common/white_space.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(ImageRes.onboarding),
              const WhiteSpace(height: 100),
              Text(
                'Todo with Riverpod',
                style: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: AppColors.light),
                textAlign: TextAlign.center,
              ),
              const WhiteSpace(height: 10),
              Text(
                "Welcome!! Do you want to clear tasks super fast with Todo?",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: AppColors.lightGray,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
