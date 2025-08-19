import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/tsm_team_controller.dart';
import '../pages/roles/tsm/tsm_team_status_details_page.dart';

class TsmTeamStatusWidget extends StatelessWidget {
  final TsmTeamController controller;

  const TsmTeamStatusWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// Live Meetings Card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.circle, color: Colors.green, size: 12),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Current Live",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text("Meetings"),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    "2 Active",
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        /// Status Filter Tabs
        Obx(() => Row(
          children: List.generate(controller.tabs.length, (index) {
            final isSelected = controller.selectedTab.value == index;
            return GestureDetector(
              onTap: () => controller.selectTab(index),
              child: Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.purple : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? Colors.transparent : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  controller.tabs[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }),
        )),
        const SizedBox(height: 12),

        /// Team List
        // Use Expanded only inside a Flex parent, here wrap in Flexible
        Flexible(
          child: Obx(() {
            final selected = controller.tabs[controller.selectedTab.value];
            final filtered = selected == "All"
                ? controller.teamList
                : controller.teamList.where((e) =>
            e.status.toLowerCase() == selected.toLowerCase()).toList();

            return ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final member = filtered[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Name + Status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                member.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                member.status,
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              member.status,
                              style: const TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 12),

                      /// Progress + Start Time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.battery_std, size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text("${member.progress}%"),
                            ],
                          ),
                          Text(
                            "Start: ${member.startTime}",
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      /// Buttons
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                // Navigate to details page
                                Get.to(() => const TsmTeamStatusDetailsPage());
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Details",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.purple.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Text(
                                  "Message",
                                  style: TextStyle(
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
