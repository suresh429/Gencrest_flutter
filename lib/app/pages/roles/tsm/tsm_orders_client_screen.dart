import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/tsm_order_clients_controller.dart';

class TsmOrdersClientScreen extends StatelessWidget {
  TsmOrdersClientScreen({super.key});

  final controller = Get.put(ClientsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Select a Client"),
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
            /// 🔍 Search Bar
            TextField(
              onChanged: (val) => controller.searchText.value = val,
              decoration: InputDecoration(
                hintText: "Search clients...",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),
            const SizedBox(height: 16),

            /// 🏢 Clients List
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: controller.filteredClients.length,
                itemBuilder: (context, index) {
                  final client = controller.filteredClients[index];
                  return InkWell(
                    onTap: () {
                      controller.selectedClient.value = client; // ✅ save
                      Get.back(result: client); // ✅ return selected client
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.blue.shade200, width: 1.2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            client.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            client.city,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 14),
                          ),
                           Divider(
                              height: 20, color:Colors.grey.shade200),
                          Text(
                            "Credit Limit: ${client.creditLimit} | Outstanding: ${client.outstanding}",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}
