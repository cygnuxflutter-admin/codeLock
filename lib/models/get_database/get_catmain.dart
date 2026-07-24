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
    catId = map['CAT_ID'];
    catName = map['CAT_NAME'];
    imgId = map['CAT_IMG'];
    openedCount = map['OPENED_COUNT'];
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
