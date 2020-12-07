import 'package:flutter/material.dart';
import 'package:flutterapptestpush/screens/login.dart';
import 'package:flutterapptestpush/menu/menu_screen.dart';
import 'package:flutterapptestpush/screens/register.dart';
import 'package:flutter/services.dart';
import 'package:flutterapptestpush/screens/reservation_screen_one_month.dart';
import 'package:flutterapptestpush/sqlite/cart_provider.dart';
import 'package:flutterapptestpush/sqlite/wishlist_provider.dart';
import 'package:flutterapptestpush/widgets/badge.dart';

import 'about_restaurant.dart';
import 'cart_menu.dart';
import 'favorite_menu.dart';
import 'reservation_screen.dart';
import 'favorite_screen.dart';
import 'home.dart';

import 'main_screen_app.dart';
import 'notifications.dart';

class JoinAppScreen extends StatefulWidget {
  @override
  _JoinAppScreen createState() => _JoinAppScreen();
}

class _JoinAppScreen extends State<JoinAppScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  CartProvider dbsqliteCart = CartProvider();
  WishlistProvider dbsqliteWishlist = WishlistProvider();
  int cartCount;
  int wishlistCount;

  @override
  void initState() {
    checkCountCart();
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 0, length: 5);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  Future<int> checkCountCart() async {
    cartCount = await dbsqliteCart.getCount();
    print("cartCount ${cartCount}");
    return cartCount;
  }

  Future<int> checkCountWishist() async {
    wishlistCount = await dbsqliteWishlist.getCount();
    print("wishCount ${wishlistCount}");
    return wishlistCount;
  }

  Widget cardCount() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 0, 0.0, 0),
        child: FutureBuilder(
            future: checkCountCart(),
            builder: (BuildContext context, AsyncSnapshot<int> response) {
              if (response.data != null) {
                return IconButton(
                  icon: IconBadge(
                    icon: Icons.shopping_cart,
                    size: 25.0,
                    countValue: response.data,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return CartMenuScreen();
                        },
                      ),
                    );
                  },
                  tooltip: "Cart",
                );
              } else {
                return IconButton(
                  icon: IconBadge(
                    icon: Icons.shopping_cart,
                    size: 25.0,
                    countValue: 0,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return CartMenuScreen();
                        },
                      ),
                    );
                  },
                  tooltip: "Cart",
                );
              }
            }));
  }

  Widget wishCount() {
    return Padding(
        padding: EdgeInsets.fromLTRB(0.0, 0, 0.0, 0),
        child: FutureBuilder(
            future: checkCountCart(),
            builder: (BuildContext context, AsyncSnapshot<int> response) {
              if (response.data != null) {
                return IconButton(
                  icon: IconBadge(
                    icon: Icons.favorite,
                    size: 25.0,
                    countValue: response.data,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return FavoriteMenuScreen();
                        },
                      ),
                    );
                  },
                  tooltip: "wish",
                );
              } else {
                return IconButton(
                  icon: IconBadge(
                    icon: Icons.favorite,
                    size: 25.0,
                    countValue: 0,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return FavoriteMenuScreen();
                        },
                      ),
                    );
                  },
                  tooltip: "wish",
                );
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Restaurant App",
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person_outline),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return MainScreenApp();
                  },
                ),
              );
            },
            tooltip: "UserInfo",
          ),
          wishCount(),
          cardCount()
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).accentColor,
          labelColor: Theme.of(context).accentColor,
          unselectedLabelColor: Colors.grey,
          isScrollable: true,
          labelStyle: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
          tabs: <Widget>[
            new Container(
              height: 30.0,
              width: MediaQuery.of(context).size.width / 4.5,
              child: new Tab(text: 'Home'),
            ),
            new Container(
              height: 30.0,
              width: MediaQuery.of(context).size.width / 4.5,
              child: new Tab(text: 'Menu'),
            ),
            new Container(
              height: 30.0,
              width: MediaQuery.of(context).size.width / 4.5,
              child: new Tab(text: 'Reservation'),
            ),
            new Container(
              height: 30.0,
              width: MediaQuery.of(context).size.width / 4.5,
              child: new Tab(text: 'One Month Reservation'),
            ),
            new Container(
              height: 30.0,
              width: MediaQuery.of(context).size.width / 4.5,
              child: new Tab(text: 'About Restaurant'),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Home(),
          MenuScreen(),
          ReservationScreen(),
          ReservationOneMonth(),
          AboutResaurant(),
        ],
      ),
    );
  }
}
