import 'dart:convert';

List<Reservation> reservationFromJson(String str) => List<Reservation>.from(json.decode(str).map((x) => Reservation.fromJson(x)));

String reservationToJson(List<Reservation> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reservation {
  String id;
  String price;
  String numberOfTable;

  Reservation({
    this.id,
    this.price,
    this.numberOfTable,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
    id: json["id"],
    price: json["price"],
    numberOfTable: json["numberOfTable"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "numberOfTable": numberOfTable,
  };
}

