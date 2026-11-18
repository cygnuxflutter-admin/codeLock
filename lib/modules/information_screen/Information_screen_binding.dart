import 'package:get/get.dart';
import 'Information_screen_controller.dart';

class InformationScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InformationScreenController>(
        () => InformationScreenController());
  }
}
