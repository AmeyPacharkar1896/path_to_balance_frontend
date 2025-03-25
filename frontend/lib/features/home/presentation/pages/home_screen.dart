import 'package:flutter/material.dart';
import 'package:frontend/features/home/presentation/provider/home_provider.dart';
import 'package:frontend/features/home/presentation/widgets/dashboard_content.dart';
import 'package:frontend/features/home/presentation/widgets/features_content.dart';
import 'package:frontend/features/home/presentation/widgets/home_drawer.dart';
import 'package:frontend/features/home/presentation/widgets/home_nav_bar.dart';
import 'package:frontend/features/home/presentation/widgets/profile_content.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        // List of page content widgets
        final pages = [
          const DashboardContent(),
          const FeaturesContent(),
          const ProfileContent(),
        ];
        return Scaffold(
          appBar: AppBar(title: const Text("Home")),
          drawer: const HomeDrawer(),
          body: pages[provider.currentIndex],
          bottomNavigationBar: const HomeBottomNavigationBar(),
        );
      },
    );
  }
}
