import 'package:get/get.dart';

class LiquidationController extends GetxController {
  var selectedTab = "All".obs;

  final tabs = ["All", "Pending", "Verified", "This Week"];

  final liquidationList = [
    {
      "title": "Cotton Hybrid-101",
      "subtitle": "Dynamic Agro → Kumar Seeds",
      "date": "1/15/2024",
      "weight": "50 kgs",
      "status": "verified"
    },
    {
      "title": "Cotton Hybrid-202",
      "subtitle": "AgroFarm → Alpha Seeds",
      "date": "1/12/2024",
      "weight": "40 kgs",
      "status": "pending"
    },
  ].obs;

  List<Map<String, String>> get filteredLiquidationList {
    if (selectedTab.value == "All") return liquidationList;
    return liquidationList
        .where((item) => item["status"] == selectedTab.value.toLowerCase())
        .toList();
  }
}
