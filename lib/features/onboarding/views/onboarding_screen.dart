import 'package:flutter/material.dart';
import 'package:task_management/core/res/app_colors.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:task_management/core/common/widgets/fading_text.dart';
import 'package:task_management/core/common/widgets/white_space.dart';
import 'package:task_management/features/onboarding/views/widgets/first_page.dart';
import 'package:task_management/features/onboarding/views/widgets/second_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              controller: pageController,
              children: const [FirstPage(), SecondPage()],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10)
                  .copyWith(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.bounceInOut);
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Ionicons.chevron_forward_circle,
                          size: 30,
                          color: AppColors.white,
                        ),
                        WhiteSpace(
                          width: 5,
                        ),
                        FadingText(
                          "Skip",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        )
                      ],
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: 2,
                    effect: WormEffect(
                      dotHeight: 12,
                      spacing: 10,
                      dotColor: AppColors.yellow.withOpacity(.5),
                      activeDotColor: AppColors.white,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
