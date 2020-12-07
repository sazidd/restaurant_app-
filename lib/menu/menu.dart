// To parse this JSON data, do
//
//     final menu = menuFromJson(jsonString);

import 'dart:convert';

List<Menu> menuFromJson(String str) => List<Menu>.from(json.decode(str).map((x) => Menu.fromJson(x)));

String menuToJson(List<Menu> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Menu {
  String id;
  String price;
  String description;
  String imageSource;
  String name;
  String quantity;

  Menu({
    this.id,
    this.price,
    this.description,
    this.imageSource,
    this.name,
    this.quantity,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    id: json["id"],
    price: json["price"],
    description: json["description"],
    imageSource: json["image_source"],
    name: json["name"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "description": description,
    "image_source": imageSource,
    "name": name,
    "quantity": quantity,
  };
}
