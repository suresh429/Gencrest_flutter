import 'package:flutter/material.dart';
import 'package:gencrest/app/pages/roles/tsm/tsm_new_order_screen.dart';
import 'package:get/get.dart';
import '../../../controllers/tsm_orders_controller.dart';
import '../../../data/models/order.dart';

class TsmOrdersScreen extends StatelessWidget {
  final controller = Get.put(TsmOrdersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff8f9fb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Sales Orders",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.to(() =>  TsmNewOrderScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text("New Order", style: TextStyle(color: Colors.white)),
                  )
                ],
              ),

              const SizedBox(height: 16),

              /// Stats Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildStatCard("4", "This Month", Colors.blue),
                  buildStatCard("₹2.9L", "Total Value", Colors.green),
                  buildStatCard("1", "Pending", Colors.orange),
                ],
              ),

              const SizedBox(height: 16),

              /// Tabs
              Obx(
                    () => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: controller.tabs.map((tab) {
                      final isSelected = controller.selectedTab.value == tab;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ChoiceChip(
                          label: Text(tab),
                          selected: isSelected,
                          onSelected: (_) => controller.changeTab(tab),
                          selectedColor: Colors.blue,
                          backgroundColor: Colors.white, // unselected bg
                          showCheckmark: false, // remove tick mark
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: isSelected ? Colors.blue : Colors.grey.shade300,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// Orders List
              Expanded(
                child: Obx(
                      () => ListView.builder(
                    itemCount: controller.filteredOrders.length,
                    itemBuilder: (context, index) {
                      final order = controller.filteredOrders[index];
                      return buildOrderCard(order);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStatCard(String value, String label, Color color) {
    return Container(
      width: MediaQuery.of(Get.context!).size.width * 0.28,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        children: [
          Text(value, style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.black54,fontSize: 12)),
        ],
      ),
    );
  }

  Widget buildOrderCard(Order order) {
    Color statusColor;
    Color bgColor;
    switch (order.status) {
      case "delivered":
        statusColor = Colors.green;
        bgColor = Colors.green.shade50;
        break;
      case "shipped":
        statusColor = Colors.blue;
        bgColor = Colors.blue.shade50;
        break;
      case "approved":
        statusColor = Colors.orange;
        bgColor = Colors.orange.shade50;
        break;
      case "pending":
        statusColor = Colors.red;
        bgColor = Colors.red.shade50;
        break;
      default:
        statusColor = Colors.grey;
        bgColor = Colors.grey.shade200;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(order.customerName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  order.status,
                  style: TextStyle(color: statusColor, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),
          Text(order.orderId, style: const TextStyle(color: Colors.black54)),

          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Total Value", style: TextStyle(color: Colors.black54)),
                  Text("₹${order.value.toStringAsFixed(0)}",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: const Text("View Details →", style: TextStyle(color: Colors.blue)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
