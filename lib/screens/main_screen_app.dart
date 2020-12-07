import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutterapptestpush/screens/favorite_screen.dart';
import 'package:flutterapptestpush/screens/home.dart';
import 'package:flutterapptestpush/screens/notifications.dart';
import 'package:flutterapptestpush/screens/profile.dart';

import 'package:flutterapptestpush/util/const.dart';
import 'package:flutterapptestpush/widgets/badge.dart';

import 'cart.dart';
import 'order_user_screen.dart';


class MainScreenApp extends StatefulWidget {
  @override
  _MainScreenAppState createState() => _MainScreenAppState();
}

class _MainScreenAppState extends State<MainScreenApp> {
  PageController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>Future.value(true),
      child: Scaffold(
        body: PageView(
         // physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            Profile(),
            FavoriteScreen(),
            CartScreen(),
            OrderUserScreen(),
          ],
        ),

        bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(width:7),
              IconButton(
                icon: Icon(
                  Icons.person,
                  size: 24.0,
                ),
                color: _page == 0
                    ? Theme.of(context).accentColor
                    : Theme
                    .of(context)
                    .textTheme.caption.color,
                onPressed: ()=>_pageController.jumpToPage(0),
              ),
              SizedBox(width:7),
              IconButton(
                icon:Icon(
                  Icons.favorite,
                  size: 24.0,
                ),
                color: _page == 1
                    ? Theme.of(context).accentColor
                    : Theme
                    .of(context)
                    .textTheme.caption.color,
                onPressed: ()=>_pageController.jumpToPage(1),
              ),
              SizedBox(width:7),
              IconButton(
                icon: Icon(Icons.shopping_cart),
                color: _page == 2
                    ? Theme.of(context).accentColor
                    : Theme
                    .of(context)
                    .textTheme.caption.color,
                onPressed: ()=>_pageController.jumpToPage(2),
              ),

              SizedBox(width:7),
              IconButton(
                icon: Icon(Icons.add_shopping_cart),
                color: _page == 2
                    ? Theme.of(context).accentColor
                    : Theme
                    .of(context)
                    .textTheme.caption.color,
                onPressed: ()=>_pageController.jumpToPage(3),
              ),

              SizedBox(width:7),
            ],
          ),
          color: Theme.of(context).primaryColor,
          shape: CircularNotchedRectangle(),
        ),


      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {

      this._page = page;
    });
  }
}
