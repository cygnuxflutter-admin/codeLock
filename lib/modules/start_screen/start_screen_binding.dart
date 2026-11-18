import 'package:code_lock/modules/start_screen/start_screen_controller.dart';
import 'package:get/get.dart';

class StartScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StartScreenController());
  }
}
