import 'package:flutter/foundation.dart';

class Cart {
  final int id;
  final String userId;
  final String menuItemId;
  final String menuName;
  final String menuPrice;
  final String menuDescription;
  final String menuImageSource;

  Cart({
    this.id,
    @required this.userId,
    @required this.menuItemId,
    @required this.menuName,
    @required this.menuPrice,
    @required this.menuDescription,
    @required this.menuImageSource,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'menuItemId': menuItemId,
      'menuName': menuName,
      'menuPrice':menuPrice,
      'menuDescription': menuDescription,
      'menuImageSource': menuImageSource,
    };
  }
}
