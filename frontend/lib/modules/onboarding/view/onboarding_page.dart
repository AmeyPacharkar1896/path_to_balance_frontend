// lib/modules/onboarding/view/onboarding_page.dart
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:frontend/routes/app_routes.dart';
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
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "Welcome",
          body:
              "Discover the amazing features of our app. Get started quickly and effortlessly!",
          image: Center(child: Icon(Icons.mobile_friendly, size: 175.0, color: Colors.blueAccent)),
          decoration: PageDecoration(
            titleTextStyle: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.blueAccent),
            bodyTextStyle: const TextStyle(fontSize: 18.0, color: Colors.black87),
          ),
        ),
        PageViewModel(
          title: "Easy to Use",
          body: "Our app is simple and intuitive.",
          image: Center(child: Icon(Icons.touch_app, size: 175.0, color: Colors.green)),
          decoration: PageDecoration(
            titleTextStyle: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.green),
            bodyTextStyle: const TextStyle(fontSize: 18.0, color: Colors.black87),
          ),
        ),
        PageViewModel(
          title: "Get Started",
          body: "Let's begin your journey!",
          image: Center(child: Icon(Icons.play_circle_fill, size: 175.0, color: Colors.purple)),
          decoration: PageDecoration(
            titleTextStyle: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.purple),
            bodyTextStyle: const TextStyle(fontSize: 18.0, color: Colors.black87),
          ),
        ),
      ],
      onDone: () => _completeOnboarding(context),
      onSkip: () => _completeOnboarding(context),
      showSkipButton: true,
      skip: const Text("Skip"),
      next: const Icon(Icons.arrow_forward),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
