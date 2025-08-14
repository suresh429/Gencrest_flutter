import 'package:flutter/material.dart';
import '../../../utils/colors.dart';
import '../../../utils/gradient_appbar.dart';
import 'tsm_dashboard.dart';

class TSMHomePage extends StatefulWidget {
  const TSMHomePage({super.key});

  @override
  State<TSMHomePage> createState() => _TSMHomePageState();
}

class _TSMHomePageState extends State<TSMHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = const [
    TSMHomeDashboard(),
    Center(child: Text('Team Page')),
    Center(child: Text('Alerts Page')),
    Center(child: Text('Reports Page')),
    Center(child: Text('Settings Page')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        name: "S.varma",
        location: "TSM • Delhi North",
        onNotificationTap: () {
          // Handle notifications
        },
        onMenuTap: () {
          // Handle menu
        },
      ),
      body: _tabs[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        indicatorColor: AppColors.bottomNavColor.withOpacity(0.2),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.groups_outlined),
            selectedIcon: Icon(Icons.groups),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_alt_outlined),
            selectedIcon: Icon(Icons.people_alt),
            label: 'Team',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          NavigationDestination(
            icon: Icon(Icons.file_copy_outlined),
            selectedIcon: Icon(Icons.file_copy),
            label: 'Reports',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
