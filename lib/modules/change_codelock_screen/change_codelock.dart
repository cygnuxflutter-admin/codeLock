import 'package:code_lock/custom/Image/code_lock_image.dart';
import 'package:code_lock/custom/detectTimer.dart';
import 'package:code_lock/custom/extension/extension.dart';
import 'package:code_lock/custom/string/code_lock_string.dart';
import 'package:code_lock/modules/language_select/language_screen_controller.dart';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/preferences/shared_pref.dart';
import 'package:code_lock/widget/code_lock_button.dart';
import 'package:code_lock/widget/code_lock_tetxtfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'change_codelock_controller.dart';

class ChangeCodeLockScreen extends GetView<ChangeCodeLockScreenController> {
  const ChangeCodeLockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Get.back();
          },
          child: Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            child: const ImageIcon(
              AssetImage(CodeLockImages.back),
              size: 24,
              color: Colors.white,
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Image(
                    image: const AssetImage(CodeLockImages.change_lock),
                    width: context.getWidth * 0.32, // Reduced by 20%
                  ),
                  const SizedBox(height: 24),
                  Text(
                    allLanguages!.changeCodelock,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: CodeLockColor.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Create a new secure 4-digit passcode",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  LocalData.getIsPass == true
                      ? Form(
                          key: controller.formKeyPassword,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: codeLockTextfield(
                                  controller: controller.otp3,
                                  keyboardType: TextInputType.text,
                                  hintText: allLanguages!.OldPassword,
                                  firstColor: CodeLockColor.white,
                                  SecondColor: CodeLockColor.gray,
                                  HinttextColor: CodeLockColor.darkblue,
                                  cursorColor: CodeLockColor.white,
                                  onChanged: detectOnTap(),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return allLanguages!.entersomething;
                                    }
                                    if (value != LocalData.getPasswordData) {
                                      return allLanguages!.oldpwdiswrong;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 28),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: codeLockTextfield(
                                  controller: controller.otp4,
                                  keyboardType: TextInputType.text,
                                  hintText: allLanguages!.newpassword,
                                  firstColor: CodeLockColor.white,
                                  SecondColor: CodeLockColor.gray,
                                  HinttextColor: CodeLockColor.darkblue,
                                  cursorColor: CodeLockColor.white,
                                  onChanged: detectOnTap(),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return allLanguages!.entersomething;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 28),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: codeLockTextfield(
                                  controller: controller.otp5,
                                  keyboardType: TextInputType.text,
                                  hintText: allLanguages!.confirmPassword,
                                  firstColor: CodeLockColor.white,
                                  SecondColor: CodeLockColor.gray,
                                  HinttextColor: CodeLockColor.darkblue,
                                  cursorColor: CodeLockColor.white,
                                  onChanged: detectOnTap(),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return allLanguages!.entersomething;
                                    }
                                    if (value != controller.otp4.text) {
                                      return allLanguages!.newpwdisnotmatch;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                                                            const SizedBox(height: 40),
                              Container(
                                width: double.infinity,
                                height: 56,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  gradient: LinearGradient(
                                    colors: [
                                      CodeLockColor.accentVibrant,
                                      CodeLockColor.accentVibrant.withOpacity(0.8),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: CodeLockColor.accentVibrant.withOpacity(0.3),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  onPressed: () {
                                    detectOnTap();
                                    FocusScope.of(context).unfocus();
                                    controller.password(context);
                                  },
                                  child: const Text(
                                    "Change Password",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : const SizedBox(),
                  LocalData.getIsPass == false
                      ? Form(
                          key: controller.formKeyPasscode,
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  allLanguages!.oldpasscode,
                                  style: TextStyle(
                                    color: CodeLockColor.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: FormField<String>(
                                    validator: (value) {
                                      if (CodeLockString.pas4.isEmpty) {
                                        return allLanguages!.entersomething;
                                      } else if (CodeLockString.pas4.length < 4) {
                                        return allLanguages!.passcodelenghthshouldbe4digit;
                                      } else if (CodeLockString.pas4 != LocalData.getPasswordData) {
                                        return allLanguages!.oldpwdiswrong;
                                      }
                                      return null;
                                    },
                                    builder: (FormFieldState<String> state) {
                                      return Column(
                                        children: [
                                                                                    OTPTextField(
                                              length: 4,
                                              width: MediaQuery.of(context).size.width,
                                              textFieldAlignment: MainAxisAlignment.spaceEvenly,
                                              fieldWidth: 64,
                                              fieldStyle: FieldStyle.box,
                                              outlineBorderRadius: 16,
                                              style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                                              otpFieldStyle: OtpFieldStyle(
                                                disabledBorderColor: CodeLockColor.glassBorder,
                                                focusBorderColor: CodeLockColor.accentVibrant,
                                                errorBorderColor: state.hasError ? CodeLockColor.red : CodeLockColor.accentVibrant,
                                                backgroundColor: CodeLockColor.glassBg,
                                                borderColor: CodeLockColor.glassBorder,
                                              ),
                                              onChanged: (pin) {
                                                detectOnTap();
                                                CodeLockString.pas4 = pin;
                                                state.didChange(pin);
                                              },
                                              onCompleted: (pin) {
                                                detectOnTap();
                                                CodeLockString.pas4 = pin;
                                                state.didChange(pin);
                                              }),
                                          if (state.hasError)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0),
                                              child: Text(
                                                state.errorText!,
                                                style: const TextStyle(color: Colors.red, fontSize: 12),
                                              ),
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 28),
                              Center(
                                child: Text(
                                  allLanguages!.newpasscode,
                                  style: TextStyle(
                                    color: CodeLockColor.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: FormField<String>(
                                    validator: (value) {
                                      if (CodeLockString.pas5.isEmpty) {
                                        return allLanguages!.entersomething;
                                      } else if (CodeLockString.pas5.length < 4) {
                                        return allLanguages!.passcodelenghthshouldbe4digit;
                                      }
                                      return null;
                                    },
                                    builder: (FormFieldState<String> state) {
                                      return Column(
                                        children: [
                                                                                    OTPTextField(
                                              length: 4,
                                              width: MediaQuery.of(context).size.width,
                                              textFieldAlignment: MainAxisAlignment.spaceEvenly,
                                              fieldWidth: 64,
                                              fieldStyle: FieldStyle.box,
                                              outlineBorderRadius: 16,
                                              style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                                              otpFieldStyle: OtpFieldStyle(
                                                disabledBorderColor: CodeLockColor.glassBorder,
                                                focusBorderColor: CodeLockColor.accentVibrant,
                                                errorBorderColor: state.hasError ? CodeLockColor.red : CodeLockColor.accentVibrant,
                                                backgroundColor: CodeLockColor.glassBg,
                                                borderColor: CodeLockColor.glassBorder,
                                              ),
                                              onChanged: (pin) {
                                                detectOnTap();
                                                CodeLockString.pas5 = pin;
                                                state.didChange(pin);
                                              },
                                              onCompleted: (pin) {
                                                detectOnTap();
                                                CodeLockString.pas5 = pin;
                                                state.didChange(pin);
                                              }),
                                          if (state.hasError)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0),
                                              child: Text(
                                                state.errorText!,
                                                style: const TextStyle(color: Colors.red, fontSize: 12),
                                              ),
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 28),
                              Center(
                                child: Text(
                                  allLanguages!.confirmPasscode,
                                  style: TextStyle(
                                    color: CodeLockColor.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                  child: FormField<String>(
                                    validator: (value) {
                                      if (CodeLockString.pas6.isEmpty) {
                                        return allLanguages!.entersomething;
                                      } else if (CodeLockString.pas6 != CodeLockString.pas5) {
                                        return allLanguages!.newpwdisnotmatch;
                                      }
                                      return null;
                                    },
                                    builder: (FormFieldState<String> state) {
                                      return Column(
                                        children: [
                                                                                    OTPTextField(
                                              length: 4,
                                              width: MediaQuery.of(context).size.width,
                                              textFieldAlignment: MainAxisAlignment.spaceEvenly,
                                              fieldWidth: 64,
                                              fieldStyle: FieldStyle.box,
                                              outlineBorderRadius: 16,
                                              style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                                              otpFieldStyle: OtpFieldStyle(
                                                disabledBorderColor: CodeLockColor.glassBorder,
                                                focusBorderColor: CodeLockColor.accentVibrant,
                                                errorBorderColor: state.hasError ? CodeLockColor.red : CodeLockColor.accentVibrant,
                                                backgroundColor: CodeLockColor.glassBg,
                                                borderColor: CodeLockColor.glassBorder,
                                              ),
                                              onChanged: (pin) {
                                                detectOnTap();
                                                CodeLockString.pas6 = pin;
                                                state.didChange(pin);
                                              },
                                              onCompleted: (pin) {
                                                detectOnTap();
                                                CodeLockString.pas6 = pin;
                                                state.didChange(pin);
                                              }),
                                          if (state.hasError)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0),
                                              child: Text(
                                                state.errorText!,
                                                style: const TextStyle(color: Colors.red, fontSize: 12),
                                              ),
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                                                            const SizedBox(height: 40),
                              Container(
                                width: double.infinity,
                                height: 56,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  gradient: LinearGradient(
                                    colors: [
                                      CodeLockColor.accentVibrant,
                                      CodeLockColor.accentVibrant.withOpacity(0.8),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: CodeLockColor.accentVibrant.withOpacity(0.3),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  onPressed: () {
                                    detectOnTap();
                                    FocusScope.of(context).unfocus();
                                    controller.newPasswordToast(context);
                                  },
                                  child: const Text(
                                    "Change Passcode",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
