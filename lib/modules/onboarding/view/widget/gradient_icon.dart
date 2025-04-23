import 'package:flutter/material.dart';

/// A circular icon widget with a customizable gradient background and shadow.
class GradientIcon extends StatelessWidget {
  /// The icon to display.
  final IconData icon;

  /// The size of the icon inside the gradient circle.
  final double size;

  /// The gradient colors for the background circle.
  final List<Color> gradientColors;

  /// The color of the icon. Defaults to white.
  final Color iconColor;

  /// The padding around the icon inside the circle.
  final EdgeInsets padding;

  /// Creates a [GradientIcon].
  ///
  /// [gradientColors] must not be empty. [iconColor] defaults to white if null.
  const GradientIcon({
    Key? key,
    required this.icon,
    this.size = 100,
    required this.gradientColors,
    Color? iconColor,
    this.padding = const EdgeInsets.all(20.0),
  }) : iconColor = iconColor ?? Colors.white,
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(icon, size: size, color: iconColor),
    );
  }
}
