import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import '../../../../core/res/image_res.dart';
import '../../../../core/common/widgets/white_space.dart';
import 'package:task_management/core/common/widgets/round_button.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(ImageRes.onboarding),
          const WhiteSpace(height: 50),
          RoundButton(
            text: "Login with Phone",
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
