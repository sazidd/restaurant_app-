import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapptestpush/screens/join_app_screen.dart';
import 'package:flutterapptestpush/screens/reservation_screen_one_month.dart';
import 'package:flutterapptestpush/screens/walkthrough.dart';
import 'package:flutterapptestpush/sqlite/cart_show_all.dart';
import 'package:flutterapptestpush/util/const.dart';
import 'package:flutterapptestpush/util/usershareperf.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'order_payment_screen.dart';
import 'order_screen.dart';
import 'reservation_screen.dart';
import 'join.dart';
import 'main_screen_app.dart';
import '../menu/menu_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int appReview = 0;
  startTimeout() {
    return Timer(Duration(seconds: 2), changeScreen);
  }

  changeScreen() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) {
          if (appReview == 123) {
            return JoinAppScreen(); //return JoinAppScreen();
          } else {
            UserShareFrence.addStringAppReview();
            return Walkthrough(); //return Walkthrough();
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    UserShareFrence.getStringAppReview().then((value) {
      appReview = value;
      print('value......... ${value}');
    });
    startTimeout();
  }

  //fcm code//

  /* final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _message = '';

  _registerOnFirebase() {
    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.getToken().then((token) => print('token: ${token}'));
  }

  @override
  void initState() {
    _registerOnFirebase();
    super.initState();

    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print('received message $message');

          await setState(() => _message = message["notification"]["body"]);
          await _serialiseAndNavigate(message);
          print("onMessage");
        }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');

      await setState(() => _message = message["notification"]["body"]);
      await _serialiseAndNavigate(message);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      await setState(() => _message = message["notification"]["body"]);
      await _serialiseAndNavigate(message);
    });
  }


  void _serialiseAndNavigate(Map<String, dynamic> message) {
    var notificationData = message['data'];
    var view = notificationData['view'];
    sendpage(view);
  }

  sendpage(var view) {
    if (view != null) {
      // Navigate to the create post view
      if (view == 'create_post') {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ScreenOnePage();
        }));

      } else if (view == 'create_user') {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ScreenTwoPage();
        }));

      }
      // If there's no view it'll just open the app on the first view

    }

  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        margin: EdgeInsets.only(left: 40.0, right: 40.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.fastfood,
                size: 150.0,
                color: Theme.of(context).accentColor,
              ),
              SizedBox(width: 40.0),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  top: 15.0,
                ),
                child: Text(
                  "Restaurant",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
