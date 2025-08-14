import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MDOScheduleController extends GetxController {
  var selectedIndex = 0.obs;

  final List<String> days = ["Today", "Tomorrow", "Thu", "Fri"];

  final visits = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    visits.value = [
      {
        "title": "Visit Green Valley Farm",
        "subtitle": "Ram Kumar",
        "time": "11:00 AM",
        "location": "Green Valley, Sector 12",
        "priority": "high",
        "priorityColor": Colors.redAccent,
      },
      {
        "title": "Product Demo at Sunrise Agro",
        "subtitle": "Sunrise Agro Store",
        "time": "02:30 PM",
        "location": "MG Road, Block A",
        "priority": "medium",
        "priorityColor": Colors.orangeAccent,
      },
      {
        "title": "Product Demo at Sunrise Agro",
        "subtitle": "Sunrise Agro Store",
        "time": "04:00 PM",
        "location": "Central Market",
        "priority": "low",
        "priorityColor": Colors.brown,
      },
    ];
  }

  void changeDay(int index) {
    selectedIndex.value = index;
  }
}
