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
        name: "Battery Low",
        priority: "High",
        priorityColor: Colors.red,
        timeAgo: "2m ago",
        icon: Icons.battery_alert,
        description: "Vehicle 23 battery dropped below 15%",
        category: "Battery",
      ),
      Alert(
        name: "Geofence Breach",
        priority: "Medium",
        priorityColor: Colors.orange,
        timeAgo: "5m ago",
        icon: Icons.location_off,
        description: "Vehicle 45 exited geofence area",
        category: "Geofence",
      ),
      Alert(
        name: "Location Lost",
        priority: "Low",
        priorityColor: Colors.blue,
        timeAgo: "10m ago",
        icon: Icons.gps_off,
        description: "Vehicle 11 location signal lost",
        category: "Location",
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
