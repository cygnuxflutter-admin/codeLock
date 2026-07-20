import 'package:get/get.dart';
import 'Description_screen_controller.dart';

class DescriptionScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DescriptionScreenController>(
        () => DescriptionScreenController());
  }
}
