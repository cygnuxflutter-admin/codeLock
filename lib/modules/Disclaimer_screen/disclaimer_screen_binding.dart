import 'package:get/get.dart';
import 'disclaimer_screen_controller.dart';

class DisclaimerScreenBinding extends Bindings{
  @override
  void dependencies(){
    Get.lazyPut<DisclaimerScreenController>(() => DisclaimerScreenController());
  }
}