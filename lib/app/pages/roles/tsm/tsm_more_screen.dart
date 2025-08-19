import 'package:flutter/material.dart';
import 'package:gencrest/app/pages/roles/tsm/tsm_alert_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../mdo/mdo_log_new_entry_screen.dart';

class TsmMoreScreen extends StatelessWidget {
  const TsmMoreScreen({super.key});

  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: iconColor, size: 28),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B), // dark text color
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (trailing != null) trailing,
            const Icon(Icons.chevron_right, color: Color(0xFF94A3B8)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // light background
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildMenuItem(
              icon: Icons.bar_chart_rounded,
              iconColor: Color(0xFF7C3AED),
              title: "Reports",
            ),
            _buildMenuItem(
              icon: Icons.warning_amber_rounded,
              iconColor: Color(0xFFE11D48),
              title: "Critical Alerts",
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFFFFE4E6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "3",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE11D48),
                  ),
                ),
              ),
              onTap: () {
                // Handle critical alerts tap
                Get.to(() => TsmAlertScreen());
              },
            ),
            _buildMenuItem(
              icon: Icons.settings,
              iconColor: Color(0xFF334155),
              title: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
