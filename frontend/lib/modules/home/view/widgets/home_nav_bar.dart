import 'package:flutter/material.dart';
import 'package:frontend/modules/tasks/pages/task_content.dart';
import 'package:provider/provider.dart';
import 'package:frontend/modules/home/view_model/home_provider.dart';
import 'package:frontend/modules/home/view/widgets/dashboard_content.dart';

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
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return BottomNavigationBar(
          currentIndex: provider.selectedIndex,
          onTap: (index) {
            // Update the provider with the new widget and index.
            provider.setCurrentWidgetAndIndex(
              widget: pages[index],
              index: index,
            );
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tasks'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        );
      },
    );
  }
}
