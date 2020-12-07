import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterapptestpush/db/services.dart';
import 'package:flutterapptestpush/model/item_details.dart';
import 'package:flutterapptestpush/screens/cart_menu.dart';
import 'package:flutterapptestpush/screens/notifications.dart';
import 'package:flutterapptestpush/screens/order_screen.dart';
import 'package:flutterapptestpush/sqlite/cart.dart';
import 'package:flutterapptestpush/sqlite/cart_provider.dart';
import 'package:flutterapptestpush/sqlite/order.dart';
import 'package:flutterapptestpush/sqlite/order_provider.dart';
import 'package:flutterapptestpush/util/const.dart';

import 'package:flutterapptestpush/util/usershareperf.dart';
import 'package:flutterapptestpush/widgets/badge.dart';
import 'package:flutterapptestpush/widgets/smooth_star_rating.dart';
import 'package:flutterapptestpush/sqlite/wishlist.dart';
import 'package:flutterapptestpush/sqlite/wishlist_provider.dart';

import 'cart.dart';
import 'favorite_menu.dart';
import 'favorite_screen.dart';
import 'join.dart';

class NotificationScreen extends StatefulWidget {

  String _img;
  String _name;
  String _descriptions;
  String _price;
  String _offer;
  NotificationScreen(this._img,this._name,this._descriptions,this._price,this._offer);

  @override
  State<StatefulWidget> createState() {
    return _NotificationScreen(this._img,this._name,this._descriptions,this._price,this._offer);
  }
}

class _NotificationScreen extends State<NotificationScreen> {

  String _img;
  String _name;
  String _descriptions;
  String _price;
  String _offer;
  _NotificationScreen(this._img,this._name,this._descriptions,this._price,this._offer);


  @override
  void initState() {
    super.initState();

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
          onPressed: ()=>Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Notification",
        ),
      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child: ListView(
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
                      "${_img}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),


              ],
            ),

            SizedBox(height: 10.0),

            Text(
              "${_name}",
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


                  Text(
                    "${_price}",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).accentColor,
                    ),
                  ),

                ],
              ),
            ),


            SizedBox(height: 10.0),

            Text(
              "Offer",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),

            SizedBox(height: 10.0),

            Text(
              "${_descriptions}",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w300,
              ),
            ),

            SizedBox(height: 20.0),


          ],
        ),
      ),




    );
  }




}
