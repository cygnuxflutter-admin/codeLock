import 'package:get/get.dart';
import 'field_screen_controller.dart';

class FieldScreenBiding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FieldScreenController>(() => FieldScreenController());
  }
}
