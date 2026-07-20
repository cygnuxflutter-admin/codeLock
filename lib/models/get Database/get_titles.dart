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
    catId = map['CAT_ID'];
    titleId = map['TITLE_ID'];
    titleName = map['TITLE_NAME'];
    openedCount = map['OPENED_COUNT'];
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
