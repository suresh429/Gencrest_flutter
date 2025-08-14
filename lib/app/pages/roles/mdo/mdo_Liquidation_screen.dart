import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/liquidation_controller.dart';
import '../../../utils/colors.dart';

class LiquidationScreen extends StatelessWidget {
  final controller = Get.put(LiquidationController());

  LiquidationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Liquidation Tracker",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(Icons.add, color: Colors.white, size: 18),
                  label: const Text(
                    "Log Entry",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// Stats Row
            Row(
              children: [
                _statCard(
                  icon: Icons.home_work_outlined,
                  label: "This Month",
                  value: "1,250",
                  sub: "kgs liquidated",
                ),
                const SizedBox(width: 12),
                _statCard(
                  icon: Icons.trending_up,
                  label: "Rate",
                  value: "78%",
                  sub: "liquidation rate",
                  iconColor: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 12),

            /// Tabs Row
            Obx(() => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(controller.tabs.length, (index) {
                  String tabName = controller.tabs[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () => controller.selectedTab.value = tabName,
                      child: _tabButton(
                        tabName,
                        controller.selectedTab.value == tabName,
                      ),
                    ),
                  );
                }),
              ),
            )),
            const SizedBox(height: 12),

            /// List of Cards (Filtered)
            Expanded(
              child: Obx(() {
                var filteredList = controller.filteredLiquidationList;
                return ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    var item = filteredList[index];
                    return _liquidationCard(
                      title: item["title"]!,
                      subtitle: item["subtitle"]!,
                      date: item["date"]!,
                      weight: item["weight"]!,
                      status: item["status"]!,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// Stat card
  Widget _statCard({
    required IconData icon,
    required String label,
    required String value,
    required String sub,
    Color iconColor = Colors.blue,
  }) {
    return Expanded(
      child: Card(
        elevation: 1,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  Icon(icon, color: iconColor),
                  const SizedBox(width: 8),
                  Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
                ],

              ),
              const SizedBox(height: 4),
              Text(value,
                  style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text(sub, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  /// Tab Button
  Widget _tabButton(String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.purple : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? Colors.purple : Colors.grey.shade300,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// Liquidation Card
  Widget _liquidationCard({
    required String title,
    required String subtitle,
    required String date,
    required String weight,
    required String status,
  }) {
    return Card(
      elevation: 1,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title & Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: status == "verified"
                        ? Colors.green.shade100
                        : Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: status == "verified"
                          ? Colors.green.shade700
                          : Colors.orange.shade700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(color: Colors.grey)),

            const SizedBox(height: 12),

            /// Date + Weight
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(date, style: const TextStyle(color: Colors.grey)),
                const SizedBox(width: 16),
                const Icon(Icons.home_work_outlined, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(weight, style: const TextStyle(color: Colors.grey)),
              ],
            ),

            const Divider(height: 20),

            /// View Details
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {},
                icon: const Icon(Icons.remove_red_eye, color: Colors.white),
                label: const Text("View Details",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
