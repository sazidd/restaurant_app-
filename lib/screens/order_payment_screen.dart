import 'package:flutter/material.dart';
import 'package:flutterapptestpush/db/payment-service.dart';
import 'package:flutterapptestpush/db/services.dart';
import 'package:flutterapptestpush/model/DeliveryVat.dart';
import 'package:flutterapptestpush/sqlite/order.dart';
import 'package:flutterapptestpush/sqlite/order_provider.dart';

import 'package:flutterapptestpush/util/usershareperf.dart';
import 'package:flutterapptestpush/widgets/cart_item.dart';

import 'package:flutterapptestpush/sqlite/cart.dart';
import 'package:flutterapptestpush/sqlite/cart_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderPaymentScreen extends StatefulWidget {
  int _menuPriceTotall;
  OrderPaymentScreen(@required this._menuPriceTotall);

  @override
  _OrderPaymentScreenState createState() =>
      _OrderPaymentScreenState(this._menuPriceTotall);
}

class _OrderPaymentScreenState extends State<OrderPaymentScreen> {
  int _menuPriceTotall;
  _OrderPaymentScreenState(@required this._menuPriceTotall);

  String _radioValue; //Initial definition of radio button value
  String paymentchoice;

  String _radioValue2; //Initial definition of radio button value
  String deliverychoice;
  DeliveryVat deliveryVat;

  int VatValue = 0;
  int DeliveryCharge = 0;
  int finalTotal = 0;
  final TextEditingController _commentsControl = new TextEditingController();
  ////

  OrderDb dbOrderManager = OrderDb();
  Order order;
  List<Order> orderList;
  int sum = 0;

  List menuList = [];
  List quantityList = [];
  String userId;

  bool oneLoadSum = true;

  @override
  void initState() {
    super.initState();

    Services.getDeliveryVat().then((onValue) {
      print("onValue ${onValue}");
      deliveryVat = onValue;
    });

    StripeService.init();
    UserShareFrence.getStringUserID().then((value) {
      print('value......... ${value}');
      setState(() {
        userId = value;
      });
    });
  }

  void payment(String value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case 'cash':
          paymentchoice = value;
          break;
        case 'card':
          paymentchoice = value;
          break;
        default:
          paymentchoice = null;
      }
      debugPrint(paymentchoice); //Debug the choice in console
      print(paymentchoice); //Debug the choice in console
    });
  }

  void paymentProcess(String value) {
    setState(() {
      _radioValue2 = value;
      switch (value) {
        case 'with_deliver_man':
          deliverychoice = value;
          setState(() {
            DeliveryCharge = int.parse(deliveryVat.deliveryCharge);
            VatValue = int.parse(deliveryVat.vat);
            int vat = ((_menuPriceTotall + DeliveryCharge) +
                    ((VatValue / 100) * (_menuPriceTotall + DeliveryCharge)))
                .round();
            finalTotal = vat;
          });
          break;
        case 'without_deliver_man':
          deliverychoice = value;
          setState(() {
            VatValue = int.parse(deliveryVat.vat);
            DeliveryCharge = 0;
            int vat = ((_menuPriceTotall + DeliveryCharge) +
                    ((VatValue / 100) * (_menuPriceTotall + DeliveryCharge)))
                .round();
            finalTotal = vat;
          });
          break;
        default:
          deliverychoice = null;
      }
      debugPrint(deliverychoice); //Debug the choice in console
      print(deliverychoice); //Debug the choice in console
    });
  }

  orderItem() {
    if (["", null, false, 0].contains(paymentchoice)) {
      toastShow("Please Select Payment Option");
    } else {
      if (["", null, false, 0].contains(deliverychoice)) {
        toastShow("Please Select Delivery Option");
      } else {
        if (["cash"].contains(paymentchoice)) {
          orderItemDb();
        } else if (["card"].contains(paymentchoice)) {
          onItemPress(context);
        }
      }
    }
  }

  toastShow(String msgData) {
    Fluttertoast.showToast(
        msg: msgData,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  String taka;
  String my = '0';

  onItemPress(BuildContext context) async {
    payViaNewCard(context);
//        print(context);
  }

  payViaNewCard(BuildContext context) async {
    /*  ProgressDialog dialog = new ProgressDialog(context);
    dialog.style(
        message: 'Please wait...'
    );*/
    //  await dialog.show();
//    print('hello world:');
    var response = await StripeService.payWithNewCard(
        amount: finalTotal.toString(), currency: 'USD');

    //  await dialog.hide();
    print(response.message);
    if (response.message == "Transaction successful") {
      orderItemDb();
    } else {
      _ackAlertError(context);
    }
//    Scaffold.of(context).showSnackBar(
//      SnackBar(
//        content: Text(response.message),
//        duration: new Duration(milliseconds: response.success == true ? 2200 : 3000),
//      )
//    );
  }

  orderItemDb() {
    dbOrderManager.getmenuItemId().then((orderValue) {
      List orderListtmp = orderValue;
      print("orderList2 ${orderListtmp} ${orderValue}");

      for (var element in orderListtmp) {
        print(element['menuItemId']);
        print(element['menuQuantity']);
        menuList.add(element['menuItemId']);
        quantityList.add(element['menuQuantity']);
      }
      String blank = _commentsControl.text.toString();
      if (["", null, false, 0].contains(blank)) {
        blank = "blank";
      }

      Services.addOrderUser(menuList, quantityList, userId, paymentchoice,
              deliverychoice, blank)
          .then((response) {
        if ('success' == response) {
          //  _getEmployees(); // Refresh the list after update
          print('up data33 ${response}');
          menuList.clear();
          quantityList..clear();
          _ackAlert(context);
        }
      });
    });

    // final data=dbOrderManager.getmenuItemId();
    // print("data ${data}");
  }

  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order Success'),
          content: const Text('Order has been successed'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _ackAlertError(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Order not Success'),
          content: const Text('Order has not been successed'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
            "Order Panel",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3.2,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white,
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              /*Text(
                              "Cash On",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),*/
                              Image.asset(
                                "assets/money.png",
                                height: 20.0,
                                width: 20.0,
                              ),
                              Radio(
                                value: 'cash',
                                groupValue: _radioValue,
                                onChanged: payment,
                              ),
                              /*     Text(
                              "Card On",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),*/
                              Image.asset(
                                "assets/credit_card.png",
                                height: 20.0,
                                width: 20.0,
                              ),
                              Radio(
                                value: 'card',
                                groupValue: _radioValue,
                                onChanged: payment,
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/food_delivery.png",
                                    height: 20.0,
                                    width: 20.0,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "With Delivery man",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Radio(
                                    value: 'with_deliver_man',
                                    groupValue: _radioValue2,
                                    onChanged: paymentProcess,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/delivery.png",
                                    height: 20.0,
                                    width: 20.0,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "WithOut Delivery man",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Radio(
                                    value: 'without_deliver_man',
                                    groupValue: _radioValue2,
                                    onChanged: paymentProcess,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: MediaQuery.of(context).size.width / 2,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white,
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                "Total :",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                "  ${_menuPriceTotall}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "Vat :",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                "  ${VatValue}%",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "DeliveryCharge :",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                "  ${DeliveryCharge}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                "FinalTotal :",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                "  ${finalTotal}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(12),
                  height: 5 * 24.0,
                  child: TextField(
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Enter a message",
                      fillColor: Colors.redAccent[300],
                      filled: true,
                    ),
                    controller: _commentsControl,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              RaisedButton(
                child: Text(
                  "Order",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  orderItem();
                },
              ),
              SizedBox(width: 10.0),
            ],
          ),
        ));
  }
}
