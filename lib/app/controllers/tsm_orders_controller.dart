import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data/models/order.dart';

class TsmOrdersController extends GetxController {
  var selectedTab = "All".obs;

  // Dummy orders
  final orders = <Order>[
    Order(customerName: "Dynamic Agro", orderId: "ORD-2024-001", value: 125000, status: "delivered"),
    Order(customerName: "Fresh Farm Inputs", orderId: "ORD-2024-002", value: 90000, status: "shipped"),
    Order(customerName: "Green AgroTech", orderId: "ORD-2024-003", value: 110000, status: "approved"),
    Order(customerName: "Agri Supplies", orderId: "ORD-2024-004", value: 50000, status: "pending"),
  ].obs;

  // Tab list
  final tabs = ["All", "Approved", "Shipped", "Delivered", "Pending","Draft"].obs;

  // Filtered orders
  List<Order> get filteredOrders {
    if (selectedTab.value == "All") return orders;
    return orders.where((o) => o.status.toLowerCase() == selectedTab.value.toLowerCase()).toList();
  }

  void changeTab(String tab) {
    selectedTab.value = tab;
  }
}