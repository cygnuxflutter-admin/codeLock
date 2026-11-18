import 'package:flutter/material.dart';

class SubCat {
  String? catId;
  String? subId;
  String? subFieldType;
  String? subName;
  String? isMandatory;
  TextEditingController? controller;

  SubCat({
    this.catId,
    this.subId,
    this.subFieldType,
    this.subName,
    this.isMandatory,
    this.controller,
  });

  SubCat.fromMap(Map<String, dynamic> map) {
    catId = map['CAT_ID'];
    subId = map['SUB_ID'];
    subFieldType = map['SUB_FIELD_TYPE'];
    subName = map['SUB_NAME'];
    isMandatory = map['IS_MANDATORY'];
  }

  Map<String, dynamic> toMap() {
    return {
      'CAT_ID': catId,
      'SUB_ID': subId,
      'SUB_FIELD_TYPE': subFieldType,
      'SUB_NAME': subName,
      'IS_MANDATORY': isMandatory,
    };
  }
}
