import 'package:flutter/material.dart';
import 'package:gencrest/app/pages/roles/mdo/mdo_liquidation_details_screen.dart';
import 'package:gencrest/app/pages/roles/mdo/mdo_log_new_entry_screen.dart';
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
                // ElevatedButton.icon(
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.green,
                //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(8),
                //     ),
                //   ),
                //   onPressed: () {},
                //   icon: const Icon(Icons.add, color: Colors.white, size: 18),
                //   label: const Text(
                //     "Log Entry",
                //     style: TextStyle(color: Colors.white, fontSize: 14),
                //   ),
                // ),
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
                    return liquidationCard(
                      title: item["title"]!,
                      subtitle: item["subtitle"]!,
                      date: item["date"]!,
                      quantity: item["quantity"]!,
                      distributor: item["distributor"]!,
                      retailer: item["retailer"]!,
                      status: item["status"]!,
                      notes: item["notes"]!,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: handle tap
          Get.to(() => MdoLogNewEntryScreen());
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
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
  Widget liquidationCard({
    required String title,
    required String subtitle,
    required String date,
    required String quantity,
    required String distributor,
    required String retailer,
    required String status,
    required String notes,
  }) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: status == "pending"
                        ? Colors.orange.shade100
                        : Colors.green.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: status == "pending" ? Colors.orange : Colors.green,
                     // fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            /// Subtitle
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(subtitle, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 8),

            /// Date + Weight
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(date, style: const TextStyle(color: Colors.grey)),
                const SizedBox(width: 12),
                const Icon(Icons.scale, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(quantity, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 16),

            /// Action Buttons (Conditional)
            if (status == "pending") ...[
              Row(
                children: [
                  /// Verify
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        // TODO: verify
                      },
                      icon: const Icon(Icons.check_circle, color: Colors.white),
                      label: const Text("Verify",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 5),

                  /// Edit
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200,
                        foregroundColor: Colors.black87,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        // TODO: edit
                      },
                      icon: const Icon(Icons.edit, color: Colors.black54),
                      label: const Text("Edit"),
                    ),
                  ),
                  const SizedBox(width: 5),

                  /// View Details
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple.shade50,
                        foregroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () {
                        // TODO: view details
                        Get.to(() => MdoLiquidationDetailsScreen(
                          title: title,
                          subtitle: subtitle,
                          date: date,
                          quantity: quantity,
                          distributor: distributor,
                          retailer: retailer,
                          status: status,
                          notes: notes,
                        ));
                      },
                      icon: const Icon(Icons.remove_red_eye, color: Colors.purple),
                      label: const Text("View"),
                    ),
                  ),
                ],
              )
            ] else ...[
              /// Single View Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    // Navigate to details screen
                    Get.to(() => MdoLiquidationDetailsScreen(
                      title: title,
                      subtitle: subtitle,
                      date: date,
                      quantity: quantity,
                      distributor: distributor,
                      retailer: retailer,
                      status: status,
                      notes: notes,
                    ));

                  },
                  icon: const Icon(Icons.remove_red_eye, color: Colors.white),
                  label: const Text("View Details",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }


}
