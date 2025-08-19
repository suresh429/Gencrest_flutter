import 'package:get/get.dart';

class TsmDistributorController extends GetxController {
  var searchQuery = "".obs;

  final List<String> allDistributors = [
    "Dynamic Agro",
    "Fresh Farm Inputs",
    "Sunrise Krishi",
    "Agro World",
    "Green Harvest"
  ];

  RxList<String> filteredDistributors = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredDistributors.value = allDistributors;

    // Update list when search changes
    ever(searchQuery, (_) {
      if (searchQuery.value.isEmpty) {
        filteredDistributors.value = allDistributors;
      } else {
        filteredDistributors.value = allDistributors
            .where((d) => d.toLowerCase().contains(searchQuery.value.toLowerCase()))
            .toList();
      }
    });
  }
}
