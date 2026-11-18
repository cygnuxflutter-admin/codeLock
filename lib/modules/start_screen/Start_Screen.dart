import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/custom/enums.dart';
import 'package:code_lock/custom/Image/code_lock_image.dart';
import 'package:code_lock/custom/extension/extension.dart';
import 'package:code_lock/custom/string/code_lock_string.dart';
import 'package:code_lock/modules/language_select/language_screen_controller.dart';
import 'package:code_lock/modules/start_screen/start_screen_controller.dart';
import 'package:code_lock/widget/code_lock_button.dart';
import 'package:code_lock/widget/code_lock_tetxtfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class StartScreen extends GetView<StartScreenController> {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Obx(
        () => Container(
          height: context.getHeight * 1,
          width: context.getWidth * 1,
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header section
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 16.0),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: CodeLockColor.white, size: 20),
                      onPressed: () {
                        if (dashBoardMenu.value != DashBoardMenu.startScreen) {
                          dashBoardMenu.value = DashBoardMenu.startScreen;
                          controller.otp1.clear();
                          controller.otp2.clear();
                          controller.otpController1.clear();
                          controller.otpController2.clear();
                        } else {
                          Get.back();
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      allLanguages!.createNewAccount,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: CodeLockColor.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                    child: Text(
                      dashBoardMenu.value == DashBoardMenu.passWordScreen
                          ? "Create a strong password to protect your vault."
                          : (dashBoardMenu.value == DashBoardMenu.passCodeScreen
                              ? "Create a secure 4-digit passcode to protect your vault."
                              : "Choose how you want to secure your vault."),
                      style: TextStyle(
                        fontSize: 14,
                        color: CodeLockColor.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                  SizedBox(height: context.getHeight * 0.04),
                  


                  dashBoardMenu.value == DashBoardMenu.startScreen
                      ? Column(
                          children: [
                            _buildSelectionCard(
                              icon: Icons.lock,
                              title: "Use ${allLanguages!.password}",
                              subtitle: "Secure your vault with a strong password",
                              onTap: () {
                                dashBoardMenu.value = DashBoardMenu.passWordScreen;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 40.0),
                              child: Row(
                                children: [
                                  Expanded(child: Divider(color: CodeLockColor.white.withOpacity(0.2))),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Text(
                                      allLanguages!.or,
                                      style: TextStyle(color: CodeLockColor.white.withOpacity(0.5), fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Expanded(child: Divider(color: CodeLockColor.white.withOpacity(0.2))),
                                ],
                              ),
                            ),
                            _buildSelectionCard(
                              icon: Icons.apps,
                              title: "Use ${allLanguages!.passcode}",
                              subtitle: "Secure your vault with a 4-6 digit passcode",
                              onTap: () {
                                dashBoardMenu.value = DashBoardMenu.passCodeScreen;
                              },
                            ),
                          ],
                        )
                      : const SizedBox(),
                  dashBoardMenu.value == DashBoardMenu.passWordScreen
                      ? Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: context.getWidth * 0.05,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20),
                                child: codeLockTextfield(
                                  controller: controller.otp1,
                                  keyboardType: TextInputType.text,
                                  hintText: allLanguages!.password,
                                  firstColor: CodeLockColor.accentVibrant,
                                  SecondColor: CodeLockColor.glassBg,
                                  HinttextColor: CodeLockColor.white,
                                  cursorColor: CodeLockColor.accentVibrant,
                                  isPassword: true,
                                  validator: (val) => val == null || val.isEmpty ? "Please enter your password" : null,
                                ),
                              ),
                              SizedBox(
                                height: context.getWidth * 0.050,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20),
                                child: codeLockTextfield(
                                  controller: controller.otp2,
                                  keyboardType: TextInputType.text,
                                  hintText: allLanguages!.confirmPassword,
                                  firstColor: CodeLockColor.accentVibrant,
                                  SecondColor: CodeLockColor.glassBg,
                                  HinttextColor: CodeLockColor.white,
                                  cursorColor: CodeLockColor.accentVibrant,
                                  isPassword: true,
                                  validator: (val) => val == null || val.isEmpty ? "Please confirm your password" : null,
                                ),
                              ),
                            SizedBox(
                              height: context.getWidth * 0.15,
                            ),
                            CodeLockButton(
                              size: Size(context.getWidth * 0.70,
                                  context.getWidth * 0.14),
                              buttonText: "Create Account",
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                if (controller.formKey.currentState!.validate()) {
                                  controller.password(context);
                                }
                              },
                            ),
                          ],
                        ),
                      )
                      : const SizedBox(),
                  dashBoardMenu.value == DashBoardMenu.passCodeScreen
                      ? Column(
                          children: [
                            SizedBox(height: context.getWidth * 0.02),
                            Center(
                              child: Text(
                                "Create Passcode",
                                style: TextStyle(
                                    color: CodeLockColor.white.withOpacity(0.9),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(height: context.getWidth * 0.04),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0, vertical: 8),
                                child: OTPTextField(
                                  length: 4,
                                  width: MediaQuery.of(context).size.width,
                                  textFieldAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  fieldWidth: 65,
                                  fieldStyle: FieldStyle.box,
                                  outlineBorderRadius: 16,
                                  obscureText: true,
                                  style: TextStyle(fontSize: 28, color: CodeLockColor.white, fontWeight: FontWeight.bold),
                                  otpFieldStyle: OtpFieldStyle(
                                    disabledBorderColor: CodeLockColor.glassBorder,
                                    enabledBorderColor: CodeLockColor.glassBorder,
                                    focusBorderColor: CodeLockColor.accentVibrant,
                                    errorBorderColor: CodeLockColor.green,
                                    backgroundColor: CodeLockColor.glassBg,
                                  ),
                                  onChanged: (pin) {
                                    CodeLockString.pas = pin;
                                    controller.passcodeText.value = pin;
                                  },
                                  onCompleted: (pin) {
                                    CodeLockString.pas = pin;
                                    controller.passcodeText.value = pin;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: context.getWidth * 0.06),
                            Center(
                              child: Text(
                                allLanguages!.confirmPasscode,
                                style: TextStyle(
                                    color: CodeLockColor.white.withOpacity(0.9),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(height: context.getWidth * 0.04),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0, vertical: 8),
                                child: OTPTextField(
                                  length: 4,
                                  width: MediaQuery.of(context).size.width,
                                  textFieldAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  fieldWidth: 65,
                                  fieldStyle: FieldStyle.box,
                                  outlineBorderRadius: 16,
                                  obscureText: true,
                                  style: TextStyle(fontSize: 28, color: CodeLockColor.white, fontWeight: FontWeight.bold),
                                  otpFieldStyle: OtpFieldStyle(
                                    disabledBorderColor: CodeLockColor.glassBorder,
                                    enabledBorderColor: CodeLockColor.glassBorder,
                                    focusBorderColor: CodeLockColor.accentVibrant,
                                    errorBorderColor: CodeLockColor.green,
                                    backgroundColor: CodeLockColor.glassBg,
                                  ),
                                  onChanged: (pin) {
                                    CodeLockString.pas2 = pin;
                                    controller.confirmPasscodeText.value = pin;
                                  },
                                  onCompleted: (pin) {
                                    CodeLockString.pas2 = pin;
                                    controller.confirmPasscodeText.value = pin;
                                  },
                                ),
                              ),
                            ),
                            
                            // Passcode Validation Indicator
                            if (controller.passcodeText.value.length == 4 && controller.confirmPasscodeText.value.length == 4)
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Text(
                                  controller.passcodeText.value == controller.confirmPasscodeText.value 
                                    ? "✓ Passcodes match"
                                    : "Passcodes do not match.",
                                  style: TextStyle(
                                    color: controller.passcodeText.value == controller.confirmPasscodeText.value 
                                      ? CodeLockColor.green 
                                      : CodeLockColor.white.withOpacity(0.7),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                            SizedBox(height: context.getWidth * 0.10),
                            CodeLockButton(
                              size: Size(context.getWidth * 0.70,
                                  context.getWidth * 0.14),
                              buttonText: "Create Account",
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                controller.passCode(context);
                              },
                            ),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        decoration: BoxDecoration(
          color: CodeLockColor.glassBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: CodeLockColor.glassBorder.withOpacity(0.1)),
          boxShadow: [
             BoxShadow(
                color: CodeLockColor.accentVibrant.withOpacity(0.08),
                blurRadius: 15,
                spreadRadius: 2,
             )
          ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: onTap,
            child: IntrinsicHeight(
              child: Row(
                children: [
                  // Purple left accent line
                  Container(
                    width: 4,
                    color: CodeLockColor.accentVibrant,
                  ),
                  const SizedBox(width: 16),
                  // Icon container
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: CodeLockColor.accentVibrant,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: Colors.white, size: 28),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Text Column
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                color: CodeLockColor.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            style: TextStyle(
                                color: CodeLockColor.white.withOpacity(0.6),
                                fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Chevron
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Icon(Icons.arrow_forward_ios,
                        color: CodeLockColor.white.withOpacity(0.8), size: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
