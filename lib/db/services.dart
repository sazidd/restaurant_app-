import 'dart:convert';
import 'package:flutterapptestpush/model/DeliveryVat.dart';
import 'package:http/http.dart'
    as http; // add the http plugin in pubspec.yaml file.
import 'package:crypto/crypto.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutterapptestpush/model/ReservationTable.dart';
import 'package:flutterapptestpush/model/Users.dart';
import 'package:flutterapptestpush/model/item_details.dart';
import 'package:flutterapptestpush/menu/menu.dart';
import 'package:flutterapptestpush/model/reservation_model.dart';

import 'services.dart';

class Services {
  static const ROOT = 'http://resturant.themepixelbd.com/index.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_EMP';
  static const _UPDATE_EMP_ACTION = 'UPDATE_EMP';
  static const _DELETE_EMP_ACTION = 'DELETE_EMP';
  static const _REGISTRATION = 'REGISTRATION';

  static Future<String> addRegistration(String user_name, String address,
      String phone, String email, String password, String UserToken) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _REGISTRATION;
      map['user_name'] = user_name;
      map['address'] = address;
      map['phone'] = phone;
      map['email'] = email;
      map['password'] = password;
      map['usertoken'] = UserToken;

      final response = await http.post(ROOT, body: map);
      print('_REGISTRATION Response: ${response.body}');
      print('up2 data ${user_name} ${email} ${email}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        print("error2");
        return "error";
      }
    } catch (e) {
      print("error2${e}");
      return "error";
    }
  }

  static Future<Users> getLogin(
      String email, String password, String UserToken) async {
    try {
      Users users;
      var map = Map<String, dynamic>();
      map['action'] = "LOGIN";
      map['email'] = email;
      map['password'] = password;
      map['usertoken'] = UserToken;
      final response = await http.post(ROOT, body: map);
      print('LOGIN Response: ${response.body}');

      if (200 == response.statusCode) {
        final Users users = usersFromJson(response.body);

        print('length of  Response: ${users}');

        return users;
      } else {
        return users;
      }
    } catch (e) {
      // return users; // return an empty list on exception/error
    }
  }

  static Future<Users> getUserInfo(String id) async {
    try {
      Users users;
      var map = Map<String, dynamic>();
      map['action'] = "USER_INFO";
      map['id'] = id;
      final response = await http.post(ROOT, body: map);
      print('getUserInfo Response: ${response.body}');
      if (200 == response.statusCode) {
        final Users users = usersFromJson(response.body);
        print('length of  Response: ${users.email}');
        return users;
      } else {
        return users;
      }
    } catch (e) {
      // return users; // return an empty list on exception/error
    }
  }

  static Future<DeliveryVat> getDeliveryVat() async {
    try {
      DeliveryVat deliveryVat;
      var map = Map<String, dynamic>();
      map['action'] = "DELIVERY_VAT";
      final response = await http.post(ROOT, body: map);
      print('getDelivery Response: ${response.body}');
      if (200 == response.statusCode) {
        final DeliveryVat deliveryVat = deliveryVatFromJson(response.body);
        print('of getDelivery Response: ${deliveryVat.deliveryCharge}');
        return deliveryVat;
      } else {
        return deliveryVat;
      }
    } catch (e) {
      // return users; // return an empty list on exception/error
    }
  }

  static Future<ItemDetails> getDetailsIteam(String id) async {
    try {
      ItemDetails itemDetails;
      var map = Map<String, dynamic>();
      map['action'] = "GET_DETAILS_ITEM";
      map['id'] = id;
      final response = await http.post(ROOT, body: map);
      print('GET_DETAILS_ITEM Response: ${response.body}');

      if (200 == response.statusCode) {
        final ItemDetails itemDetails = itemDetailsFromJson(response.body);

        print('length of  Response: ${itemDetails}');

        return itemDetails;
      } else {
        return itemDetails;
      }
    } catch (e) {
      // return users; // return an empty list on exception/error
    }
  }

  static Future<List<Reservation>> getReservation() async {
    try {
      List<Reservation> list = [];
      var map = Map<String, dynamic>();
      map['action'] = "RESERVATION_TB_GET_ALL";
      final response = await http.post(ROOT, body: map);
      //await http.get("https://jsonplaceholder.typicode.com/users");
      print('getEmployees Response: ${response.body}');

      if (200 == response.statusCode) {
        final List<Reservation> list = reservationFromJson(response.body);
        print('length of  Response: ${list.length}');
        print('getEmployees Response: ${response.body}');
        return list;
      } else {
        print('hhhhh');
        return List<Reservation>();
      }
    } catch (e) {
      print(e);
      return List<Reservation>(); // return an empty list on exception/error
    }
  }

  static Future<List<ReservationTable>> getReservationOneMonthData() async {
    try {
      List<ReservationTable> list = [];
      var map = Map<String, dynamic>();
      map['action'] = "GET_ADD_RESERVATION_TABLE";
      final response = await http.post(ROOT, body: map);
      print('getEmployees Response: ${response.body}');

      if (200 == response.statusCode) {
        final List<ReservationTable> list =
            reservationTableFromJson(response.body);
        print('length of  Response: ${list.length}');
        print('getEmployees Response: ${response.body}');
        return list;
      } else {
        print('hhhhh');
        return List<ReservationTable>();
      }
    } catch (e) {
      print(e);
      return List<
          ReservationTable>(); // return an empty list on exception/error
    }
  }

  static Future<String> addReservationTable(
      String user_id,
      String numberOfTable,
      String startTime,
      String endTime,
      String startDate,
      String endDate) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = "ADD_RESERVATION_TABLE";
      map['user_id'] = user_id;
      map['numberOfTable'] = numberOfTable;
      map['startTime'] = startTime;
      map['endTime'] = endTime;
      map['startDate'] = startDate;
      map['endDate'] = endDate;
      final response = await http.post(ROOT, body: map);
//      print('addEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        print(map['numberOfTable']);
        print(map['endDate']);
        print(map['startDate']);
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<String> addOrderUser(
      List userOrdeList,
      List userOrdeListQantity,
      String user_id,
      String paymentchoice,
      String deliverychoice,
      String comments) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = "ADD_ORDER_USER";
      map['user_id'] = user_id;
      map['userOrdeList'] = userOrdeList.toString();
      map['userOrdeListQantity'] = userOrdeListQantity.toString();
      map['paymentchoice'] = paymentchoice;
      map['deliverychoice'] = deliverychoice;
      map['comments'] = comments;

      print("userOrdeList :...$userOrdeList");
      final response = await http.post(ROOT, body: map);
      print('addEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        print(response);

        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
}
