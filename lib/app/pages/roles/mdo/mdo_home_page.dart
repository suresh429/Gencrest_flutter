import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:gencrest/app/controllers/mdo_bottom_nav_controller.dart';
import 'package:gencrest/app/pages/roles/mdo/mdo_schedule.dart';
import 'package:gencrest/app/pages/roles/mdo/mdo_reports_screen.dart';
import 'package:gencrest/app/pages/roles/mdo/mdo_tasks_screen.dart';
import 'mdo_liquidation_screen.dart';
import 'mdo_dashboard.dart';

import '../../../utils/colors.dart';
import '../../../utils/gradient_appbar.dart';

class MDOHomePage extends StatelessWidget {
  MDOHomePage({super.key});

  final MdoBottomNavController controller = Get.put(MdoBottomNavController());

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
        onMenuTap: null,
      ),

      // Body controlled by GetX
      body: Obx(() => _tabs[controller.selectedIndex.value]),

      // Bottom Navigation Bar
      bottomNavigationBar: Obx(
            () => NavigationBar(
          backgroundColor: Colors.white,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.changeTab(index),
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
      ),
    );
  }
}
