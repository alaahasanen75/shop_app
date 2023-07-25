class ChangeFavModel {
  bool? statuse;
  String? massage;

  ChangeFavModel.fromjson(Map<String, dynamic> json) {
    statuse = json['status'];
    massage = json['message'];
  }
}
