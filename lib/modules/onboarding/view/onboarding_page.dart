// lib/modules/onboarding/view/onboarding_page.dart
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
              title: "Welcome",
              body:
                  "Discover the amazing features of our app. Get started quickly and effortlessly!",
              image: GradientIcon(
                icon: Icons.mobile_friendly,
                size: 175,
                gradientColors: [primary, secondary],
              ),
              decoration: PageDecoration(
                pageColor: theme.scaffoldBackgroundColor,
                imagePadding: const EdgeInsets.only(top: 40),
                contentMargin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                titleTextStyle: textTheme.headlineLarge!
                    .copyWith(color: primary),
                bodyTextStyle: textTheme.bodyMedium!,
              ),
            ),
            PageViewModel(
              title: "Easy to Use",
              body: "Our app is simple and intuitive.",
              image: GradientIcon(
                icon: Icons.touch_app,
                size: 175,
                gradientColors: [primary, secondary],
              ),
              decoration: PageDecoration(
                pageColor: theme.scaffoldBackgroundColor,
                imagePadding: const EdgeInsets.only(top: 40),
                contentMargin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                titleTextStyle: textTheme.headlineLarge!
                    .copyWith(color: primary),
                bodyTextStyle: textTheme.bodyMedium!,
              ),
            ),
            PageViewModel(
              title: "Get Started",
              body: "Let's begin your journey!",
              image: GradientIcon(
                icon: Icons.play_circle_fill,
                size: 175,
                gradientColors: [primary, secondary],
              ),
              decoration: PageDecoration(
                pageColor: theme.scaffoldBackgroundColor,
                imagePadding: const EdgeInsets.only(top: 40),
                contentMargin:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                titleTextStyle: textTheme.headlineLarge!
                    .copyWith(color: primary),
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
