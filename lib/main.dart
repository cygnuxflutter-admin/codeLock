import 'package:code_lock/firebase_options.dart';
import 'package:code_lock/custom/detectTimer.dart';
import 'package:code_lock/get_page.dart';
import 'package:code_lock/preferences/shared_pref.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'custom/timer_method.dart';
import 'lifecycle.dart';
import 'modules/language_select/language_screen_controller.dart';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/services/ad_service.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'en_US';
  WidgetsFlutterBinding.ensureInitialized();
  final observer = AppLifecycleObserver();
  WidgetsBinding.instance.addObserver(observer);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await MobileAds.instance.initialize();
  
  RequestConfiguration configuration = RequestConfiguration(
    testDeviceIds: ["0A179F1EC44A88F71FAE4DE71E5217D0"],
  );
  MobileAds.instance.updateRequestConfiguration(configuration);

  Get.put(AdService());
  await LocalData.init();
  CodeLockColor.isDark = LocalData.getIsDarkMode ?? true;
  
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  LanguageScreenController languageScreenController =
      Get.put(LanguageScreenController());
  await languageScreenController.getLanguages();
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final SingletonTimer time = SingletonTimer();

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => detectOnTap(),
      onPointerMove: (_) => detectOnTap(),
      onPointerUp: (_) => detectOnTap(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Code Lock',
        theme: ThemeData(
          scaffoldBackgroundColor: CodeLockColor.bgGradientStart,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          scaffoldBackgroundColor: CodeLockColor.bgGradientStart,
          brightness: Brightness.dark,
        ),
        themeMode: (LocalData.getIsDarkMode ?? false) ? ThemeMode.dark : ThemeMode.light,
        getPages: getpages,
        initialBinding: BindingsBuilder(() => {
              Get.lazyPut(() => LanguageScreenController()),
            }),
      ),
    );
  }
}
