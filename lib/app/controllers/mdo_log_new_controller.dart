import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MdoLogController extends GetxController {
  var selectedRetailer = ''.obs;
  var selectedProduct = ''.obs;
  // Controllers
  final distributorController = TextEditingController();
  final retailerController = TextEditingController();
  final productController = TextEditingController();
  final quantityController = TextEditingController();
  final dateController = TextEditingController();

  // Dropdown data
  final retailers = ["Kumar Seeds", "Green Valley Store", "Farmer Point"];
  final products = ["Cotton Hybrid-101", "Corn Super-202", "Wheat Gold-303"];

  // Functions to set values
  void setRetailer(String value) {
    retailerController.text = value;
  }

  void setProduct(String value) {
    productController.text = value;
  }

  void setDate(DateTime date) {
    dateController.text = "${date.month}/${date.day}/${date.year}";
  }

  void submitLog() {
    debugPrint("Distributor: ${distributorController.text}");
    debugPrint("Retailer: ${retailerController.text}");
    debugPrint("Product: ${productController.text}");
    debugPrint("Quantity: ${quantityController.text}");
    debugPrint("Date: ${dateController.text}");
  }

  @override
  void onClose() {
    distributorController.dispose();
    retailerController.dispose();
    productController.dispose();
    quantityController.dispose();
    dateController.dispose();
    super.onClose();
  }
}
