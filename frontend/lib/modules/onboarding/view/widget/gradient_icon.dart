import 'package:flutter/material.dart';

class GradientIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final List<Color> gradientColors;
  final Color iconColor;
  final EdgeInsets padding;

  const GradientIcon({
    Key? key,
    required this.icon,
    this.size = 100,
    required this.gradientColors,
    this.iconColor = Colors.white,
    this.padding = const EdgeInsets.all(16.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Icon(icon, size: size, color: iconColor),
      ),
    );
  }
}
