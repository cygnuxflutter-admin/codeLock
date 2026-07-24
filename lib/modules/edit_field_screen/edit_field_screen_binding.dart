import 'package:get/get.dart';
import 'edit_field_screen_controller.dart';

class EditFieldScreenBiding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditFieldScreenController());
  }
}
