import 'package:get/get.dart';

class LiquidationController extends GetxController {
  var selectedTab = "All".obs;

  final tabs = ["All", "Pending", "Verified", "This Week"];

  final liquidationList = [
    {
      "title": "Cotton Hybrid-101",
      "subtitle": "Dynamic Agro → Kumar Seeds",
      "date": "1/15/2024",
      "quantity": "50 kgs",
      "distributor": "Dynamic Agro",
      "retailer": "Kumar Seeds",
      "status": "verified",
      "notes": "Delivered successfully"
    },
    {
      "title": "Cotton Hybrid-202",
      "subtitle": "AgroFarm → Alpha Seeds",
      "date": "1/12/2024",
      "quantity": "40 kgs",
      "distributor": "AgroFarm",
      "retailer": "Alpha Seeds",
      "status": "pending",
      "notes": "Awaiting confirmation"
    },
  ].obs;

  List<Map<String, String>> get filteredLiquidationList {
    if (selectedTab.value == "All") return liquidationList;
    return liquidationList
        .where((item) => item["status"] == selectedTab.value.toLowerCase())
        .toList();
  }
}
