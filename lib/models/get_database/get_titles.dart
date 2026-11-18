class TitleModel {
  String? catId;
  String? titleId;
  String? titleName;
  String? openedCount;

  TitleModel({
    this.catId,
    this.titleId,
    this.titleName,
    this.openedCount,
  });

  TitleModel.fromMap(Map<String, dynamic> map) {
    catId = map['CAT_ID']?.toString();
    titleId = map['TITLE_ID']?.toString();
    titleName = map['TITLE_NAME']?.toString();
    openedCount = map['OPENED_COUNT']?.toString();
  }

  Map<String, dynamic> toMap() {
    return {
      'CAT_ID': catId,
      'TITLE_ID': titleId,
      'TITLE_NAME': titleName,
      'OPENED_COUNT': openedCount,
    };
  }
}
