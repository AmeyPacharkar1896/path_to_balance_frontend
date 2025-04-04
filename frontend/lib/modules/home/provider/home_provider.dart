import 'package:flutter/material.dart';
import 'package:frontend/modules/home/view/widgets/dashboard_content.dart';

class HomeProvider extends ChangeNotifier {
  Widget _currentWidget = const DashboardContent();
  int _selectedIndex = 0;

  Widget get currentWidget => _currentWidget;
  int get selectedIndex => _selectedIndex;

  void setCurrentWidgetAndIndex({required Widget widget, required int index}) {
    _currentWidget = widget;
    _selectedIndex = index;
    notifyListeners();
  }

  Future<void> loadUserData() async {
    // Add your data fetching logic here
    // For example, make an API call to retrieve user information
    // Once data is fetched, update the necessary state and notify listeners
  }
}
