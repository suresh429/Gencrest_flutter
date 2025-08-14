import 'package:flutter/material.dart';
import 'package:gencrest/app/pages/roles/mdo/mdo_schedule.dart';
import 'package:gencrest/app/pages/roles/mdo/mdo_reports_screen.dart';
import 'package:gencrest/app/pages/roles/mdo/mdo_tasks_screen.dart';
import '../../../utils/colors.dart';
import '../../../utils/gradient_appbar.dart';
import 'mdo_Liquidation_screen.dart';
import 'mdo_dashboard.dart';

class MDOHomePage extends StatefulWidget {
  const MDOHomePage({super.key});

  @override
  State<MDOHomePage> createState() => _MDOHomePageState();
}

class _MDOHomePageState extends State<MDOHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    const MDOHomeDashboard(),
    MDOSchedulePage(),
    MdoTasksScreen(),
    LiquidationScreen(),
    MdoReportsScreen(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        name: "Rajesh Kumar",
        location: "MDO • Delhi North",
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
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: 'Schedule',
          ),
          NavigationDestination(
            icon: Icon(Icons.task_alt_outlined),
            selectedIcon: Icon(Icons.task_alt),
            label: 'Tasks',
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_outlined),
            selectedIcon: Icon(Icons.inventory),
            label: 'Liquidation',
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
