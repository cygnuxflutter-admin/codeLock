import 'dart:io';
import 'package:code_lock/app_database/app_database.dart';
import 'package:code_lock/widget/code_lock_toast.dart';
import 'package:code_lock/modules/home_screen/home_screen_controller.dart' hide Status;
import 'package:code_lock/app_database/database_helper/database_helper.dart';
import 'package:code_lock/app_routes.dart';
import 'package:code_lock/custom/Image/code_lock_image.dart';
import 'package:code_lock/custom/detectTimer.dart';
import 'package:code_lock/custom/extension/extension.dart';
import 'package:code_lock/custom/string/code_lock_string.dart';
import 'package:code_lock/models/get_database/get_description.dart';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/models/get_database/get_titles.dart';
import 'package:code_lock/modules/language_select/language_screen_controller.dart';
import 'package:code_lock/widget/code_lock_button.dart';
import 'package:code_lock/widget/code_lock_checkbox.dart';
import 'package:code_lock/widget/code_lock_datepicker.dart';
import 'package:code_lock/widget/code_lock_imagepicker.dart';
import 'package:code_lock/widget/code_lock_imageviewer.dart';
import 'package:code_lock/widget/code_lock_infoTextfield.dart';
import 'package:code_lock/widget/code_lock_passtextfield.dart';
import 'package:code_lock/widget/code_lock_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Description_screen_controller.dart';

class DescriptionScreen extends GetView<DescriptionScreenController> {
  DescriptionScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> args = Get.arguments;

  final AppDataBase _appDataBase = AppDataBase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            detectOnTap();
            Get.back();
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ImageIcon(
              const AssetImage(CodeLockImages.back),
              color: CodeLockColor.white,
              size: 10,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          args['titleName'],
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
            const SizedBox(height: 10),
            Obx(
              () {
                // controller.titleEdit =
                //     TextEditingController(text: args["titleName"].toString());

                switch (controller.status.value) {
                  case Status.loading:
                    return Center(
                      child: CircularProgressIndicator(
                        color: CodeLockColor.homelist,
                      ),
                    );

                  case Status.error:
                    return Center(child: Text(CodeLockString.error));

                  case Status.done:
                    return Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          controller.enable.value == false && controller.titleEdit.text.isEmpty
                              ? const SizedBox.shrink()
                              : Info_textField(
                                  controller: controller.titleEdit,
                                  hintText: args['titleName'].toString(),
                                  keyboardType: TextInputType.text,
                                  titleText: allLanguages!.title,
                                  obscureText: false,
                                  enabled: controller.enable.value,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return CodeLockString.enterTitle;
                                    }
                                    return null;
                                  },
                                ),
                        controller.enable.value == false && controller.titleEdit.text.isEmpty
                            ? const SizedBox.shrink()
                            : SizedBox(height: context.getWidth * 0.03),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.enable.value
                              ? controller.dataIn.length
                              : controller.dataIn.where((e) => e.value!.text.isNotEmpty).length,
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(height: context.getWidth * 0.03),
                          itemBuilder: (context, index) {
                            DescriptionModel data = controller.enable.value
                                ? controller.dataIn[index]
                                : controller.dataIn.where((e) => e.value!.text.isNotEmpty).toList()[index];

                            return keyboardType(data.subFieldType) == 'CheckBox'
                                ? CustomCheckbox(
                                    titleText: data.subName.toString(),
                                    checkValue: (String value) {
                                      controller.dataIn[index].value =
                                          TextEditingController(
                                              text: value.toString());
                                    },
                                    colorValue:
                                        controller.dataIn[index].value!.text ==
                                                CodeLockString.yes
                                            ? 0
                                            : 1,
                                    enable: controller.enable,
                                  )
                                : keyboardType(data.subFieldType) ==
                                        'ImagePicker'
                                    ? ImageViewer(
                                        titleText: data.subName.toString(),
                                        getDatabaseImage: controller
                                            .dataIn[index].value!.text,
                                        enable: controller.enable,
                                        newImageName: (String imgName) {
                                          controller.newImageName = imgName;
                                          controller.dataIn[index].value =
                                              TextEditingController(
                                                  text: imgName);
                                        },
                                        imgFile: (File filename) {
                                          controller.newFileName = filename;
                                        },
                                      )
                                    : keyboardType(data.subFieldType) ==
                                            'Password'
                                        ? PassTextField(
                                            enabled: controller.enable.value,
                                            titleText: data.subName.toString(),
                                            hintText:
                                                data.value!.text.toString(),
                                            keyboardType: TextInputType.text,
                                            controller:
                                                controller.dataIn[index].value,
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
                                                    data.value!.text.toString(),
                                                controller: controller
                                                    .dataIn[index].value,
                                                enabled:
                                                    controller.enable.value,
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
                                                    hintText: data.value!.text
                                                        .toString(),
                                                    controller: controller
                                                        .dataIn[index].value,
                                                    enabled:
                                                        controller.enable.value,
                                                    validator: (value) {
                                                      if (value == null || value.trim().isEmpty) {
                                                        return "ENTER ${data.subName.toString().toUpperCase()}";
                                                      }
                                                      return null;
                                                    },
                                                  )
                                                : Info_textField(
                                                    enabled:
                                                        controller.enable.value,
                                                    titleText:
                                                        data.subName.toString(),
                                                    hintText: data.value!.text
                                                        .toString(),
                                                    keyboardType: keyboardType(
                                                        data.subFieldType),
                                                    controller: controller
                                                        .dataIn[index].value,
                                                    obscureText: false,
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
                         controller.enable.value == true ?
                          GestureDetector(
                           onTap: () async {
                             detectOnTap();

                             if (_formKey.currentState?.validate() ?? false) {
                               String titleId = args['titleId'];

                             //update description table
                             List<DescriptionModel> descriptionModel =
                                 controller.dataIn;

                             int i = 0;
                             for (i = 0; i < controller.dataIn.length; i++) {
                               final updatedDescription = DescriptionModel(
                                 catId: descriptionModel[i].catId.toString(),
                                 subId: descriptionModel[i].subId.toString(),
                                 subName: descriptionModel[i].subName,
                                 subFieldType: descriptionModel[i].subFieldType,
                                 titleId: titleId,
                                 titleName: controller.titleEdit.text,
                                 valueId: descriptionModel[i].valueId,
                                 value: descriptionModel[i].value,
                               );

                               _appDataBase.updateDescription(
                                   updatedDescription.toMap(),
                                   Tables.descriptions,
                                   descriptionModel[i].valueId.toString());
                             }

                             //update title table
                             List<TitleModel> titleModel =
                                 controller.titleDataIn;

                             int a = 0;
                             for (a = 0;
                             a < controller.titleDataIn.length;
                             a++) {
                               final updateTitle = TitleModel(
                                 catId: titleModel[a].catId,
                                 titleId: titleId,
                                 titleName: controller.titleEdit.text,
                                 openedCount: titleModel[a].openedCount,
                               );

                               _appDataBase.updateTitle(
                                   updateTitle.toMap(), Tables.titles, titleId);
                             }

                             //update image in app directory
                             if (controller.newFileName != null) {
                               List<int> imageBytes =
                               await controller.newFileName!.readAsBytes();
                               saveImageToAppDir(imageBytes,
                                   controller.newImageName.toString());
                             }

                             //after complete insert and save image
                             if (Get.isRegistered<HomeScreenController>()) {
                               Get.find<HomeScreenController>().getCatMainData();
                               Get.find<HomeScreenController>().getTitleData();
                             }
                             ScaffoldMessenger.of(context).showSnackBar(
                               snackBar(
                                 context: context,
                                 msg: "Edited Successfully",
                               ),
                             );
                             Get.until((route) => route.settings.name == AppRoutes.HomeScreen);
                             } // closes if form validate
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
                                 "Save Edits",
                                 style: const TextStyle(
                                   color: Colors.white,
                                   fontSize: 20,
                                   fontWeight: FontWeight.bold,
                                   letterSpacing: 1.0,
                                 ),
                               ),
                             ),
                           ),
                          ) : const SizedBox(),
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
      ),
      ),
    );
  }
}
