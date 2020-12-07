import 'dart:convert';

List<ReservationTable> reservationTableFromJson(String str) => List<ReservationTable>.from(json.decode(str).map((x) => ReservationTable.fromJson(x)));

String reservationTableToJson(List<ReservationTable> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReservationTable {
  String id;
  String userId;
  String numberOfTable;
  String startTime;
  String endTime;
  String startDate;
  String endDate;

  ReservationTable({
    this.id,
    this.userId,
    this.numberOfTable,
    this.startTime,
    this.endTime,
    this.startDate,
    this.endDate,
  });

  factory ReservationTable.fromJson(Map<String, dynamic> json) => ReservationTable(
    id: json["id"],
    userId: json["user_id"],
    numberOfTable: json["numberOfTable"],
    startTime: json["startTime"],
    endTime: json["endTime"],
    startDate: json["startDate"],
    endDate: json["endDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "numberOfTable": numberOfTable,
    "startTime": startTime,
    "endTime": endTime,
    "startDate": startDate,
    "endDate": endDate,
  };
}
