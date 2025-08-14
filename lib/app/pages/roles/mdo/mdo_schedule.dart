import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gencrest/app/utils/colors.dart';
import '../../../controllers/mdo_schedule_controller.dart';
import '../../../widgets/scheduletab_widget.dart';
import '../../../widgets/visitcard_widget.dart';

class MDOSchedulePage extends GetView<MDOScheduleController> {
  const MDOSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top title & Add Visit
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Today's Schedule",
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8C43F7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 8),
                    ),
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text(
                      'Add Visit',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Days Tab
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(
                      () => Row(
                    children: List.generate(controller.days.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: () => controller.changeDay(index),
                          child: ScheduleTab(
                            title: controller.days[index],
                            selected: controller.selectedIndex.value == index,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Visits List
              Expanded(
                child: Obx(
                      () => ListView.separated(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: controller.visits.value.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final v = controller.visits.value[index];
                      return VisitCard(
                        title: v["title"],
                        subtitle: v["subtitle"],
                        time: v["time"],
                        location: v["location"],
                        priority: v["priority"],
                        priorityColor: v["priorityColor"],
                      );
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
}
