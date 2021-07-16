// To parse this JSON data, do
//
//     final getAllProduct = getAllProductFromJson(jsonString);

import 'dart:convert';

List<GetAllProduct> getAllProductFromJson(String str) =>
    List<GetAllProduct>.from(
        json.decode(str).map((x) => GetAllProduct.fromJson(x)));

String getAllProductToJson(List<GetAllProduct> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllProduct {
  GetAllProduct({
    required this.id,
    required this.name,
    required this.description,
    required this.stock,
    required this.price,
    required this.createdDate,
  });

  int id;
  String name;
  String description;
  int stock;
  int price;
  DateTime createdDate;

  factory GetAllProduct.fromJson(Map<String, dynamic> json) => GetAllProduct(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        stock: json["stock"],
        price: json["price"],
        createdDate: DateTime.parse(json["createdDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "stock": stock,
        "price": price,
        "createdDate": createdDate.toIso8601String(),
      };
}
