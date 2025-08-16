import 'package:get/get.dart';

class TsmLiquidationController extends GetxController {
  // Tabs
  final tabs = ["All MDOs", "Top Performers", "Needs Attention", "This Week"];
  final selectedTab = 0.obs;

  void selectTab(int index) {
    selectedTab.value = index;
  }

  // Full MDO List
  final mdoList = <Map<String, dynamic>>[
    {
      "name": "Rajesh Kumar",
      "territory": "North Delhi",
      "lastEntry": "2 hours ago",
      "assigned": 2343,
      "toRetailers": 1057,
      "toFarmers": 407,
      "pending": 3,
      "pendingVerification": 3,
    },
    {
      "name": "Priya Sharma",
      "territory": "North Delhi",
      "lastEntry": "2 hours ago",
      "assigned": 2892,
      "toRetailers": 1171,
      "toFarmers": 376,
      "pending": 0,
      "pendingVerification": 0,
    },
  ];

  // Filtered List (Reactive)
  List<Map<String, dynamic>> get filteredList {
    switch (selectedTab.value) {
      case 1: // Top Performers
        return mdoList.where((mdo) => mdo["toRetailers"] > 1100).toList();
      case 2: // Needs Attention
        return mdoList.where((mdo) => mdo["pending"] > 0).toList();
      case 3: // This Week (dummy condition, replace with real date logic)
        return mdoList.where((mdo) => mdo["lastEntry"].toString().contains("hours")).toList();
      default: // All MDOs
        return mdoList;
    }
  }
}
