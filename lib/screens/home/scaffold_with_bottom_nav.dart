import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wedring/utils/helper.dart';

class ScaffoldWithBottomNav extends StatefulWidget {
  final Widget child;

  const ScaffoldWithBottomNav({super.key, required this.child});

  @override
  State<ScaffoldWithBottomNav> createState() => _ScaffoldWithBottomNav();
}

class _ScaffoldWithBottomNav extends State<ScaffoldWithBottomNav> {
  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  int _locationToTabIndex(String location) {
    final index =
        tabs.indexWhere((t) => location.startsWith(t.initialLocation));
    // if index not found (-1), return 0
    return index < 0 ? 0 : index;
  }

  void _onItemTapped(BuildContext context, int tabIndex) {
    if (tabIndex != _currentIndex) {
      // go to the initial location of the selected tab (by index)
      context.go(tabs[tabIndex].initialLocation);
    }
  }

  final tabs = [
    const ScaffoldWithNavBarTabItem(
      initialLocation: '/home',
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    const ScaffoldWithNavBarTabItem(
      initialLocation: '/my-matches',
      icon: Icon(Icons.auto_awesome),
      label: 'My Matches',
    ),
    const ScaffoldWithNavBarTabItem(
      initialLocation: '/chat',
      icon: Icon(Icons.chat_bubble_outline),
      label: 'Chat',
    ),
    const ScaffoldWithNavBarTabItem(
      initialLocation: '/profile',
      icon: Icon(Icons.person_outlined),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: AppManager.scaffoldKey,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(
            'assets/images/logo.png',
          ),
        ),
        title: Text(
          tabs[_currentIndex].label!,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(
            child: widget.child,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: tabs,
        currentIndex: _currentIndex,
        onTap: (index) => _onItemTapped(context, index),
      ),
    );
  }
}

class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  const ScaffoldWithNavBarTabItem(
      {required this.initialLocation, required Widget icon, String? label})
      : super(icon: icon, label: label);

  final String initialLocation;
}
