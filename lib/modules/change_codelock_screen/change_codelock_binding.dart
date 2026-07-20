import 'package:get/get.dart';
import 'change_codelock_controller.dart';

class ChangeCodeLockScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeCodeLockScreenController>(
        () => ChangeCodeLockScreenController());
  }
}
