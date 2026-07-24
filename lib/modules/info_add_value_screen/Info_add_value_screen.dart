import 'dart:io';
import 'package:code_lock/app_database/app_database.dart';
import 'package:code_lock/widget/code_lock_toast.dart';
import 'package:code_lock/app_routes.dart';
import 'package:code_lock/modules/home_screen/home_screen_controller.dart' hide Status;
import 'package:code_lock/custom/detectTimer.dart';
import 'package:code_lock/custom/extension/extension.dart';
import 'package:code_lock/custom/image/code_lock_image.dart';
import 'package:code_lock/custom/string/code_lock_string.dart';
import 'package:code_lock/modules/language_select/language_screen_controller.dart';
import 'package:code_lock/models/get_database/get_subcat.dart';
import 'package:code_lock/models/insert_database/description_insert.dart';
import 'package:code_lock/models/insert_database/title_insert.dart';
import 'package:code_lock/widget/code_lock_button.dart';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/widget/code_lock_checkbox.dart';
import 'package:code_lock/widget/code_lock_datepicker.dart';
import 'package:code_lock/widget/code_lock_imagepicker.dart';
import 'package:code_lock/widget/code_lock_infoTextfield.dart';
import 'package:code_lock/widget/code_lock_passtextfield.dart';
import 'package:code_lock/widget/code_lock_timepicker.dart';
import 'package:code_lock/widget/code_lock_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Info_add_value_screen_controller.dart';

class Infoaddvalue extends GetView<InfoAddValueScreenController> {
  Infoaddvalue({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allow gradient behind AppBar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent, // Transparent AppBar
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
            detectOnTap();
            controller.titleController.clear();
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ImageIcon(
              const AssetImage(CodeLockImages.back),
              color: CodeLockColor.white, // light icon
              size: 10,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          allLanguages!.addValue,
          style: TextStyle(color: CodeLockColor.white, fontWeight: FontWeight.bold),
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
            child: Column(
              children: [
                Obx(
                  () {
                    switch (controller.status.value) {
                      case Status.loading:
                        return Center(
                          child: CircularProgressIndicator(
                            color: CodeLockColor.accentVibrant,
                          ),
                        );

                      case Status.error:
                        return Center(child: Text(CodeLockString.error, style: TextStyle(color: CodeLockColor.white)));

                      case Status.done:
                        return Form(
                          key: _formKey,
                          child: Column(
                          children: [
                        SizedBox(height: context.getWidth * 0.04),
                        Info_textField(
                          controller: controller.titleController,
                          hintText: CodeLockString.title,
                          keyboardType: TextInputType.text,
                          titleText: CodeLockString.title,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return CodeLockString.enterTitle;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: context.getWidth * 0.03),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.dataIn.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(height: context.getWidth * 0.03),
                          itemBuilder: (context, index) {
                            SubCat data = controller.dataIn[index];

                            return keyboardType(data.subFieldType) == 'CheckBox'
                                ? CustomCheckbox(
                                    titleText: data.subName.toString(),
                                    checkValue: (String checkValue) {
                                      controller.dataIn[index].controller =
                                          TextEditingController(
                                              text: checkValue.toString());
                                    },
                                    colorValue: int.tryParse(data.isMandatory?.toString() ?? '2') ?? 2,
                                    enable: true.obs,
                                  )
                                : keyboardType(data.subFieldType) ==
                                        'ImagePicker'
                                    ? ImageContainer(
                                        titleText: data.subName.toString(),
                                        imageName: (String imgName) {
                                          controller.imgName = imgName;
                                          controller.dataIn[index].controller =
                                              TextEditingController(
                                                  text: imgName.toString());
                                        },
                                        imgFile: (File filename) {
                                          controller.newFileName = filename;
                                        },
                                      )
                                    : keyboardType(data.subFieldType) ==
                                            'Password'
                                            ? PassTextField(
                                                controller: controller
                                                    .dataIn[index].controller,
                                                titleText: data.subName.toString(),
                                                hintText: data.subName.toString(),
                                                keyboardType: TextInputType.text,
                                                obscureText: true,
                                                validator: (value) {
                                                  if (value == null || value.trim().isEmpty) {
                                                    return "ENTER ${data.subName.toString().toUpperCase()}";
                                                  }
                                                  return null;
                                                },
                                              )
                                        : keyboardType(data.subFieldType) ==
                                                'DatePicker'
                                            ? DatePicker(
                                                titleText:
                                                    data.subName.toString(),
                                                hintText:
                                                    data.subName.toString(),
                                                controller: controller
                                                    .dataIn[index].controller,
                                                validator: (value) {
                                                  if (value == null || value.trim().isEmpty) {
                                                    return "ENTER ${data.subName.toString().toUpperCase()}";
                                                  }
                                                  return null;
                                                },
                                              )
                                            : keyboardType(data.subFieldType) ==
                                                    'TimePicker'
                                                ? TimePicker(
                                                    titleText:
                                                        data.subName.toString(),
                                                    hintText:
                                                        data.subName.toString(),
                                                    controller: controller
                                                        .dataIn[index]
                                                        .controller,
                                                    validator: (value) {
                                                      if (value == null || value.trim().isEmpty) {
                                                        return "ENTER ${data.subName.toString().toUpperCase()}";
                                                      }
                                                      return null;
                                                    },
                                                  )
                                                : Info_textField(
                                                    key: Key("${data.subId}"),
                                                    controller: controller
                                                        .dataIn[index]
                                                        .controller,
                                                    hintText:
                                                        data.subName.toString(),
                                                    titleText:
                                                        data.subName.toString(),
                                                    keyboardType: keyboardType(
                                                        data.subFieldType),
                                                    obscureText:
                                                        keyboardObSecure(
                                                            data.subFieldType),
                                                    validator: (value) {
                                                      if (value == null || value.isEmpty) {
                                                        return "ENTER ${data.subName.toString().toUpperCase()}";
                                                      }
                                                      return null;
                                                    },
                                                  );
                          },
                        ),
                        SizedBox(height: context.getWidth * 0.05),
                        GestureDetector(
                          onTap: () async {
                            detectOnTap();
                            _formKey.currentState?.validate();
                            
                            if (controller.titleController.text.isEmpty) {
                              // Inline validator already shows the error text
                            } else {
                              List<SubCat> subData = controller.dataIn;

                              for (int i = 0; i < subData.length; i++) {
                                if (subData[i].controller!.text.isEmpty) {
                                  controller.canInsert.value = false;
                                  break;
                                } else {
                                  controller.canInsert.value = true;
                                }
                              }

                              if (controller.canInsert.value) {
                                String catID = Get.arguments;

                                //insert title
                                TitleData titleData = TitleData(
                                  catId: catID,
                                  titleId:
                                      'F_${DateTime.now().microsecondsSinceEpoch}',
                                  titleName: controller.titleController.text,
                                  openedCount: 0,
                                );
                                titleData.insertTitleData();

                                // insert description
                                for (int i = 0; i < subData.length; i++) {
                                  DescriptionData descriptionData =
                                      DescriptionData(
                                    catId: catID,
                                    subId: subData[i].subId.toString(),
                                    subName: subData[i].subName.toString(),
                                    subFieldType:
                                        subData[i].subFieldType.toString(),
                                    titleId: titleData.titleId,
                                    titleName: titleData.titleName,
                                    valueId:
                                        'F_${DateTime.now().microsecondsSinceEpoch}',
                                    value:
                                        subData[i].controller!.text.toString(),
                                  );

                                  descriptionData.insertDescriptionData();
                                }

                                // save image in aap directory
                                if (controller.newFileName != null) {
                                  List<int> imageBytes = await controller
                                      .newFileName!
                                      .readAsBytes();
                                  saveImageToAppDir(imageBytes,
                                      controller.imgName.toString());
                                }

                                // after completing inserting database and save image
                                if (Get.isRegistered<HomeScreenController>()) {
                                  Get.find<HomeScreenController>().getCatMainData();
                                  Get.find<HomeScreenController>().getTitleData();
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  snackBar(
                                    context: context,
                                    msg: "Saved Successfully",
                                  ),
                                );
                                Get.until((route) => route.settings.name == AppRoutes.HomeScreen);
                              } else {
                                // Inline validator already shows the error text
                              }
                            }
                          },
                          child: Container(
                            width: context.getWidth * 0.9,
                            height: context.getHeight * 0.065,
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
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                allLanguages!.saveSubValue,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: context.getWidth * 0.1),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    ), // closes SafeArea
  ), // closes Container
); // closes Scaffold
  }
}
