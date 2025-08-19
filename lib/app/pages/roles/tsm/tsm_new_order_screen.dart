import 'package:flutter/material.dart';
import 'package:gencrest/app/pages/roles/tsm/tsm_orders_client_screen.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:gencrest/app/utils/colors.dart';

import '../../../controllers/tsm_new_order_controller.dart';
import '../../../data/models/product_row.dart';
import '../../../utils/gradient_appbar.dart';


class TsmNewOrderScreen extends StatelessWidget {
  TsmNewOrderScreen({super.key});

  final controller = Get.put(TsmNewOrderController());

  // Example product list
  final List<String> products = [
    "Select SKU",
    "Cotton Hybrid -101",
    "Wheat Seeds Premium",
    "Fertilizer NPK",
    "CropShield Pesticide",
    "Bio Fertilizer",
  ];

  final RxList<ProductRow> productRows = <ProductRow>[].obs;

  double get grandTotal =>
      productRows.fold(0, (sum, row) => sum + row.total);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      appBar: const GradientAppBar(title: "Create New Order"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 1️⃣ Select Client
            Obx(() {
              final client = controller.selectedClient.value;

              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white, // Always white background
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08), // soft shadow
                      blurRadius: 6, // how soft
                      offset: const Offset(0, 3), // shadow position
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "1. Select Client",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),

                    if (client == null)
                    // 🔹 If no client selected, show button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final selectedClient = await Get.to(() => TsmOrdersClientScreen());
                            if (selectedClient != null) {
                              controller.selectedClient.value = selectedClient;
                            }
                          },
                          icon: const Icon(Icons.person_outline, color: Colors.white),
                          label: const Text("Choose a Client"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      )
                    else
                    // 🔹 Show selected client card
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue.shade200, width: 1.2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.08), // subtle blue glow
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  client.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                Text(
                                  client.city,
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () async {
                                final selectedClient = await Get.to(() => TsmOrdersClientScreen());
                                if (selectedClient != null) {
                                  controller.selectedClient.value = selectedClient;
                                }
                              },
                              child: const Text(
                                "Change",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 16),
            /// 2️⃣ Add Products
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: _cardDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("2. Add Products",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                      GestureDetector(
                        onTap: () {
                          productRows.add(ProductRow());
                        },
                        child: const Text("+ Add Row",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Obx(() => Column(
                    children: productRows
                        .asMap()
                        .entries
                        .map((entry) {
                      final index = entry.key;
                      final row = entry.value;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.shade50,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Header row with ❌ button
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Product Row",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                IconButton(
                                  onPressed: () {
                                    productRows.removeAt(index);
                                  },
                                  icon: const Icon(Icons.close, color: Colors.red),
                                ),
                              ],
                            ),

                            /// Product Dropdown
                            Obx(() => DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                isExpanded: true,
                                value: row.product.value.isEmpty ? null : row.product.value,
                                hint: const Text("Select SKU"),
                                items: products
                                    .map((p) => DropdownMenuItem(
                                  value: p,
                                  child: Text(p),
                                ))
                                    .toList(),
                                onChanged: (value) {
                                  row.product.value = value ?? "";
                                },
                                buttonStyleData: ButtonStyleData(
                                  height: 48,
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.grey.shade400),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )),

                            const SizedBox(height: 8),

                            /// Quantity + Price
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: "Quantity",
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (val) {
                                      row.quantity.value = int.tryParse(val) ?? 1;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: "Unit Price",
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (val) {
                                      row.price.value = double.tryParse(val) ?? 0.0;
                                    },
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            /// Total
                            Obx(() => Text(
                              "Total: ₹${row.total.toStringAsFixed(2)}",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ],
                        ),
                      );


                    }).toList(),
                  )),
                  const Divider(),

                  /// Grand Total
                  Obx(() => Text(
                    "Grand Total: ₹${grandTotal.toStringAsFixed(2)}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                ],
              ),
            ),

            /// 3️⃣ Final Details
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: _cardDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("3. Final Details",
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),

                  /// Payment Terms
                  const Text("Payment Terms",
                      style: TextStyle(fontSize: 14)),
                  const SizedBox(height: 8),
                  Obx(() => DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      value: controller.selectedPayment.value,
                      items: controller.paymentTerms
                          .map((term) => DropdownMenuItem(
                        value: term,
                        child: Text(term),
                      ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.selectedPayment.value = value;
                        }
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 52,
                        padding:
                        const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border:
                          Border.all(color: Colors.grey.shade400),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
                  const SizedBox(height: 20),

                  /// Notes
                  TextField(
                    maxLines: 3,
                    onChanged: (value) => controller.notes.value = value,
                    decoration: InputDecoration(
                      labelText: "Notes (Optional)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  debugPrint("Client: ${controller.selectedClient.value}");
                  debugPrint("Payment: ${controller.selectedPayment.value}");
                  debugPrint("Notes: ${controller.notes.value}");
                  debugPrint("Products: ${productRows.length}");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Submit Order"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 6,
        )
      ],
    );
  }
}