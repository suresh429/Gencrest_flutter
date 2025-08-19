import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:gencrest/app/utils/colors.dart';

import '../data/models/client.dart';

class TsmNewOrderController extends GetxController {
  // Selected client
  Rxn<Client> selectedClient = Rxn<Client>();

  // Payment terms
  var selectedPayment = "Credit 30 Days".obs;
  final List<String> paymentTerms = [
    "Credit 30 Days",
    "Credit 60 Days",
    "Cash",
  ];

  // Notes
  var notes = "".obs;
}