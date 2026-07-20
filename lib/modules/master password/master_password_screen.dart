import 'dart:ui';
import 'package:code_lock/custom/Image/code_lock_image.dart';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/custom/extension/extension.dart';
import 'package:code_lock/custom/string/code_lock_string.dart';
import 'package:code_lock/modules/language_select/language_screen_controller.dart';
import 'package:code_lock/preferences/shared_pref.dart';
import 'package:code_lock/widget/code_lock_button.dart';
import 'package:code_lock/widget/code_lock_tetxtfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'master_password_screen_controller.dart';

class MasterPassword extends GetView<MasterPasswordScreenController> {
  MasterPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.getWidth * 1,
        height: context.getHeight * 1,
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: context.getHeight * 0.12),
              // Logo with soft glow
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
              SizedBox(height: context.getHeight * 0.08),

              // Glassmorphism Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                      decoration: BoxDecoration(
                        color: CodeLockColor.glassBg,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: CodeLockColor.glassBorder,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        children: [
                          if (LocalData.getIsPass == true) ...[
                            Text(
                              "Welcome Back",
                              style: TextStyle(
                                color: CodeLockColor.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Enter your password to continue",
                              style: TextStyle(
                                color: CodeLockColor.white.withOpacity(0.6),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 40),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: codeLockTextfield(
                                controller: controller.password,
                                hintText: allLanguages!.password,
                                firstColor: CodeLockColor.accentVibrant,
                                SecondColor: Colors.black.withOpacity(0.2), // darker inset
                                HinttextColor: CodeLockColor.white.withOpacity(0.5),
                                cursorColor: CodeLockColor.accentVibrant,
                                isPassword: true,
                              ),
                            ),
                            const SizedBox(height: 40),
                            _buildModernButton(
                              context,
                              text: allLanguages!.signIn,
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                controller.passwordToast(context);
                              },
                            )
                          ],
                          if (LocalData.getIsPass == false) ...[
                            Text(
                              "Enter Passcode",
                              style: TextStyle(
                                color: CodeLockColor.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Secure your data",
                              style: TextStyle(
                                color: CodeLockColor.white.withOpacity(0.6),
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 40),
                            Center(
                              child: OTPTextField(
                                length: 4,
                                width: MediaQuery.of(context).size.width,
                                textFieldAlignment: MainAxisAlignment.spaceEvenly,
                                fieldWidth: 50,
                                fieldStyle: FieldStyle.box,
                                outlineBorderRadius: 15,
                                style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                                otpFieldStyle: OtpFieldStyle(
                                  disabledBorderColor: CodeLockColor.glassBorder,
                                  enabledBorderColor: CodeLockColor.glassBorder,
                                  focusBorderColor: CodeLockColor.accentVibrant,
                                  errorBorderColor: CodeLockColor.red,
                                  backgroundColor: Colors.black.withOpacity(0.2),
                                ),
                                onChanged: (pin) {
                                  if (pin.length == 4) {
                                    CodeLockString.pas3 = pin;
                                  }
                                },
                                onCompleted: (pin) => CodeLockString.pas3 = pin,
                              ),
                            ),
                            const SizedBox(height: 40),
                            _buildModernButton(
                              context,
                              text: allLanguages!.signIn,
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                controller.passCodeToast(context);
                              },
                            )
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: context.getHeight * 0.1),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernButton(BuildContext context, {required String text, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 56,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                CodeLockColor.accentVibrant,
                CodeLockColor.accentVibrant.withOpacity(0.8),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: CodeLockColor.accentVibrant.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: CodeLockColor.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.1,
            ),
          ),
        ),
      ),
    );
  }
}
