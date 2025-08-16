import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data/models/alert_model.dart';

class TsmAlertsController extends GetxController {
  var allAlerts = <Alert>[].obs; // Keep original alerts here
  var alerts = <Alert>[].obs;    // This is the filtered list
  var selectedFilter = "All".obs;

  @override
  void onInit() {
    super.onInit();
    // Example data
    allAlerts.value = [
      Alert(
        name: "Priya Sharma",
        priority: "High Priority",
        priorityColor: const Color(0xFFFFE0E3),
        timeAgo: "2 mins ago",
        icon: Icons.location_off_outlined,
        description: "Location services disabled for 15 mins",
        category: "Location",
      ),
      Alert(
        name: "Amit Singh",
        priority: "Medium Priority",
        priorityColor: const Color(0xFFFFE8CC),
        timeAgo: "5 mins ago",
        icon: Icons.battery_alert_outlined,
        description: "Battery at 18% during active visit",
        category: "Battery",
      ),
    ];
    alerts.value = allAlerts; // Start with all alerts
  }

  void filterAlerts(String category) {
    selectedFilter.value = category;
    if (category == "All") {
      alerts.value = allAlerts;
    } else {
      alerts.value = allAlerts.where((a) => a.category == category).toList();
    }
  }
}
