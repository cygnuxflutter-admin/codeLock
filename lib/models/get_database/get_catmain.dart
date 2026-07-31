class CatMainModel {
  String? catId;
  String? catName;
  String? imgId;
  String? openedCount;

  CatMainModel({
    this.catId,
    this.catName,
    this.imgId,
    this.openedCount,
  });

  CatMainModel.fromMap(Map<String, dynamic> map) {
    catId = map['CAT_ID']?.toString();
    catName = map['CAT_NAME']?.toString();
    imgId = map['CAT_IMG']?.toString();
    openedCount = map['OPENED_COUNT']?.toString();
  }

  Map<String, dynamic> toMap() {
    return {
      'CAT_ID': catId,
      'CAT_NAME': catName,
      'CAT_IMG': imgId,
      'OPENED_COUNT': openedCount,
    };
  }
}
