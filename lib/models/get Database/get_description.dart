import 'package:flutter/material.dart';

class DescriptionModel {
  String? catId;
  String? subId;
  String? subName;
  String? subFieldType;
  String? titleId;
  String? titleName;
  String? valueId;
  TextEditingController? value;

  DescriptionModel({
    this.catId,
    this.subId,
    this.subName,
    this.subFieldType,
    this.titleId,
    this.titleName,
    this.valueId,
    this.value,
  });

  DescriptionModel.fromMap(Map<String, dynamic> map) {
    catId = map['CAT_ID'];
    subId = map['SUB_ID'];
    subName = map['SUB_NAME'];
    subFieldType = map['SUB_FIELD_TYPE'];
    titleId = map['TITLE_ID'];
    titleName = map['TITLE_NAME'];
    valueId = map['VALUE_ID'];
    value = TextEditingController(text: map['VALUE']);
  }

  Map<String, dynamic> toMap() {
    return {
      'CAT_ID': catId,
      'SUB_ID': subId,
      'SUB_NAME': subName,
      'SUB_FIELD_TYPE': subFieldType,
      'TITLE_ID': titleId,
      'TITLE_NAME': titleName,
      'VALUE_ID': valueId,
      'VALUE': value?.text,
    };
  }
}
