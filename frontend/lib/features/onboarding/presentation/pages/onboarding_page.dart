import 'package:flutter/material.dart';
import 'package:frontend/features/onboarding/presentation/helpers/onboarding_helpers.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:frontend/routes/app_routes.dart'; // Import the routes

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        buildOnboardingPageViewModel(
          title: "Welcome",
          body:
              "Discover the amazing features of our app. Get started quickly and effortlessly!",
          icon: Icons.mobile_friendly,
          gradientColors: [Colors.blueAccent, Colors.lightBlueAccent],
          titleStyle: const TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
          bodyStyle: const TextStyle(fontSize: 18.0, color: Colors.black87),
        ),
        buildOnboardingPageViewModel(
          title: "Easy to Use",
          body: "Our app is simple and intuitive.",
          icon: Icons.touch_app,
          gradientColors: [Colors.green, Colors.lightGreenAccent],
          titleStyle: const TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
          bodyStyle: const TextStyle(fontSize: 18.0, color: Colors.black87),
        ),
        buildOnboardingPageViewModel(
          title: "Get Started",
          body: "Let's begin your journey!",
          icon: Icons.play_circle_fill,
          gradientColors: [Colors.purple, Colors.deepPurpleAccent],
          titleStyle: const TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
          bodyStyle: const TextStyle(fontSize: 18.0, color: Colors.black87),
        ),
      ],
      onDone: () {
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      },
      onSkip: () {
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      },
      showSkipButton: true,
      skip: const Text("Skip"),
      next: const Icon(Icons.arrow_forward),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
