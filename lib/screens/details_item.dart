import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterapptestpush/db/services.dart';
import 'package:flutterapptestpush/model/item_details.dart';
import 'package:flutterapptestpush/screens/cart_menu.dart';
import 'package:flutterapptestpush/screens/order_item_screen/order_item_screen.dart';
import 'package:flutterapptestpush/sqlite/cart.dart';
import 'package:flutterapptestpush/sqlite/cart_provider.dart';
import 'package:flutterapptestpush/sqlite/order.dart';
import 'package:flutterapptestpush/sqlite/order_provider.dart';

import 'package:flutterapptestpush/util/const.dart';

import 'package:flutterapptestpush/util/usershareperf.dart';
import 'package:flutterapptestpush/widgets/smooth_star_rating.dart';
import 'package:flutterapptestpush/sqlite/wishlist.dart';
import 'package:flutterapptestpush/sqlite/wishlist_provider.dart';

import 'favorite_menu.dart';
import 'join.dart';

class DetailsItem extends StatefulWidget {
  String _id;
  String _img;

  DetailsItem(this._id, this._img);

  @override
  State<StatefulWidget> createState() {
    return _DetailsItem(this._id, this._img);
  }
}

class _DetailsItem extends State<DetailsItem> {
  CartProvider dbsqliteCart = CartProvider();
  WishlistProvider dbsqliteWish = WishlistProvider();
  OrderProvider dbsqliteOrder = OrderProvider();

  bool isFav = false;
  ItemDetails itemDetails;
  String _id;
  String _img;
  int _itemCount = 0;

  _DetailsItem(this._id, this._img);

  var isLoading = false;
  int orderCount = 0;
  String userId;
  int menuTotalPrice22;

  @override
  void initState() {
    _getDetailsOfItems();

    UserShareFrence.getStringUserID().then((value) {
      print('value......... ${value}');
      setState(() {
        userId = value;
      });
    });

    super.initState();
  }

  _getDetailsOfItems() {
    setState(() {
      isLoading = true;
    });

    Services.getDetailsIteam(_id).then((result) {
      print('up data ${_id}');
      print("itemD............${result}");

      setState(() {
        itemDetails = result;
        isLoading = false;
        print("itemDe...........${itemDetails.name}.");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Item Details",
        ),
      ),
      body: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: FutureBuilder(
              future: Services.getDetailsIteam(_id),
              builder:
                  (BuildContext context, AsyncSnapshot<ItemDetails> response) {
                if (response.data != null) {
                  return ListView(
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Stack(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height / 3.2,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                response.data.imageSource,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            right: -10.0,
                            bottom: 3.0,
                            child: RawMaterialButton(
                              onPressed: () {
                                if (["", null, false, 0].contains(userId)) {
                                  //when user id is empty
                                  _ackAlert(context, "Wish List Operation");
                                } else {
                                  //when user id not is empty
                                  dbsqliteWish.insertWishlist(Wishlist(
                                      userId: userId,
                                      menuItemId: itemDetails.id,
                                      menuName: itemDetails.name,
                                      menuPrice: itemDetails.price,
                                      menuDescription: itemDetails.description,
                                      menuImageSource:
                                          itemDetails.imageSource));
                                }
                              },
                              fillColor: Colors.white,
                              shape: CircleBorder(),
                              elevation: 4.0,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  isFav
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                  size: 17,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        response.data.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 2,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
                        child: Row(
                          children: <Widget>[
                            SmoothStarRating(
                              starCount: 5,
                              color: Constants.ratingBG,
                              allowHalfRating: true,
                              rating: 5.0,
                              size: 10.0,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "1 Pieces",
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Text(
                                  response.data.price,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w900,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 10.0),
                            Row(
                              children: <Widget>[
                                _itemCount != 0
                                    ? new IconButton(
                                        icon: new Icon(Icons.remove),
                                        color: Colors.redAccent,
                                        onPressed: () =>
                                            setState(() => _itemCount--),
                                      )
                                    : new Container(),
                                new Text(_itemCount.toString()),
                                new IconButton(
                                    icon: new Icon(Icons.add),
                                    color: Colors.redAccent,
                                    onPressed: () =>
                                        setState(() => _itemCount++))
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        "Product Description",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 2,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        response.data.description,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  );
                } else {
                  return ListView(
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      Stack(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height / 3.2,
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                "blank_image_itesm.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            right: -10.0,
                            bottom: 3.0,
                            child: RawMaterialButton(
                              onPressed: () {},
                              fillColor: Colors.white,
                              shape: CircleBorder(),
                              elevation: 4.0,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Icon(
                                  isFav
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red,
                                  size: 17,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 2,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
                        child: Row(
                          children: <Widget>[
                            SmoothStarRating(
                              starCount: 5,
                              color: Constants.ratingBG,
                              allowHalfRating: true,
                              rating: 5.0,
                              size: 10.0,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "1 Pieces",
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              "",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w900,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        "Product Description",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 2,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  );
                }
              })),
      bottomNavigationBar: Container(
        height: 40.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(width: 4.0),
            Expanded(
              child: RaisedButton(
                child: Text(
                  "Wish",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  _addWish();
                },
              ),
            ),
            SizedBox(width: 4.0),
            Expanded(
              child: RaisedButton(
                child: Text(
                  "CART",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  _addCart();
                },
              ),
            ),
            SizedBox(width: 4.0),
            Expanded(
              child: RaisedButton(
                child: Text(
                  "PURCHASE",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  _addPurchase();
                },
              ),
            ),
            SizedBox(width: 4.0),
          ],
        ),
      ),
    );
  }

  _addCart() {
    if (["", null, false, 0].contains(userId)) {
      //when user id is empty
      _ackAlert(context, "Cart Operation");
    } else {
      //when user id not is empty
      dbsqliteCart.insertCart(Cart(
          userId: userId,
          menuItemId: itemDetails.id,
          menuName: itemDetails.name,
          menuPrice: itemDetails.price,
          menuDescription: itemDetails.description,
          menuImageSource: itemDetails.imageSource));

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return CartMenuScreen();
          },
        ),
      );
    }
  }

  _addWish() {
    if (["", null, false, 0].contains(userId)) {
      //when user id is empty
      _ackAlert(context, "Wish List Operation");
    } else {
      //when user id not is empty

      dbsqliteWish.insertWishlist(Wishlist(
          userId: userId,
          menuItemId: itemDetails.id,
          menuName: itemDetails.name,
          menuPrice: itemDetails.price,
          menuDescription: itemDetails.description,
          menuImageSource: itemDetails.imageSource));

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return FavoriteMenuScreen();
          },
        ),
      );
    }
  }

  _addPurchase() {
    if (["", null, false, 0].contains(userId)) {
      //when user id is empty
      _ackAlert(context, "Order Item Operation");
    } else {
      //when user id not is empty

      dbsqliteOrder
          .getOrderMenuItemCheck(itemDetails.id.toString())
          .then((onValue) {
        print("onValue .$onValue");
        if (onValue == null) {
          if (_itemCount == 0) {
            dbsqliteOrder.insertOrder(Order(
                userId: userId,
                menuItemId: itemDetails.id,
                menuName: itemDetails.name,
                menuPrice: itemDetails.price,
                menuDescription: itemDetails.description,
                menuImageSource: itemDetails.imageSource,
                menuQuantity: "1"));
          } else {
            dbsqliteOrder.insertOrder(Order(
                userId: userId,
                menuItemId: itemDetails.id,
                menuName: itemDetails.name,
                menuPrice: itemDetails.price,
                menuDescription: itemDetails.description,
                menuImageSource: itemDetails.imageSource,
                menuQuantity: _itemCount.toString()));
          }

          dbsqliteOrder.getMenuPrice().then((menuTotalPrice) {
            menuTotalPrice22 = menuTotalPrice;
            print("menuTotalPrice22 $menuTotalPrice22");

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return OrderItemScreen(menuTotalPrice22);
                },
              ),
            );
          });
        } else {
          print("menuTotalyy");
          dbsqliteOrder
              .getOrderMenuItemCheckQuantity(itemDetails.id.toString())
              .then((onValue) {
            Order order = onValue;
            int menuQantity;
            if (_itemCount == 0) {
              print("onValue. .${order.menuQantity}");
              menuQantity = int.parse(order.menuQantity) + 1;
            } else {
              print("onValue. .${order.menuQantity}");
              menuQantity = int.parse(order.menuQantity) + _itemCount;
            }

            dbsqliteOrder
                .getupdateMenuQuantity(
                    itemDetails.id.toString(), menuQantity.toString())
                .then((onValue) {
              print("onValue. .${onValue}");

              if (onValue == 1) {
                dbsqliteOrder.getMenuPrice().then((menuTotalPrice) {
                  menuTotalPrice22 = menuTotalPrice;
                  print("menuTotalPrice22 $menuTotalPrice22");

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return OrderItemScreen(menuTotalPrice22);
                      },
                    ),
                  );
                });
              }
            });
          });
        }
      });
    }
  }
}

Future<void> _ackAlert(BuildContext context, String msg) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('ALERT'),
        content: Text('After login you can done ${msg}'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Login'),
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return JoinApp();
                  },
                ),
              );
            },
          ),
        ],
      );
    },
  );
}
