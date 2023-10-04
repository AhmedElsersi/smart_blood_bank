class InterestsModel {
  int? interestId;
  String? interestName;

  InterestsModel({this.interestId, this.interestName});

  InterestsModel.fromJson(Map<String, dynamic> json) {
    interestId = json['i_Id'];
    interestName = json['i_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['i_Id'] = interestId;
    data['i_Name'] = interestName;
    return data;
  }
}
