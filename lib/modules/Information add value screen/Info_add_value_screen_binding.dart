import 'package:code_lock/modules/Information%20add%20value%20screen/Info_add_value_screen_controller.dart';
import 'package:get/get.dart';

class InfoAddValueScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfoAddValueScreenController>(
        () => InfoAddValueScreenController());
  }
}
