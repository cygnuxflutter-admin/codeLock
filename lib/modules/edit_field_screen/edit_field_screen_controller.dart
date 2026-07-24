import 'package:code_lock/app_database/app_database.dart';
import 'package:code_lock/app_database/database_helper/database_helper.dart';
import 'package:code_lock/app_routes.dart';
import 'package:code_lock/custom/Image/code_lock_image.dart';
import 'package:code_lock/custom/colors/code_lock_color.dart';
import 'package:code_lock/models/get_database/get_catmain.dart';
import 'package:code_lock/models/get_database/get_subcat.dart';
import 'package:code_lock/models/insert_database/cat_main_insert.dart';
import 'package:code_lock/models/insert_database/sub_cat_insert.dart';
import 'package:code_lock/modules/edit_field_screen/edit_field_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum EditStatus { loading, done, error }

class EditFieldScreenController extends GetxController {
  String catIdData = "";
  TextEditingController groupName = TextEditingController();
  final AppDataBase _appDataBase = AppDataBase();

  Rx<EditStatus> status = EditStatus.loading.obs;
  
  List<CatMainModel> catMainList = [];
  List<SubCat> subCatList = [];
  
  List<EditFieldController> existingFields = [];
  List<EditFieldController> newFields = [];
  List<String> fieldsToDelete = []; // IDs of subcats to delete

  final RxInt Index = 0.obs;

  RxList<String> images = [
    CodeLockImages.bank,
    CodeLockImages.car,
    CodeLockImages.insurance,
    CodeLockImages.computer,
    CodeLockImages.credit_cards,
    CodeLockImages.logins,
    CodeLockImages.Email_acc,
    CodeLockImages.license,
  ].obs;

  List<String> samples = [
    "🔢  Number",
    "📝  Text",
    "🔒  Password",
    "☑️  Yes / No",
    "📞  Phone Number",
    "🖼️  Image",
    "📅  Date",
    "🕒  Time",
    "📧  Email",
    "🌐  URL / Website",
    "📄  Notes (Multi-line)",
  ];

  @override
  void onInit() {
    catIdData = Get.arguments['catId'];
    loadGroupData();
    super.onInit();
  }

  void loadGroupData() async {
    try {
      var catValue = await _appDataBase.query(Tables.catMain);
      catMainList = catValue.map((map) => CatMainModel.fromMap(map)).toList();
      var currentCat = catMainList.firstWhere((cat) => cat.catId == catIdData);
      
      groupName.text = currentCat.catName ?? "";
      
      // Set image index
      String img = currentCat.imgId ?? "i1";
      Index.value = getIndexFromReturnValue(img);

      var subValue = await _appDataBase.query(Tables.subCat);
      subCatList = subValue.map((map) => SubCat.fromMap(map)).where((s) => s.catId == catIdData).toList();
      
      existingFields = subCatList.map((sub) {
        return EditFieldController(
          subId: sub.subId,
          controller: TextEditingController(text: sub.subName),
          selectedIndex: int.tryParse(sub.subFieldType ?? '0') ?? 0,
          isMandatory: int.tryParse(sub.isMandatory ?? '0') ?? 0,
          fieldController: this,
          isExisting: true,
        );
      }).toList();

      status.value = EditStatus.done;
    } catch (e) {
      status.value = EditStatus.error;
    }
  }

  String getReturnValue(index) {
    String imagePath = images[index];
    switch (imagePath) {
      case CodeLockImages.bank: return "i1";
      case CodeLockImages.car: return "i2";
      case CodeLockImages.insurance: return "i3";
      case CodeLockImages.computer: return "i4";
      case CodeLockImages.credit_cards: return "i5";
      case CodeLockImages.logins: return "i6";
      case CodeLockImages.Email_acc: return "i7";
      case CodeLockImages.license: return "i8";
      default: return "i1";
    }
  }

  int getIndexFromReturnValue(String val) {
    switch (val) {
      case "i1": return 0;
      case "i2": return 1;
      case "i3": return 2;
      case "i4": return 3;
      case "i5": return 4;
      case "i6": return 5;
      case "i7": return 6;
      case "i8": return 7;
      default: return 0;
    }
  }
}

class EditFieldController {
  String? subId;
  TextEditingController controller;
  int selectedIndex;
  int isMandatory;
  EditFieldScreenController fieldController;
  bool isExisting;

  EditFieldController({
    this.subId,
    required this.controller,
    this.selectedIndex = 0,
    this.isMandatory = 0,
    required this.fieldController,
    this.isExisting = false,
  });
}
