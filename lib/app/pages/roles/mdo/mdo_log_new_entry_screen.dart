import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:gencrest/app/controllers/mdo_log_new_controller.dart';

class MdoLogNewEntryScreen extends StatelessWidget {
  const MdoLogNewEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MdoLogController controller = Get.put(MdoLogController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Log Liquidation"),
        elevation: 0,
        foregroundColor: Colors.white, // text/icon color
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
        child: ListView(
          children: [
            // Distributor TextField
            TextField(
              controller: controller.distributorController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "From Distributor",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ✅ Retailer Dropdown with fixed popup width
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: const Text("Select Retailer/Farmer"),
                value: controller.retailerController.text.isEmpty
                    ? null
                    : controller.retailerController.text,
                items: controller.retailers
                    .map((retailer) => DropdownMenuItem(
                  value: retailer,
                  child: Text(
                    retailer,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) controller.setRetailer(value);
                },
                buttonStyleData: ButtonStyleData(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade400),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width, // matches textfield width
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  width: MediaQuery.of(context).size.width - 32, // ✅ match width (16 padding left+right)
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  offset: const Offset(0, -4),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ✅ Product Dropdown with fixed popup width
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: const Text("Select Product SKU"),
                value: controller.productController.text.isEmpty
                    ? null
                    : controller.productController.text,
                items: controller.products
                    .map((product) => DropdownMenuItem(
                  value: product,
                  child: Text(
                    product,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) controller.setProduct(value);
                },
                buttonStyleData: ButtonStyleData(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade400),
                    color: Colors.white,
                  ),
                  width: MediaQuery.of(context).size.width,
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200,
                  width: MediaQuery.of(context).size.width - 32, // ✅ same fix
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  offset: const Offset(0, -4),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Quantity
            TextField(
              controller: controller.quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Quantity (kgs)",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Date Picker
            TextField(
              controller: controller.dateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Select Date",
                filled: true,
                fillColor: Colors.white,
                suffixIcon: const Icon(Icons.calendar_today),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  controller.setDate(pickedDate);
                }
              },
            ),
            const SizedBox(height: 24),

            const Text("Verification",
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),

            // Capture Photo Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.camera, color: Colors.black, size: 20),
                label: const Text("Capture Photo",
                    style: TextStyle(color: Colors.black)),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  // TODO: Add camera logic
                },
              ),
            ),
            const SizedBox(height: 12),

            // Get E-Signature Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.edit, color: Colors.black, size: 20),
                label: const Text("Get E-Signature",
                    style: TextStyle(color: Colors.black)),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  // TODO: Add signature pad logic
                },
              ),
            ),
            const SizedBox(height: 24),

            // Submit Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: controller.submitLog,
              child: const Text(
                "Submit Entry",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
