import 'package:flutter/material.dart';
import 'package:frontend/features/home/presentation/provider/home_provider.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer header
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Text(
              "Menu",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          // Drawer items
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Home"),
            onTap: () {
              Provider.of<HomeProvider>(context, listen: false).setCurrentIndex(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.featured_play_list),
            title: const Text("Features"),
            onTap: () {
              Provider.of<HomeProvider>(context, listen: false).setCurrentIndex(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
            onTap: () {
              Provider.of<HomeProvider>(context, listen: false).setCurrentIndex(2);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
