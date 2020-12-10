import 'package:flutter/foundation.dart';

class Order {
  final int id;
  final String userId;
  final String menuItemId;
  final String menuName;
  final String menuPrice;
  final String menuDescription;
  final String menuImageSource;
  final String menuQuantity;

  const Order({
    this.id,
    @required this.userId,
    @required this.menuItemId,
    @required this.menuName,
    @required this.menuPrice,
    @required this.menuDescription,
    @required this.menuImageSource,
    @required this.menuQuantity,
  });

  String get menuQantity {
    return menuQuantity;
  }

  factory Order.fromMap(Map<String, dynamic> data) => new Order(
        userId: data['userId'],
        menuItemId: data['menuItemId'],
        menuName: data['menuName'],
        menuPrice: data['menuPrice'],
        menuDescription: data['menuDescription'],
        menuImageSource: data['menuImageSource'],
        menuQuantity: data['menuQuantity'],
      );

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'menuItemId': menuItemId,
      'menuName': menuName,
      'menuPrice': menuPrice,
      'menuDescription': menuDescription,
      'menuImageSource': menuImageSource,
      'menuQuantity': menuQuantity,
    };
  }
}
