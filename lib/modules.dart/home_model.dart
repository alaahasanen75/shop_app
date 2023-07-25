import 'dart:convert';

class HomeModel {
  String? status;
  DataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status != json['status'];
    data = DataModel.fromJson(json['data']);
  }
}

class DataModel {
  List<BannurModel> banner = [];
  List<ProductModel> product = [];
  DataModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banner.add(BannurModel.fromJson(element));
    });

    json['products'].forEach((element) {
      product.add(ProductModel.fromJson(element));
    });
  }
}

class BannurModel {
  int? id;
  String? image;
  BannurModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel {
  int? id;
  String? image;
  String? name;
  bool? infav;
  String? incart;
  dynamic price;
  dynamic oldprice;
  dynamic discount;
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    infav = json['in_favorites'];
    image = json['image'];
    incart = json['in_cart'];
    price = json['price'];
    oldprice = json['old_price'];
    discount = json['discount'];
  }
}
