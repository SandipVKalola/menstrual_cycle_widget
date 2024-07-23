class Symptoms {
  int? categoryId;
  int? isVisibleCategory;
  String? categoryName;
  String? categoryColor;
  List<SymptomsData>? symptomsData;

  Symptoms({
    this.categoryId = 0,
    this.categoryName,
    this.symptomsData,
    this.categoryColor = "#000000",
    this.isVisibleCategory = 1,
  });

  Symptoms.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    isVisibleCategory = json['isVisibleCategory'];
    categoryName = json['categoryName'];
    categoryColor = json['categoryColor'];
    if (json['symptomsData'] != null) {
      symptomsData = <SymptomsData>[];
      json['symptomsData'].forEach((v) {
        symptomsData!.add(SymptomsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['categoryName'] = categoryName;
    data['isVisibleCategory'] = isVisibleCategory;
    data['categoryColor'] = categoryColor;
    if (symptomsData != null) {
      data['symptomsData'] = symptomsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SymptomsData {
  int? symptomId;
  String? symptomName;
  bool isSelected = false;

  SymptomsData({
    this.symptomName,
    this.symptomId = 0,
    this.isSelected = false,
  });

  SymptomsData.fromJson(Map<String, dynamic> json) {
    symptomName = json['symptomName'];
    isSelected = json['isSelected'];
    symptomId = json['symptomId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symptomName'] = symptomName;
    data['symptomId'] = symptomId;
    data['isSelected'] = isSelected;

    return data;
  }

  factory SymptomsData.fromMap(Map<String, dynamic> map) {
    return SymptomsData(
      symptomName: map['symptomName'],
      symptomId: map['symptomId'],
      isSelected: map['isSelected'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'symptomName': symptomName,
      'symptomId': symptomId,
      'isSelected': isSelected,
    };
  }
}
