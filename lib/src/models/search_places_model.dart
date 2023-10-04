class SearchPlacesModel {
  String? place;

  SearchPlacesModel({this.place});

  SearchPlacesModel.fromJson(Map<String, dynamic> json) {
    place = json['place'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['place'] = place;
    return data;
  }
}
