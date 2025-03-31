import 'package:flutter/material.dart';
import 'package:frontend/modules/home/view/widgets/dashboard_content.dart';

class HomeProvider extends ChangeNotifier {
  // Initialize with the Dashboard as the default widget and index 0.
  Widget _currentWidget = const DashboardContent();
  int _selectedIndex = 0;

  Widget get currentWidget => _currentWidget;
  int get selectedIndex => _selectedIndex;

  // Update the current widget and selected index, then notify listeners.
  void setCurrentWidgetAndIndex({required Widget widget, required int index}) {
    _currentWidget = widget;
    _selectedIndex = index;
    notifyListeners();
  }
}
