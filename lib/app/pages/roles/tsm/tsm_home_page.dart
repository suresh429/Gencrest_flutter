import 'package:flutter/material.dart';
import 'package:gencrest/app/pages/roles/tsm/tsm_Liquidation_screen.dart';
import 'package:gencrest/app/pages/roles/tsm/tsm_alert_screen.dart';
import 'package:gencrest/app/pages/roles/tsm/tsm_reports_screen.dart';
import 'package:gencrest/app/pages/roles/tsm/tsm_team_page.dart';
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

  final List<Widget> _tabs = [
    TSMHomeDashboard(),
    TsmTeamPage(),
    TsmLiquidationScreen(),
    TsmAlertScreen(),
    TsmReportsScreen(),

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
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_alt_outlined),
            selectedIcon: Icon(Icons.people_alt),
            label: 'Team',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_outlined),
            selectedIcon: Icon(Icons.inventory),
            label: 'Liquidation',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Reports',
          ),

        ],
      ),
    );
  }
}
