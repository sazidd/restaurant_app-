// To parse this JSON data, do
//
//     final deliveryVat = deliveryVatFromJson(jsonString);

import 'dart:convert';

DeliveryVat deliveryVatFromJson(String str) => DeliveryVat.fromJson(json.decode(str));

String deliveryVatToJson(DeliveryVat data) => json.encode(data.toJson());

class DeliveryVat {
  DeliveryVat({
    this.id,
    this.deliveryCharge,
    this.vat,
  });

  String id;
  String deliveryCharge;
  String vat;

  factory DeliveryVat.fromJson(Map<String, dynamic> json) => DeliveryVat(
    id: json["id"],
    deliveryCharge: json["delivery_charge"],
    vat: json["vat"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "delivery_charge": deliveryCharge,
    "vat": vat,
  };
}
