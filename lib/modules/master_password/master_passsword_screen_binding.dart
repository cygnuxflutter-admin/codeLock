import 'package:get/get.dart';
import 'master_password_screen_controller.dart';

class MasterPasswordScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MasterPasswordScreenController>(
        () => MasterPasswordScreenController());
  }
}
