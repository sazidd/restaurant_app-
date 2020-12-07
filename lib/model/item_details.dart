// To parse this JSON data, do
//
//     final itemDetails = itemDetailsFromJson(jsonString);

import 'dart:convert';

ItemDetails itemDetailsFromJson(String str) => ItemDetails.fromJson(json.decode(str));

String itemDetailsToJson(ItemDetails data) => json.encode(data.toJson());

class ItemDetails {
  String id;
  String price;
  String description;
  String imageSource;
  String name;
  String quantity;

  ItemDetails({
    this.id,
    this.price,
    this.description,
    this.imageSource,
    this.name,
    this.quantity,
  });

  factory ItemDetails.fromJson(Map<String, dynamic> json) => ItemDetails(
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
