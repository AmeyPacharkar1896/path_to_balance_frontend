import 'package:flutter/material.dart';
import 'package:frontend/features/onboarding/presentation/widget/gradient_icon.dart';
import 'package:introduction_screen/introduction_screen.dart';

PageViewModel buildOnboardingPageViewModel({
  required String title,
  required String body,
  required IconData icon,
  required List<Color> gradientColors,
  required TextStyle titleStyle,
  required TextStyle bodyStyle,
}) {
  return PageViewModel(
    title: title,
    body: body,
    image: GradientIcon(
      icon: icon,
      gradientColors: gradientColors,
    ),
    decoration: PageDecoration(
      pageColor: Colors.white,
      imagePadding: const EdgeInsets.only(top: 50.0),
      contentMargin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      titleTextStyle: titleStyle,
      bodyTextStyle: bodyStyle,
    ),
  );
}
