import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/custom/enums.dart';
import 'package:code_lock/custom/Image/code_lock_image.dart';
import 'package:code_lock/custom/extension/extension.dart';
import 'package:code_lock/custom/string/code_lock_string.dart';
import 'package:code_lock/modules/language_select/language_screen_controller.dart';
import 'package:code_lock/modules/start%20screen/start_screen_controller.dart';
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
      appBar: AppBar(
        title: Text(
          allLanguages!.createNewAccount,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: CodeLockColor.white,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
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
                children: [
                  Container(
                    height: context.getHeight * 0.14,
                    width: context.getWidth * 0.6,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: CodeLockColor.accentVibrant.withOpacity(0.15),
                          blurRadius: 40,
                          spreadRadius: 10,
                          offset: const Offset(0, 0),
                        )
                      ],
                      image: const DecorationImage(
                        image: AssetImage(CodeLockImages.NameLogo),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.getWidth * 0.15
                  ),
                  dashBoardMenu.value == DashBoardMenu.startScreen
                      ? Column(
                          children: [
                            CodeLockButton(
                              size: Size(context.getWidth * 0.70,
                                  context.getWidth * 0.14),
                              buttonText: allLanguages!.password,
                              onPressed: () {
                                dashBoardMenu.value =
                                    DashBoardMenu.passWordScreen;
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: SizedBox(
                                    width: context.getWidth * 0.25,
                                    child: Divider(
                                      color: CodeLockColor.white.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                                Text(
                                  allLanguages!.or,
                                  style: TextStyle(
                                      color: CodeLockColor.white.withOpacity(0.8),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: SizedBox(
                                    width: context.getWidth * 0.25,
                                    child: Divider(
                                      color: CodeLockColor.white.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            CodeLockButton(
                              size: Size(context.getWidth * 0.70,
                                  context.getWidth * 0.14),
                              buttonText: allLanguages!.passcode,
                              onPressed: () {
                                dashBoardMenu.value =
                                    DashBoardMenu.passCodeScreen;
                              },
                            ),
                          ],
                        )
                      : const SizedBox(),
                  dashBoardMenu.value == DashBoardMenu.passWordScreen
                      ? Column(
                          children: [
                            SizedBox(
                              height: context.getWidth * 0.1,
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
                              ),
                            ),
                            SizedBox(
                              height: context.getWidth * 0.15,
                            ),
                            CodeLockButton(
                              size: Size(context.getWidth * 0.70,
                                  context.getWidth * 0.14),
                              buttonText: allLanguages!.signIn,
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                dashBoardMenu.value =
                                    DashBoardMenu.passWordScreen;
                                controller.password(context);
                              },
                            ),
                          ],
                        )
                      : const SizedBox(),
                  dashBoardMenu.value == DashBoardMenu.passCodeScreen
                      ? Column(
                          children: [
                            Center(
                              child: Text(
                                allLanguages!.addYourPasscode,
                                style: TextStyle(
                                    color: CodeLockColor.white.withOpacity(0.9),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(height: context.getWidth * 0.02),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0, vertical: 8),
                                child: OTPTextField(
                                  length: 4,
                                  width: MediaQuery.of(context).size.width,
                                  textFieldAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  fieldWidth: 55,
                                  fieldStyle: FieldStyle.box, // Used box to look like glass
                                  outlineBorderRadius: 15,
                                  style: TextStyle(fontSize: 22, color: CodeLockColor.white, fontWeight: FontWeight.bold),
                                  otpFieldStyle: OtpFieldStyle(
                                    disabledBorderColor: CodeLockColor.glassBorder,
                                    enabledBorderColor: CodeLockColor.glassBorder,
                                    focusBorderColor: CodeLockColor.accentVibrant,
                                    errorBorderColor: CodeLockColor.green,
                                    backgroundColor: CodeLockColor.glassBg,
                                  ),
                                  onChanged: (pin) => CodeLockString.pas = pin,
                                  onCompleted: (pin) => CodeLockString.pas = pin,
                                ),
                              ),
                            ),
                            SizedBox(height: context.getWidth * 0.10),
                            Center(
                              child: Text(
                                allLanguages!.confirmPasscode,
                                style: TextStyle(
                                    color: CodeLockColor.white.withOpacity(0.9),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(height: context.getWidth * 0.02),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0, vertical: 8),
                                child: OTPTextField(
                                  length: 4,
                                  width: MediaQuery.of(context).size.width,
                                  textFieldAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  fieldWidth: 55,
                                  fieldStyle: FieldStyle.box,
                                  outlineBorderRadius: 15,
                                  style: TextStyle(fontSize: 22, color: CodeLockColor.white, fontWeight: FontWeight.bold),
                                  otpFieldStyle: OtpFieldStyle(
                                    disabledBorderColor: CodeLockColor.glassBorder,
                                    enabledBorderColor: CodeLockColor.glassBorder,
                                    focusBorderColor: CodeLockColor.accentVibrant,
                                    errorBorderColor: CodeLockColor.green,
                                    backgroundColor: CodeLockColor.glassBg,
                                  ),
                                  onChanged: (pin) => CodeLockString.pas2 = pin,
                                  onCompleted: (pin) => CodeLockString.pas2 = pin,
                                ),
                              ),
                            ),
                            SizedBox(height: context.getWidth * 0.15),
                            CodeLockButton(
                              size: Size(context.getWidth * 0.70,
                                  context.getWidth * 0.14),
                              buttonText: allLanguages!.signIn,
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                dashBoardMenu.value =
                                    DashBoardMenu.passCodeScreen;
                                controller.passCode(context);
                              },
                            ),
                          ],
                        )
                      : const SizedBox(),
                  dashBoardMenu.value == DashBoardMenu.passCodeScreen ||
                          dashBoardMenu.value == DashBoardMenu.passWordScreen
                      ? Column(
                          children: [
                            SizedBox(
                              height: context.getWidth * 0.08,
                            ),
                            CodeLockButton(
                                buttonText: '< Back',
                                size: Size(context.getWidth * 0.3,
                                    context.getWidth * 0.1),
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  dashBoardMenu.value = DashBoardMenu.startScreen;
                                  controller.otp1.clear();
                                  controller.otp2.clear();
                                  controller.otpController1.clear();
                                  controller.otpController2.clear();
                                }),
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
}
