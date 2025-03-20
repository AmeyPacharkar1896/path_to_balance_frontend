import 'package:flutter/material.dart';
import 'package:frontend/features/home/presentation/provider/home_provider.dart';
import 'package:provider/provider.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return BottomNavigationBar(
          currentIndex: provider.currentIndex,
          onTap: (index) {
            provider.setCurrentIndex(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.featured_play_list),
              label: "Features",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        );
      },
    );
  }
}
