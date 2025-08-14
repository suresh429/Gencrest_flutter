import 'package:flutter/material.dart';
import 'package:gencrest/app/utils/colors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controllers/reports_controller.dart';

class MdoReportsScreen extends StatelessWidget {
  final ReportsController controller = Get.put(ReportsController());

  MdoReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Text(
                  "My Performance",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
            
                // Row of two stat cards
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        icon: Icons.location_on_outlined,
                        iconColor: Colors.purple,
                        title: "This Month",
                        value: "28",
                        subtitle: "visits completed",
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        icon: Icons.trending_up,
                        iconColor: Colors.pink,
                        title: "Success Rate",
                        value: "94%",
                        subtitle: "task completion",
                      ),
                    ),
                  ],
                ),
            
                const SizedBox(height: 12),
            
                // Weekly Activity
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 1,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Weekly Activity",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.bar_chart, color: Colors.grey[400], size: 32),
                              const SizedBox(height: 8),
                              Text(
                                "Activity chart will appear here",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                /// ---- Recent Achievements ----
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 1,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Recent Achievements",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 12),
            
                        // Dynamic List
                        SizedBox(
                         // height: 120, // limit height so it doesn't take full screen
                          child: Obx(() {
                            return ListView.builder(
                              shrinkWrap: true, // Let it size to its content
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.achievements.length,
                              itemBuilder: (context, index) {
                                final ach = controller.achievements[index];
                                return _achievementCard(
                                  icon: ach["icon"] as String,
                                  title: ach["title"] as String,
                                  subtitle: ach["subtitle"] as String,
                                  bgColor: Color(ach["color"] as int),
                                );
                              },
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                )
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Achievement Card
Widget _achievementCard({
  required String icon,
  required String title,
  required String subtitle,
  required Color bgColor,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        // Icon container
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: bgColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Text(icon, style: const TextStyle(fontSize: 18)), // Emoji or icon
        ),
        const SizedBox(width: 12),
        // Texts
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        )
      ],
    ),
  );
}



class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;
  final String subtitle;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],

            ),

            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
