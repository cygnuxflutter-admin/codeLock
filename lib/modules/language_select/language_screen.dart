import 'package:code_lock/app_routes.dart';
import 'package:code_lock/custom/Image/code_lock_image.dart';
import 'package:code_lock/modules/language_select/language_screen_controller.dart';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Languagescreen extends StatefulWidget {
  const Languagescreen({Key? key}) : super(key: key);

  @override
  State<Languagescreen> createState() => _LanguagescreenState();
}

class _LanguagescreenState extends State<Languagescreen> {
  LanguageScreenController languageScreenController = LanguageScreenController();
  LanguageScreenController controller = LanguageScreenController();

  final Map<String, String> nativeNames = {
    "English": "English",
    "French": "Français",
    "Hindi": "हिन्दी",
    "Spanish": "Español",
    "German": "Deutsch",
  };

  @override
  void initState() {
    super.initState();
    languages.obs;
    controller.getLanguages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            color: Colors.transparent, // Increases touch area
            width: 48,
            height: 48,
            alignment: Alignment.center,
            child: ImageIcon(
              const AssetImage(CodeLockImages.back),
              size: 24,
              color: CodeLockColor.white,
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              CodeLockColor.bgGradientStart,
              CodeLockColor.bgGradientEnd,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo size increased by ~30% (from 200x80 to 260x104)
              const Center(
                child: Image(
                  image: AssetImage(CodeLockImages.NameLogo),
                  width: 260.0,
                  height: 104.0,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 24),
              
              // Title and Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Text(
                      allLanguages?.languageselection ?? "Choose Language",
                      style: TextStyle(
                        color: CodeLockColor.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Select your preferred application language",
                      style: TextStyle(
                        color: CodeLockColor.white.withOpacity(0.7),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // Language List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  itemCount: controller.language.length,
                  itemBuilder: (BuildContext context, int index) {
                    String engName = controller.language[index];
                    String nativeName = nativeNames[engName] ?? engName;
                    bool isSelected = controller.selectedLanguage == engName;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16), // 16dp spacing
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            controller.selectedLanguage = engName;
                          });
                          languageScreenController.languagechange(context, index);
                          controller.time.stopTimer();
                          Get.offAndToNamed(AppRoutes.MasterPassword);
                        },
                        borderRadius: BorderRadius.circular(18), // Radius 18dp
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          constraints: const BoxConstraints(minHeight: 64),
                          width: double.infinity,
                          // padding removed to allow edge strip
                          decoration: BoxDecoration(
                            color: CodeLockColor.glassBg,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: CodeLockColor.glassBorder,
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              )
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 56, // Fixed width for checkmark area to align all text
                                child: Center(
                                  child: isSelected 
                                    ? Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: CodeLockColor.accentVibrant,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.check_rounded,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      )
                                    : null, // Empty space if not selected
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 20.0, top: 16.0, bottom: 16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        nativeName,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: CodeLockColor.white,
                                          fontWeight: FontWeight.w600, // SemiBold
                                        ),
                                      ),
                                      if (nativeName != engName) ...[
                                        const SizedBox(height: 2),
                                        Text(
                                          engName,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: CodeLockColor.white.withOpacity(0.5),
                                            fontWeight: FontWeight.w500, // Medium
                                          ),
                                        ),
                                      ]
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
