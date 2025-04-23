import 'package:flutter/material.dart';
import 'package:frontend/modules/onboarding/view/widget/gradient_icon.dart';
import 'package:introduction_screen/introduction_screen.dart';

PageViewModel buildOnboardingPageViewModel(
  BuildContext context, {
  required String title,
  required String body,
  required IconData icon,
  required List<Color> gradientColors,
}) {
  final theme = Theme.of(context);
  final textTheme = theme.textTheme;

  return PageViewModel(
    title: title,
    body: body,
    image: GradientIcon(
      icon: icon,
      gradientColors: gradientColors,
      size: 96,
    ),
    decoration: PageDecoration(
      pageColor: theme.scaffoldBackgroundColor,
      imagePadding: const EdgeInsets.only(top: 40),
      contentMargin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      titleTextStyle: textTheme.headlineLarge!.copyWith(
        color: theme.colorScheme.primary,
      ),
      bodyTextStyle: textTheme.bodyMedium!,
      // You can adjust these if you need more control:
      titlePadding: const EdgeInsets.only(top: 24),
      bodyPadding: const EdgeInsets.only(top: 12),
    ),
  );
}
