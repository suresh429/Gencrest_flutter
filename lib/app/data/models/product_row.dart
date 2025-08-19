import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ProductRow {
  RxString product = "".obs;
  RxInt quantity = 1.obs;
  RxDouble price = 0.0.obs;

  double get total => quantity.value * price.value;
}