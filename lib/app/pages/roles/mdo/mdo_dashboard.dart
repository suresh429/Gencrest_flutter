import 'package:flutter/material.dart';
import 'package:gencrest/app/controllers/mdo_bottom_nav_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/colors.dart';

class MDOHomeDashboard extends StatelessWidget {
  const MDOHomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Gradient Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF9434e7), Color(0xFFdb2778)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Good Morning!",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Ready for today?",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Text(
                          "5",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "visits planned",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Completed & Pending Cards
              Row(
                children: [
                  Expanded(
                    child: _statCard(
                      icon: Icons.check_circle_outline,
                      iconColor: Color(0xFF9434e7),
                      title: "Completed",
                      value: "3",
                      subtitle: "visits today",
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _statCard(
                      icon: Icons.track_changes,
                      iconColor: Color(0xFFdb2778),
                      title: "Pending",
                      value: "2",
                      subtitle: "tasks left",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Ongoing Visit Card with left strip matching corner radius
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 1,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Ongoing Visit Header
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Row (Icon + Title + View All)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.calendar_today, size: 18, color: Color(0xFF7B2FF7)),
                                    SizedBox(width: 6),
                                    Text(
                                      "Next Visit",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // View All action
                                    Get.find<MdoBottomNavController>().changeTab(1); // Switch to Team tab
                                  },
                                  child: const Text(
                                    "View All",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF7B2FF7),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Inner Card
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFF7B2FF7).withOpacity(0.08), // light purple
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Left vertical purple bar
                                Container(
                                  width: 6,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF7B2FF7),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                const SizedBox(width: 12),

                                // Visit Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Ram Kumar Farm",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Icon(Icons.access_time,
                                              size: 16, color: Colors.black54),
                                          SizedBox(width: 4),
                                          Text(
                                            "11:00 AM",
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 2),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on,
                                              size: 16, color: Colors.black54),
                                          SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              "Green Valley, Sector 12",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                // Start Button
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF7B2FF7),
                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    // Start action
                                  },
                                  child: const Text(
                                    "Start",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      )

                    ],
                  ),
                ),
              ),

              SizedBox(height: 12),

              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 1,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Quick Actions",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF1F4),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: const Color(0xFFFFB3C0)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.add, color: Color(0xFFE11D48)),
                                  SizedBox(width: 8),
                                  Text(
                                    "New Visit",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Color(0xFFE11D48),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                color: Color(0xFFF5F3FF),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Color(0xFFD6BCFA)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.camera_alt_outlined, color: Color(0xFF7C3AED)),
                                  SizedBox(width: 8),
                                  Text(
                                    "Quick Photo",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Color(0xFF7C3AED),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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

  static Widget _statCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withValues(alpha: 0.05),
            blurRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 28),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
