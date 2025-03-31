import 'package:flutter/material.dart';
import 'package:frontend/modules/home/view_model/home_provider.dart';
import 'package:frontend/modules/home/view/widgets/home_nav_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Home")),
          // The provider holds the current widget to display.
          body: provider.currentWidget,
          bottomNavigationBar: const HomeNavBar(),
        );
      },
    );
  }
}

