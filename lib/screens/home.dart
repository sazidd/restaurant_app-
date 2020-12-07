import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutterapptestpush/util/usershareperf.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutterapptestpush/db/services.dart';
import 'package:flutterapptestpush/menu/menu.dart';

import 'dart:convert';

import 'package:flutterapptestpush/test/Note.dart';
import 'package:flutterapptestpush/util/categories.dart';
import 'package:flutterapptestpush/util/const.dart';
import 'package:flutterapptestpush/util/foods.dart';
import 'package:flutterapptestpush/widgets/grid_product.dart';
import 'package:flutterapptestpush/widgets/home_category.dart';
import 'package:flutterapptestpush/widgets/slider_item.dart';
import 'package:flutterapptestpush/widgets/smooth_star_rating.dart';
import 'package:flutter/src/rendering/box.dart';
import 'details_item.dart';

import 'notification_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {
  static const ROOT = 'http://resturant.themepixelbd.com/index.php';
  //static const ROOT = 'http://192.168.0.102//restaurant/index.php';

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  List<Menu> _notes = List<Menu>();
  ScrollController _scrollController = ScrollController();
  int _current = 0;
  int my = 1;

  List<Menu> _notesSpecial = List<Menu>();
  ScrollController _scrollControllerSpecial = ScrollController();
  int my2 = 1;

  bool noMoredata = false;
  bool noMoredataOnce = false;
  bool noMoredataScroll = true;

  bool noMoredataG = false;
  bool noMoredataOnceG = false;
  bool noMoredataScrollG = true;

  @override
  void initState() {
    fetchNotes(my).then((value) {
      setState(() {
        _notes.addAll(value);
      });
    });
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange &&
          noMoredataScrollG == true) {
        print('working');
        my++;
        fetchNotes(my).then((value) {
          setState(() {
            _notes.addAll(value);
          });
        });
      }
      if (noMoredataG == true && noMoredataOnceG == true) {
        print("index4error");
        toastShow();
        setState(() {
          noMoredataOnceG = false;
          noMoredataScrollG = false;
        });
      }
    });

    fetchNotesSpecial(my2).then((value) {
      setState(() {
        print("value...........${value}");

        _notesSpecial.addAll(value);
      });
    });
    _scrollControllerSpecial.addListener(() {
      if (_scrollControllerSpecial.position.pixels ==
              _scrollControllerSpecial.position.maxScrollExtent &&
          noMoredataScroll == true) {
        my2++;
        fetchNotesSpecial(my2).then((value) {
          setState(() {
            _notesSpecial.addAll(value);
          });
        });
      }
      if (noMoredata == true && noMoredataOnce == true) {
        print("index4error");
        toastShow();
        setState(() {
          noMoredataOnce = false;
          noMoredataScroll = false;
        });
      }
    });

    _registerOnFirebase();

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

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollControllerSpecial.dispose();
    super.dispose();
  }

  toastShow() {
    Fluttertoast.showToast(
        msg: "There is no more Data Availabel",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  //fcm code//

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String _message = '';

  _registerOnFirebase() {
    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.getToken().then((token) => print('token: ${token}'));
    _firebaseMessaging.getToken().then((token) {
      UserShareFrence.addStringUserToken(token.toString());
    });
  }

  void _serialiseAndNavigate(Map<String, dynamic> message) {
    var notificationData = message['data'];
    var view = notificationData['view'];
    var imgscr = notificationData['imgscr'];
    var title = notificationData['title'];
    var des = notificationData['des'];
    if (view != null) {
      // Navigate to the create post view
      if (view == 'create_post') {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return NotificationScreen(
              imgscr.toString(), title.toString(), des.toString(), "", "");
        }));
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return new WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  /* SizedBox(height: 10.0),
                Text(
                  "Dishes",
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                  ),
                ),*/
                  /*FlatButton(
                  child: Text(
                    "View More",
                    style: TextStyle(
//                      fontSize: 22,
//                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context){
                          return DishesScreen();
                        },
                      ),
                    );
                  },
                ),*/
                ],
              ),
              SizedBox(height: 10.0),
              //Slider Here
              CarouselSlider(
                height: MediaQuery.of(context).size.height / 2.4,
                items: map<Widget>(
                  foods,
                  (index, i) {
                    Map food = foods[index];
                    return SliderItem(
                      img: food['img'],
                      isFav: false,
                      name: food['name'],
                      rating: 5.0,
                      raters: 23,
                    );
                  },
                ).toList(),
                autoPlay: true,
//                enlargeCenterPage: true,
                viewportFraction: 1.0,
//              aspectRatio: 2.0,
                onPageChanged: (index) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
              SizedBox(height: 20.0),
              Text(
                "Special Categories",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Container(
                constraints: BoxConstraints.tightFor(
                    height: MediaQuery.of(context).size.height / 6),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollControllerSpecial,
                    itemCount: _notesSpecial.length,
                    itemBuilder: (context, index) {
                      if (index + 1 == _notesSpecial.length &&
                          noMoredata == false) {
                        return CupertinoActivityIndicator();
                      } else if (noMoredata == true) {}
                      return _specialItems(
                          context,
                          _notesSpecial[index].id,
                          _notesSpecial[index].imageSource,
                          _notesSpecial[index].name,
                          _notesSpecial[index].price,
                          _notesSpecial[index].quantity);
                    }),
              ),

              SizedBox(height: 2.0),
              Text(
                "Food Categories",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                height: 65.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: categories == null ? 0 : categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map cat = categories[index];
                    return HomeCategory(
                      icon: cat['icon'],
                      title: cat['name'],
                      items: cat['items'].toString(),
                      isHome: true,
                    );
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Popular Items",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Container(
                constraints: BoxConstraints.tightFor(height: 300),
                child: GridView.builder(
                    itemCount: _notes.length,
                    controller: _scrollController,
//                  physics: NeverScrollableScrollPhysics(),
//                  primary: false,
//                  shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 2.0,
                        mainAxisSpacing: 2.0),
                    itemBuilder: (BuildContext context, int index) {
                      if (index + 1 == _notes.length && noMoredataG == false) {
                        return CupertinoActivityIndicator();
                      } else if (noMoredataG == true) {}
                      return Container(
                          constraints: BoxConstraints.tightFor(height: 600),
                          child: GridProduct(
                            menuId: _notes[index].id,
                            img: _notes[index].imageSource,
                            isFav: false,
                            name: _notes[index].name,
                            rating: 5.0,
                            raters: 23,
                            price: _notes[index].price,
                            deleteItem: null,
                          ));
                    }),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  bool get wantKeepAlive => true;

  Future<List<Menu>> fetchNotes(int my) async {
    var map = Map<String, dynamic>();
    map['action'] = "GET_ALL_MENU_POPULAR";
    map['pageno'] = my.toString();
    final response = await http.post(ROOT, body: map);
    print("value...........${my}");
    print("response${response.body.toString()}");

    if (response.body.toString().contains("error")) {
      setState(() {
        noMoredataG = true;
        noMoredataOnceG = true;
        print("index2error");
      });
    }
    var notesJson;
    var notes = List<Menu>();

    if (response.statusCode == 200) {
      setState(() {
        notesJson = json.decode(response.body);
      });

      for (var noteJson in notesJson) {
        notes.add(Menu.fromJson(noteJson));
      }
    }

    print(my);
    return notes;
  }

  Future<List<Menu>> fetchNotesSpecial(int my2) async {
    var map = Map<String, dynamic>();
    map['action'] = "GET_ALL_MENU_SPECIAL";
    map['pageno'] = my2.toString();
    final response = await http.post(ROOT, body: map);
    print("value...........${my2}");
    print("response${response.body.toString()}");

    if (response.body.toString().contains("error")) {
      setState(() {
        noMoredata = true;
        noMoredataOnce = true;
        print("index2error");
      });
    }
    var notesJson;
    var notes = List<Menu>();

    if (response.statusCode == 200) {
      setState(() {
        notesJson = json.decode(response.body);
      });

      for (var noteJson in notesJson) {
        notes.add(Menu.fromJson(noteJson));
      }
    }

    print(my);
    return notes;
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to exit an App'),
              actions: <Widget>[
                FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                    // exit(0);
                    Navigator.of(context).pop(true);
                  },
                )
              ],
            );
          },
        ) ??
        false;
  }
}

_specialItems(BuildContext context, String id, String img, String name,
    String price, String quantity) {
  return Padding(
    padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return DetailsItem(id, img);
            },
          ),
        );
      },
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Container(
              height: MediaQuery.of(context).size.width / 3,
              width: MediaQuery.of(context).size.width / 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  "$img",
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        "blank_image_itesm.png",
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "$name",
                style: TextStyle(
//                    fontSize: 15,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 10.0),
              Row(
                children: <Widget>[
                  SmoothStarRating(
                    starCount: 1,
                    color: Constants.ratingBG,
                    allowHalfRating: true,
                    rating: 5.0,
                    size: 12.0,
                  ),
                  SizedBox(width: 6.0),
                  Text(
                    "5.0 (23 Reviews)",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
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
                    " $price",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Text(
                "Quantity: $quantity",
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
