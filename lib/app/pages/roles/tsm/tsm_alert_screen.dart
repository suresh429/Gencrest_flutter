import 'package:flutter/material.dart';
import 'package:gencrest/app/utils/colors.dart';
import 'package:get/get.dart';
import '../../../controllers/tsm_alerts_controller.dart';
import '../../../data/models/alert_model.dart';

class TsmAlertScreen extends StatelessWidget {
  final TsmAlertsController controller = Get.put(TsmAlertsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      appBar: AppBar(
        title: const Text("Critical Alerts"),
        elevation: 0,
        foregroundColor: Colors.white, // text/icon color
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF9434e7), Color(0xFFdb2778)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),

      // Main content (alerts list)
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Row
            Row(
              children: [
                Text(
                  "Critical Alerts",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Icon(Icons.circle, color: Colors.red, size: 10),
                SizedBox(width: 4),
                Text("3 Active", style: TextStyle(color: Colors.red)),
              ],
            ),
            SizedBox(height: 12),

            // Filter Tabs Row
            Row(
              children: [
                _buildFilterTab("All"),
                SizedBox(width: 8),
                _buildFilterTab("Location"),
                SizedBox(width: 8),
                _buildFilterTab("Battery"),
                SizedBox(width: 8),
                _buildFilterTab("Geofence"),
              ],
            ),
            SizedBox(height: 16),

            // Alerts List
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: controller.alerts.length,
                  itemBuilder: (context, index) {
                    final alert = controller.alerts[index];
                    return _buildAlertCard(alert);
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 1,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min, // keep it compact
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
                                  Icon(Icons.notifications_outlined,
                                      color: Color(0xFFE11D48)),
                                  SizedBox(width: 8),
                                  Text(
                                    "Send Team\nAlert",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
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
                                  Icon(Icons.chat_outlined, color: Color(0xFF7C3AED)),
                                  SizedBox(width: 8),
                                  Text(
                                    "Broadcast\nMessage",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
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
              ),
            ),
          ],
        ),
      ),

    );
  }

  // Filter tab widget
  Widget _buildFilterTab(String title) {
    return Obx(() {
      bool isActive = controller.selectedFilter.value == title;
      return GestureDetector(
        onTap: () => controller.filterAlerts(title),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? Colors.red : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isActive ? Colors.red : Colors.grey.shade300,
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey.shade800,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    });
  }

  // Alert card widget
  Widget _buildAlertCard(Alert alert) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.red, width: 3),
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 1,
            blurRadius: 5,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name + Priority + Time
          Row(
            children: [
              Icon(Icons.circle, size: 10, color: Colors.orange),
              SizedBox(width: 8),
              Text(
                alert.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: alert.priorityColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  alert.priority,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.red.shade800,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Spacer(),
              Text(
                alert.timeAgo,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
          SizedBox(height: 8),

          // Description
          Row(
            children: [
              Icon(alert.icon, size: 18, color: Colors.red),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  alert.description,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),

          // Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8C43F7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Contact MDO',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Mark Resolved',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
