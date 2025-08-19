import 'package:flutter/material.dart';
import 'package:gencrest/app/controllers/tsm_distributor_controller.dart';
import 'package:get/get.dart';

import '../mdo/mdo_log_new_entry_screen.dart';

class TsmSelectDistributorScreen extends StatelessWidget {
  final controller = Get.put(TsmDistributorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Select Distributor"),
        elevation: 0,
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF9434e7), Color(0xFFdb2778)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔍 Search Box
            TextField(
              onChanged: (value) => controller.searchQuery.value = value,
              decoration: InputDecoration(
                hintText: "Search distributors...",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 📋 Distributor List
            Expanded(
              child: Obx(() {
                final distributors = controller.filteredDistributors;

                if (distributors.isEmpty) {
                  return const Center(
                    child: Text("No distributors found"),
                  );
                }

                return ListView.builder(
                  itemCount: distributors.length,
                  itemBuilder: (context, index) {
                    final distributor = distributors[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.warehouse_rounded,
                            color: Colors.blue),
                        title: Text(
                          distributor,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right,
                            color: Colors.grey),
                        onTap: () {
                         // Get.back(result: distributor); // return selected
                          Get.to(() => const MdoLogNewEntryScreen(),
                              arguments: {"distributor": distributor});
                        },
                      ),
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
}
