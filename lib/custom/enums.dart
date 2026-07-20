import 'package:get/get_rx/src/rx_types/rx_types.dart';

enum DashBoardMenu<Rx> {
  startScreen,
  passCodeScreen,
  passWordScreen,
  masterPassword,
  none
}

Rx<DashBoardMenu> dashBoardMenu = DashBoardMenu.none.obs;

enum Language { english, spanish, hindi, german, french }

Language enumlanguage = Language.english;
