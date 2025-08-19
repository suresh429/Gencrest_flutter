import 'package:flutter/material.dart';
import 'package:gencrest/app/widgets/tsm_team_performance_widget.dart';
import 'package:get/get.dart';
import '../../../controllers/tsm_team_controller.dart';
import '../../../widgets/tsm_team_status_widget.dart';

class TsmTeamPage extends StatelessWidget {
  final controller = Get.put(TsmTeamController());

  TsmTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Team Monitoring",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.refresh, color: Colors.purple),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              /// 🔑 Main Tabs (Team Status / Performance)
              Obx(() => Row(
                children: List.generate(controller.mainTabs.length, (index) {
                  final isSelected = controller.mainSelectedTab.value == index;

                  // Define icons for each tab
                  final icons = [
                    Icons.group,       // Team Status
                    Icons.bar_chart,   // Performance
                  ];

                  return Expanded(
                    child: GestureDetector(
                      onTap: () => controller.mainSelectTab(index),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.purple : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? Colors.transparent : Colors.grey.shade300,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              icons[index],
                              color: isSelected ? Colors.white : Colors.black54,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              controller.mainTabs[index],
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              )),

              const SizedBox(height: 12),

              /// 🔑 Content Based on Main Tab
              Expanded(
                child: Obx(() {
                  if (controller.mainTabs[controller.mainSelectedTab.value] == "Team Status") {
                    /// 🟣 Team Status Section
                    return TsmTeamStatusWidget(controller: controller);
                  } else {
                    /// 🟡 Performance Section
                    if (controller.mainSelectedTab.value == 1) {
                      return TsmTeamPerformanceWidget();
                    } else {
                      return const Center(child: Text("Performance Coming Soon"));
                    }
                  }
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
