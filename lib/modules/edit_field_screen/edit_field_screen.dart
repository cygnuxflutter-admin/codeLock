import 'package:code_lock/app_database/app_database.dart';
import 'package:code_lock/widget/code_lock_toast.dart';
import 'package:code_lock/app_routes.dart';
import 'package:code_lock/modules/home_screen/home_screen_controller.dart' hide Status;
import 'package:code_lock/custom/detectTimer.dart';
import 'package:code_lock/custom/extension/extension.dart';
import 'package:code_lock/custom/image/code_lock_image.dart';
import 'package:code_lock/custom/string/code_lock_string.dart';
import 'package:code_lock/models/insert_database/cat_main_insert.dart';
import 'package:code_lock/models/insert_database/sub_cat_insert.dart';
import 'package:code_lock/modules/language_select/language_screen_controller.dart';
import 'package:code_lock/app_database/database_helper/database_helper.dart';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/widget/code_lock_tetxtfield.dart';
import 'package:code_lock/widget/code_lock_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'edit_field_screen_controller.dart';

class EditFieldScreen extends StatefulWidget {
  const EditFieldScreen({Key? key}) : super(key: key);

  @override
  State<EditFieldScreen> createState() => _EditFieldScreenState();
}

class _EditFieldScreenState extends State<EditFieldScreen> {
  final EditFieldScreenController controller = Get.put(EditFieldScreenController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            child: ImageIcon(
              const AssetImage(CodeLockImages.back), 
              size: 18, 
              color: CodeLockColor.white,
            ),
            onTap: () {
              detectOnTap();
              FocusScope.of(context).unfocus();
              Get.back();
            },
          ),
        ),
        centerTitle: true,
        title: CodeLockText(
          text: "Edit Group",
          color: CodeLockColor.white,
          fontsize: 20,
          fontWeight: FontWeight.bold,
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
          child: Obx(() {
            if (controller.status.value == EditStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4, bottom: 8),
                            child: CodeLockText(
                              text: allLanguages!.groupName,
                              fontsize: 16,
                              fontWeight: FontWeight.w600,
                              color: CodeLockColor.white.withOpacity(0.7),
                            ),
                          ),
                          codeLockTextfield(
                            firstColor: CodeLockColor.darkblue,
                            SecondColor: CodeLockColor.white,
                            HinttextColor: CodeLockColor.grey,
                            controller: controller.groupName,
                            keyboardType: TextInputType.text,
                            hintText: allLanguages!.enterGroupName,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return allLanguages!.plzentergroname;
                              }
                              return null;
                            },
                            onChanged: detectOnTap(),
                            prefixWidget: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                detectOnTap();
                                showModalBottomSheet(
                                  isScrollControlled: true,
                                  isDismissible: true,
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Material(
                                      color: Colors.transparent,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: CodeLockColor.bgGradientStart,
                                          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                                          border: Border.all(color: CodeLockColor.glassBorder, width: 1.2),
                                        ),
                                        constraints: BoxConstraints(
                                          maxHeight: MediaQuery.of(context).size.height * 0.5,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const SizedBox(height: 12),
                                            Container(
                                              width: 48,
                                              height: 6,
                                              decoration: BoxDecoration(
                                                color: CodeLockColor.white.withOpacity(0.2),
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            CodeLockText(
                                              text: "Select Icon",
                                              fontsize: 22,
                                              fontWeight: FontWeight.bold,
                                              color: CodeLockColor.white,
                                            ),
                                            const SizedBox(height: 16),
                                            Divider(color: CodeLockColor.glassBorder, height: 1),
                                            Expanded(
                                              child: GridView.builder(
                                                physics: const BouncingScrollPhysics(),
                                                padding: const EdgeInsets.all(24),
                                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 4,
                                                  crossAxisSpacing: 16,
                                                  mainAxisSpacing: 16,
                                                ),
                                                itemCount: controller.images.length,
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      detectOnTap();
                                                      setState(() {
                                                        controller.Index.value = index;
                                                      });
                                                      Future.delayed(const Duration(milliseconds: 150), () {
                                                        Get.back();
                                                      });
                                                    },
                                                    child: Obx(() {
                                                      final isSelected = controller.Index.value == index;
                                                      return AnimatedContainer(
                                                        duration: const Duration(milliseconds: 150),
                                                        decoration: BoxDecoration(
                                                          color: isSelected 
                                                              ? CodeLockColor.accentVibrant.withOpacity(0.15) 
                                                              : CodeLockColor.glassBg,
                                                          borderRadius: BorderRadius.circular(16),
                                                          border: Border.all(
                                                            color: isSelected 
                                                                ? CodeLockColor.accentVibrant 
                                                                : CodeLockColor.glassBorder,
                                                            width: isSelected ? 1.5 : 1.0,
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Image(
                                                            height: 32,
                                                            width: 32,
                                                            color: CodeLockColor.white,
                                                            image: AssetImage(controller.images[index]),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: 64,
                                margin: const EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border(
                                    right: BorderSide(color: CodeLockColor.glassBorder, width: 1.2),
                                  ),
                                ),
                                child: Center(
                                  child: Obx(
                                    () => Image(
                                      height: 28,
                                      width: 28,
                                      color: CodeLockColor.white,
                                      image: AssetImage(
                                        controller.images[controller.Index.value],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      // Existing Fields
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.existingFields.length,
                        itemBuilder: (context, index) {
                          final element = controller.existingFields[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: EditCustomTextField(
                              index: index,
                              customFieldController: element,
                              onSelectKeyBoardType: (int value) {
                                element.selectedIndex = value;
                              },
                              onDelete: () {
                                detectOnTap();
                                setState(() {
                                  controller.fieldsToDelete.add(element.subId!);
                                  controller.existingFields.removeAt(index);
                                });
                              },
                            ),
                          );
                        },
                      ),
                      // New Fields
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.newFields.length,
                        itemBuilder: (context, index) {
                          final element = controller.newFields[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: EditCustomTextField(
                              index: controller.existingFields.length + index,
                              customFieldController: element,
                              onSelectKeyBoardType: (int value) {
                                element.selectedIndex = value;
                              },
                              onDelete: () {
                                detectOnTap();
                                setState(() {
                                  controller.newFields.removeAt(index);
                                });
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          splashColor: CodeLockColor.accentVibrant.withOpacity(0.3),
                          highlightColor: CodeLockColor.accentVibrant.withOpacity(0.1),
                          onTap: () {
                            setState(() {
                              detectOnTap();
                              if (_formKey.currentState!.validate()) {
                                controller.newFields.add(
                                  EditFieldController(
                                    controller: TextEditingController(),
                                    fieldController: controller,
                                    selectedIndex: 0,
                                    isExisting: false,
                                  ),
                                );
                              }
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.add_circle_outline, color: CodeLockColor.white, size: 24),
                                const SizedBox(width: 10),
                                Text(
                                  allLanguages!.addNewField,
                                  style: TextStyle(
                                    color: CodeLockColor.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Divider(color: CodeLockColor.glassBorder, height: 1),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: CodeLockColor.accentVibrant,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          onPressed: () async {
                            detectOnTap();
                            if (_formKey.currentState!.validate()) {
                              if (controller.existingFields.isEmpty && controller.newFields.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  snackBar(
                                    context: context,
                                    msg: allLanguages!.addNewField,
                                    textStyle: TextStyle(
                                      color: CodeLockColor.homelist,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              } else {
                                // 1. Update CatMain
                                CatMainData catData = CatMainData(
                                  catId: controller.catIdData,
                                  catName: controller.groupName.text,
                                  catImg: controller.getReturnValue(controller.Index.value),
                                  openedCount: 0,
                                );
                                catData.updateCatMainData();

                                // 2. Delete removed fields
                                AppDataBase appDB = AppDataBase();
                                for (String id in controller.fieldsToDelete) {
                                  await appDB.deleteSubCat(id, Tables.subCat);
                                }

                                // 3. Update existing fields
                                for (var element in controller.existingFields) {
                                  SubCategoryData subCategoryData = SubCategoryData(
                                    catId: controller.catIdData,
                                    subId: element.subId!,
                                    subFieldType: element.selectedIndex,
                                    subName: element.controller.text,
                                    isMandatory: element.isMandatory,
                                  );
                                  subCategoryData.updateSubCatData();
                                }

                                // 4. Insert new fields
                                for (var element in controller.newFields) {
                                  SubCategoryData subCategoryData = SubCategoryData(
                                    catId: controller.catIdData,
                                    subId: 'F_${DateTime.now().microsecondsSinceEpoch}',
                                    subFieldType: element.selectedIndex,
                                    subName: element.controller.text,
                                    isMandatory: element.isMandatory,
                                  );
                                  subCategoryData.insertSubCatData();
                                }

                                if (Get.isRegistered<HomeScreenController>()) {
                                  Get.find<HomeScreenController>().getCatMainData();
                                  Get.find<HomeScreenController>().getTitleData();
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  snackBar(
                                    context: context,
                                    msg: "Group Updated Successfully",
                                  ),
                                );
                                Get.back();
                              }
                            }
                          },
                          child: CodeLockText(
                            text: allLanguages!.save,
                            fontsize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class EditCustomTextField extends StatefulWidget {
  const EditCustomTextField({
    Key? key,
    required this.index,
    required this.customFieldController,
    required this.onSelectKeyBoardType,
    required this.onDelete,
  }) : super(key: key);

  final int index;
  final EditFieldController customFieldController;
  final void Function(int value) onSelectKeyBoardType;
  final VoidCallback onDelete;

  @override
  State<EditCustomTextField> createState() => _EditCustomTextFieldState();
}

class _EditCustomTextFieldState extends State<EditCustomTextField> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.customFieldController.fieldController.samples[widget.customFieldController.selectedIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 8),
                child: CodeLockText(
                  text: "Field ${widget.index + 1}",
                  fontsize: 16,
                  fontWeight: FontWeight.bold,
                  color: CodeLockColor.white,
                ),
              ),
              GestureDetector(
                onTap: widget.onDelete,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Icon(
                    Icons.delete_outline,
                    color: const Color(0xFFFF4D4F),
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8, top: 4),
            child: CodeLockText(
              text: allLanguages!.fieldName,
              fontsize: 14,
              fontWeight: FontWeight.w600,
              color: CodeLockColor.white.withOpacity(0.7),
            ),
          ),
          codeLockTextfield(
            controller: widget.customFieldController.controller,
            firstColor: CodeLockColor.darkblue,
            SecondColor: CodeLockColor.white,
            HinttextColor: CodeLockColor.grey,
            keyboardType: TextInputType.text,
            hintText: allLanguages!.fieldName,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return allLanguages!.plzenterfieldname;
              }
              return null;
            },
            onChanged: detectOnTap(),
            iconButton: const SizedBox.shrink(),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: CodeLockText(
              text: allLanguages!.typeDefine,
              fontsize: 14,
              fontWeight: FontWeight.w600,
              color: CodeLockColor.white.withOpacity(0.7),
            ),
          ),
          InkWell(
            onTap: () {
              detectOnTap();
              showModalBottomSheet(
                isScrollControlled: true,
                isDismissible: true,
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                      color: CodeLockColor.bgGradientStart,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                      border: Border.all(color: CodeLockColor.glassBorder, width: 1.2),
                    ),
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.65,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 12),
                        Container(
                          width: 48,
                          height: 6,
                          decoration: BoxDecoration(
                            color: CodeLockColor.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 16),
                        CodeLockText(
                          text: allLanguages!.typeDefine, 
                          fontsize: 18,
                          fontWeight: FontWeight.w600,
                          color: CodeLockColor.white,
                        ),
                        const SizedBox(height: 16),
                        Divider(color: CodeLockColor.glassBorder, height: 1),
                        Expanded(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: widget.customFieldController.fieldController.samples.length,
                            itemBuilder: (context, index) {
                              final sample = widget.customFieldController.fieldController.samples[index];
                              final isSelected = selectedValue == sample;
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    detectOnTap();
                                    selectedValue = sample;
                                    widget.onSelectKeyBoardType(index);
                                  });
                                  Get.back();
                                },
                                child: Container(
                                  color: isSelected ? CodeLockColor.accentVibrant.withOpacity(0.1) : Colors.transparent,
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CodeLockText(
                                        text: sample,
                                        fontsize: 16,
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                        color: isSelected ? CodeLockColor.accentVibrant : CodeLockColor.white,
                                      ),
                                      if (isSelected)
                                        Icon(Icons.check_circle, color: CodeLockColor.accentVibrant, size: 24),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            borderRadius: BorderRadius.circular(18),
            child: Container(
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: CodeLockColor.glassBg,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: CodeLockColor.glassBorder,
                  width: 1.2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CodeLockText(
                    text: selectedValue,
                    color: CodeLockColor.white,
                    fontsize: 16,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: CodeLockColor.white.withOpacity(0.7),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Divider(color: CodeLockColor.glassBorder, height: 1),
        ],
      ),
    );
  }
}
