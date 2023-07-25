class CategotiesModel {
  bool? status;
  CategotiesDataModel? data;
  CategotiesModel.fromJson(Map<String, dynamic> jason) {
    status = jason['status'];
    data = CategotiesDataModel.fromJson(jason['data']);
  }
}

class CategotiesDataModel {
  int? currentPage;
  List<DataGModel>? data = [];
  CategotiesDataModel.fromJson(Map<String, dynamic> jason) {
    int currentPage = jason['current_page'];
    jason['data'].forEach((element) {
      data?.add(DataGModel.fromJson(element));
    });
  }
}

class DataGModel {
  int? id;
  String? name;
  String? image;

  DataGModel.fromJson(Map<String, dynamic> jason) {
    id = jason['id'];
    name = jason['name'];
    image = jason['image'];
  }
}
