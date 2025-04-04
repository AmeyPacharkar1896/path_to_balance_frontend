import 'package:flutter/material.dart';
import 'package:frontend/modules/home/provider/home_provider.dart';
import 'package:frontend/modules/home/view/widgets/home_nav_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch user data when the HomeScreen is initialized
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    // Implement your data fetching logic here
    // For example, call a method from your HomeProvider
    await Provider.of<HomeProvider>(context, listen: false).loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          // appBar: AppBar(
          //   title: const Text("Home"),
          //   centerTitle: true,
          //   backgroundColor: Colors.indigo,
          //   foregroundColor: Colors.white,
          // ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo.shade100, Colors.indigo.shade50],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: provider.currentWidget,
          ),
          bottomNavigationBar: const HomeNavBar(),
        );
      },
    );
  }
}
