import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '/extensions/nav_extensions.dart';
import 'views/home_view.dart';
import 'views/second_view.dart';
import '/home/ui/widgets/bottom_navigation_bar_widget.dart';

class MainPage extends ConsumerStatefulWidget {
  final Widget child;

  const MainPage({
    super.key,
    required this.child,
  });

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends ConsumerState<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        context.navigate(HomeView.routeName);
        break;
      case 1:
        context.navigate(SecondView.routeName);
        break;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBarWidget(selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
    );
  }
}
