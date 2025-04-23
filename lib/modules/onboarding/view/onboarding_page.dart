import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:frontend/routes/app_routes.dart';
import 'package:frontend/modules/onboarding/view/widget/gradient_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  Future<void> _completeOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
    Navigator.pushReplacementNamed(context, AppRoutes.authScreen);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;
    final textTheme = theme.textTheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: IntroductionScreen(
          globalBackgroundColor: theme.scaffoldBackgroundColor,
          pages: [
            PageViewModel(
              title: "Welcome to Mental Health Support",
              body: "Start your journey to better mental health with personalized assessments and recommendations. Let's begin understanding your mental well-being.",
              image: GradientIcon(
                icon: Icons.health_and_safety,  // Better suited for health and wellness
                size: 175,
                gradientColors: [primary, secondary],
              ),
              decoration: PageDecoration(
                pageColor: theme.scaffoldBackgroundColor,
                imagePadding: const EdgeInsets.only(top: 40),
                contentMargin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                titleTextStyle: textTheme.headlineLarge!.copyWith(color: primary),
                bodyTextStyle: textTheme.bodyMedium!,
              ),
            ),
            PageViewModel(
              title: "Personalized Questionnaires",
              body: "Answer simple questionnaires that evaluate your mental well-being. Based on your responses, we'll give you personalized insights and advice.",
              image: GradientIcon(
                icon: Icons.list_alt,  // Represents assessments and lists
                size: 175,
                gradientColors: [primary, secondary],
              ),
              decoration: PageDecoration(
                pageColor: theme.scaffoldBackgroundColor,
                imagePadding: const EdgeInsets.only(top: 40),
                contentMargin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                titleTextStyle: textTheme.headlineLarge!.copyWith(color: primary),
                bodyTextStyle: textTheme.bodyMedium!,
              ),
            ),
            PageViewModel(
              title: "Daily & Weekly Tasks",
              body: "Receive daily and weekly tasks tailored to help you improve your mental health. Our goal is to support you with actionable steps.",
              image: GradientIcon(
                icon: Icons.task_alt,  // Represents tasks and checklists
                size: 175,
                gradientColors: [primary, secondary],
              ),
              decoration: PageDecoration(
                pageColor: theme.scaffoldBackgroundColor,
                imagePadding: const EdgeInsets.only(top: 40),
                contentMargin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                titleTextStyle: textTheme.headlineLarge!.copyWith(color: primary),
                bodyTextStyle: textTheme.bodyMedium!,
              ),
            ),
            PageViewModel(
              title: "Start Your Journey",
              body: "Take the first step towards a healthier mindset. Your journey to improved mental well-being begins now.",
              image: GradientIcon(
                icon: Icons.explore,  // Represents exploration and starting the journey
                size: 175,
                gradientColors: [primary, secondary],
              ),
              decoration: PageDecoration(
                pageColor: theme.scaffoldBackgroundColor,
                imagePadding: const EdgeInsets.only(top: 40),
                contentMargin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                titleTextStyle: textTheme.headlineLarge!.copyWith(color: primary),
                bodyTextStyle: textTheme.bodyMedium!,
              ),
            ),
          ],
          onDone: () => _completeOnboarding(context),
          onSkip: () => _completeOnboarding(context),
          showSkipButton: true,
          skip: Text(
            "Skip",
            style: textTheme.bodyMedium!.copyWith(color: primary),
          ),
          next: Icon(Icons.arrow_forward, color: primary),
          done: Text(
            "Done",
            style: textTheme.labelLarge,
          ),
          dotsDecorator: DotsDecorator(
            activeColor: primary,
            color: theme.colorScheme.onBackground.withOpacity(0.3),
            size: const Size(8, 8),
            activeSize: const Size(16, 8),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }
}
