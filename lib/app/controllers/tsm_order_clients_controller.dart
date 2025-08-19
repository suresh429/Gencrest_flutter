import 'package:get/get.dart';
import '../data/models/client.dart';

class ClientsController extends GetxController {
  var clients = <Client>[
    Client(name: "Dynamic Agro", city: "Delhi", creditLimit: "₹500,000", outstanding: "₹120,000"),
    Client(name: "Fresh Farm Inputs", city: "Mumbai", creditLimit: "₹300,000", outstanding: "₹85,000"),
    Client(name: "Sunrise Krishi", city: "Pune", creditLimit: "₹100,000", outstanding: "₹30,000"),
  ].obs;

  var searchText = "".obs;

  // 🔹 Keep track of selected client
  Rxn<Client> selectedClient = Rxn<Client>();

  List<Client> get filteredClients {
    if (searchText.value.isEmpty) {
      return clients;
    } else {
      return clients
          .where((c) =>
      c.name.toLowerCase().contains(searchText.value.toLowerCase()) ||
          c.city.toLowerCase().contains(searchText.value.toLowerCase()))
          .toList();
    }
  }
}
