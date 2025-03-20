import 'package:flutter/material.dart';
import 'package:frontend/features/home/presentation/provider/home_provider.dart';
import 'package:frontend/features/home/presentation/widgets/home_nav_bar.dart';
import 'package:provider/provider.dart';
import '../widgets/home_drawer.dart';
import '../widgets/dashboard_content.dart';
import '../widgets/features_content.dart';
import '../widgets/profile_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // Wrap the HomeScaffold with a ChangeNotifierProvider for HomeProvider.
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: const HomeScaffold(),
    );
  }
}

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({Key? key}) : super(key: key);
  
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
          appBar: AppBar(
            title: const Text("Home"),
          ),
          drawer: const HomeDrawer(),
          body: pages[provider.currentIndex],
          bottomNavigationBar: const HomeBottomNavigationBar(),
        );
      },
    );
  }
}
