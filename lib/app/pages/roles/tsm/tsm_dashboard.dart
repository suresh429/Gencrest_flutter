import 'package:flutter/material.dart';
import 'package:gencrest/app/controllers/tsm_dashboard_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/colors.dart';

class TSMHomeDashboard extends  StatelessWidget {
final TsmDashboardController controller = Get.put(TsmDashboardController());

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey[100],
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row Cards
            Row(
              children: [
                Expanded(
                  child: _statCard(
                      color: Colors.purple,
                      title: "Team Members",
                      value: "8",
                      subtitle: "6 active today"),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statCard(
                      color: Colors.pink,
                      title: "Today's Visits",
                      value: "24",
                      subtitle: "18 completed"),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Live Meetings
            Card(
              elevation: 1,
              color: Colors.white,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.circle, color: Colors.green, size: 12),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        "Live Meetings",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "2 Active",
                      style: TextStyle(
                          fontSize: 16, color: Colors.green[700], fontWeight: FontWeight.w600),
                    ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Team Status Header
            Card(
              elevation: 1,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Team Status",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("View All",
                            style: TextStyle(fontSize: 16, color: Colors.purple)),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Team Status List
                    Obx(() => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.teamMembers.length,
                      itemBuilder: (context, index) {
                        final member = controller.teamMembers[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.circle,
                                  color: member.isActive ? Colors.green : Colors.red,
                                  size: 14),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(member.name,
                                        style: const TextStyle(
                                            fontSize: 16, fontWeight: FontWeight.bold)),
                                    Text(member.status,
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey[600])),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.battery_full, size: 18, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text("${member.progress}%",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey[700])),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    )),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),

            Card(
              elevation: 1,
              color: Colors.white,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Performance Overview",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "94%",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF9B51E0),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Visit Success Rate",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "₹2.4L",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE91E63),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Weekly Revenue",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    ),
  );
}

Widget _statCard(
    {required Color color,
      required String title,
      required String value,
      required String subtitle}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(color: Colors.white, fontSize: 16)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(subtitle,
            style: const TextStyle(color: Colors.white70, fontSize: 14)),
      ],
    ),
  );
}
}
