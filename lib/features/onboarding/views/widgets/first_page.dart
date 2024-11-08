import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import '../../../../core/res/image_res.dart';
import '../../../../core/res/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/common/widgets/fading_text.dart';
import '../../../../core/common/widgets/white_space.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(ImageRes.onboarding),
          const WhiteSpace(height: 100),
          const FadingText(
            'Todo with Riverpod',
            fontSize: 30,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
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
          ),
        ],
      ),
    );
  }
}
