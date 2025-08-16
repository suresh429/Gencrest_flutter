import 'package:get/get.dart';

class TsmTeamController extends GetxController {
  final tabs = ["All", "Active", "On Visit", "Issues"].obs;
  final selectedTab = 0.obs;

  void selectTab(int index) {
    selectedTab.value = index; // this updates reactive state
  }

  // Team Members List
  final teamList = <Map<String, dynamic>>[
    {
      "name": "Rajesh Kumar",
      "farm": "Ram Kumar Farm",
      "status": "on visit",
      "battery": 85,
      "lastSeen": "2 mins ago",
    },
    {
      "name": "Priya Sharma",
      "farm": "Sharma Farms",
      "status": "active",
      "battery": 72,
      "lastSeen": "5 mins ago",
    },
    {
      "name": "Amit Verma",
      "farm": "Verma Agro",
      "status": "issues",
      "battery": 60,
      "lastSeen": "10 mins ago",
    },
  ].obs;
}
