import 'package:flutter/material.dart';
import 'package:gencrest/app/controllers/tsm_bottom_nav_controller.dart';
import 'package:gencrest/app/pages/roles/tsm/tsm_Liquidation_screen.dart';
import 'package:gencrest/app/pages/roles/tsm/tsm_alert_screen.dart';
import 'package:gencrest/app/pages/roles/tsm/tsm_dashboard.dart';
import 'package:gencrest/app/pages/roles/tsm/tsm_reports_screen.dart';
import 'package:gencrest/app/pages/roles/tsm/tsm_team_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/colors.dart';
import '../../../utils/gradient_appbar.dart';

class TSMHomePage extends StatelessWidget {
  final TsmBottomNavController controller = Get.put(TsmBottomNavController());

  final List<Widget> _tabs = [
    TSMHomeDashboard(),
    TsmTeamPage(),
    TsmLiquidationScreen(),
    TsmAlertScreen(),
    TsmReportsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: GradientAppBar(
        name: "S.varma",
        location: "TSM • Delhi North",
        onNotificationTap: () {
          // Handle notifications
        },
        onMenuTap: null,
      ),
      body: _tabs[controller.selectedIndex.value],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        selectedIndex: controller.selectedIndex.value,
        onDestinationSelected: controller.changeTab,
        indicatorColor: AppColors.bottomNavColor.withOpacity(0.2),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Dashboard'),
          NavigationDestination(
              icon: Icon(Icons.people_alt_outlined),
              selectedIcon: Icon(Icons.people_alt),
              label: 'Team'),
          NavigationDestination(
              icon: Icon(Icons.inventory_outlined),
              selectedIcon: Icon(Icons.inventory),
              label: 'Liquidation'),
          NavigationDestination(
              icon: Icon(Icons.notifications_outlined),
              selectedIcon: Icon(Icons.notifications),
              label: 'Alerts'),
          NavigationDestination(
              icon: Icon(Icons.bar_chart_outlined),
              selectedIcon: Icon(Icons.bar_chart),
              label: 'Reports'),
        ],
      ),
    ));
  }
}
