import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:provider/provider.dart';
import 'package:frontend/modules/home/provider/home_provider.dart';
import 'package:frontend/modules/home/view/widgets/dashboard_content.dart';
import 'package:frontend/modules/tasks/view/task_content.dart';
import 'package:frontend/modules/home/view/widgets/profile_content.dart';

class HomeNavBar extends StatelessWidget {
  const HomeNavBar({Key? key}) : super(key: key);

  // Define your pages so the nav bar can send the widget directly.
  static const List<Widget> pages = [
    DashboardContent(),
    TaskContent(),
    ProfileContent(),
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate the nav bar height as a percentage of the screen height.
    final screenHeight = MediaQuery.of(context).size.height;
    final navBarHeight = screenHeight * 0.08; // 8% of screen height

    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return ConvexAppBar(
          height: navBarHeight,
          style: TabStyle.reactCircle,
          items: const [
            TabItem(icon: Icons.dashboard, title: 'Dashboard'),
            TabItem(icon: Icons.list, title: 'Tasks'),
            TabItem(icon: Icons.person, title: 'Profile'),
          ],
          initialActiveIndex: provider.selectedIndex,
          backgroundColor: const Color(0xFFD98324), // Accent Orange color
          activeColor: Colors.white,
          color: Colors.white70,
          onTap: (int index) {
            provider.setCurrentWidgetAndIndex(
              widget: pages[index],
              index: index,
            );
          },
        );
      },
    );
  }
}
