import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'language_screen_controller.dart';

class LanguageScreenBiding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LanguageScreenController>(() => LanguageScreenController());
  }
}
