import 'package:code_lock/modules/setting_screen/sub_screen/restore_screen.dart';
import 'package:code_lock/modules/splash_screen.dart';
import 'package:get/get.dart';
import 'app_routes.dart';
import 'modules/description_detail/Description_screen.dart';
import 'modules/description_detail/Description_screen_binding.dart';
import 'modules/disclaimer_screen/disclaimer_screen.dart';
import 'modules/disclaimer_screen/disclaimer_screen_binding.dart';
import 'modules/add_field_screen/field_screen.dart';
import 'modules/add_field_screen/field_screen_binding.dart';
import 'modules/edit_field_screen/edit_field_screen.dart';
import 'modules/edit_field_screen/edit_field_screen_binding.dart';
import 'modules/change_codelock_screen/change_codelock.dart';
import 'modules/change_codelock_screen/change_codelock_binding.dart';
import 'modules/language_select/language_screen.dart';
import 'modules/home_screen/home_screen.dart';
import 'modules/home_screen/home_screen_binding.dart';
import 'modules/info_add_value_screen/Info_add_value_screen.dart';
import 'modules/info_add_value_screen/Info_add_value_screen_binding.dart';
import 'modules/information_screen/Information_screen.dart';
import 'modules/information_screen/Information_screen_binding.dart';
import 'modules/language_select/language_screen_binding.dart';
import 'modules/master_password/master_passsword_screen_binding.dart';
import 'modules/master_password/master_password_screen.dart';
import 'modules/setting_screen/Setting_screen.dart';
import 'modules/setting_screen/setting_screen_binding.dart';
import 'modules/start_screen/Start_Screen.dart';
import 'modules/start_screen/start_screen_binding.dart';

List<GetPage> getpages = [
  GetPage(
    name: AppRoutes.SplashScreen,
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: AppRoutes.HomeScreen,
    page: () => const HomeScreen(),
    binding: HomeScreenBinding(),
  ),
  GetPage(
    name: AppRoutes.MasterPassword,
    page: () => MasterPassword(),
    binding: MasterPasswordScreenBinding(),
  ),
  GetPage(
    name: AppRoutes.StartScreen,
    page: () => const StartScreen(),
    binding: StartScreenBinding(),
  ),
  GetPage(
    name: AppRoutes.SettingScreen,
    page: () => Settingscreen(),
    binding: SettingScreenBinding(),
  ),
  GetPage(
    name: AppRoutes.LanguageScreen,
    page: () => const Languagescreen(),
    binding: LanguageScreenBiding(),
  ),
  GetPage(
    name: AppRoutes.FieldScreen,
    page: () => const FieldScreen(),
    binding: FieldScreenBiding(),
  ),
  GetPage(
    name: AppRoutes.InformationScreen,
    page: () => InformationScreen(),
    binding: InformationScreenBinding(),
  ),
  GetPage(
    name: AppRoutes.Infoaddvalue,
    page: () => Infoaddvalue(),
    binding: InfoAddValueScreenBinding(),
  ),
  GetPage(
    name: AppRoutes.ChangeCodeLockScreen,
    page: () => const ChangeCodeLockScreen(),
    binding: ChangeCodeLockScreenBinding(),
  ),
  GetPage(
    name: AppRoutes.DescriptionScreen,
    page: () => DescriptionScreen(),
    binding: DescriptionScreenBinding(),
  ),
  GetPage(
    name: AppRoutes.DisclaimerScreen,
    page: () => const DisclaimerScreen(),
    binding: DisclaimerScreenBinding(),
  ),
  GetPage(
    name: AppRoutes.restoreScreen,
    page: () => const RestoreScreen(),
  ),
  GetPage(
    name: AppRoutes.EditFieldScreen,
    page: () => const EditFieldScreen(),
    binding: EditFieldScreenBiding(),
  ),
];
