import 'package:code_lock/modules/setting%20screen/setting_screen_controller.dart';
import 'package:get/get.dart';

class SettingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingScreenController>(
      () => SettingScreenController(),
    );
  }
}
