import 'package:flutter/material.dart';

class FeaturesContent extends StatelessWidget {
  const FeaturesContent({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Explore the Features",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
