import 'package:flutter/material.dart';
import 'package:flutterapptestpush/db/payment-service.dart';
import 'package:flutterapptestpush/screens/order_item_screen/bloc/order_item_bloc.dart';
import 'package:provider/provider.dart';

import 'package:flutterapptestpush/sqlite/order.dart';
import 'package:flutterapptestpush/sqlite/order_provider.dart';
import 'package:flutterapptestpush/util/usershareperf.dart';

import 'package:flutterapptestpush/widgets/order_user_item.dart';

import '../order_payment_screen.dart';

class OrderItemScreen extends StatefulWidget {
  final int _menuPriceTotal;

  const OrderItemScreen(this._menuPriceTotal);

  @override
  State<StatefulWidget> createState() {
    return _OrderScreennState(this._menuPriceTotal);
  }
}

class _OrderScreennState extends State<OrderItemScreen>
    with AutomaticKeepAliveClientMixin<OrderItemScreen> {
  OrderItemBloc _orderItemBloc;
  String taka;

  onItemPress(BuildContext context) async {
    payViaNewCard(context);
  }

  payViaNewCard(BuildContext context) async {
    var response =
        await StripeService.payWithNewCard(amount: taka, currency: 'USD');
    print(response.message);
    if (response.message == "Transaction successful") {
      orderItem();
    } else {
      _ackAlertError(context);
    }
  }

  ////
  int _menuPriceTotall;
  OrderProvider dbOrderManager = OrderProvider();
  Order order;
  List<Order> orderList;
  int sum = 0;

  List orderList3 = [];
  String userId;

  _OrderScreennState(this._menuPriceTotall);
  bool oneLoadSum = true;

  @override
  void initState() {
    _orderItemBloc = context.read<OrderItemBloc>();
    super.initState();
    StripeService.init();
    UserShareFrence.getStringUserID().then((value) {
      print('value......... ${value}');
      setState(() {
        userId = value;
      });
    });
  }

  orderItem() {
    dbOrderManager.getmenuItemId().then((orderValue) {
      List orderListtmp = orderValue;
      print("orderList2 ${orderListtmp} ${orderValue}");

      for (var element in orderListtmp) {
        print(element['menuItemId']);
        print(element['menuQuantity']);
        orderList3.add(element['menuItemId']);
        orderList3..add(element['menuQuantity']);
      }
      print("orderList3 ${orderList3} ");
    });
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
    return ChangeNotifierProvider<MyOrderModel>(
      create: (context) => MyOrderModel(),
      child: Scaffold(
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
              "Order Item",
            ),
          ),
          body: Consumer<MyOrderModel>(builder: (contex, myModel2, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                future: myModel2.getCartList(),
                builder: (context, i) {
                  if (i.hasData) {
                    orderList = i.data;
                    if (oneLoadSum == true) {
                      Provider.of<MyOrderModel>(context, listen: true)
                          .sumValueAdd(_menuPriceTotall);
                      oneLoadSum = false;
                    }

                    return ListView.builder(
                      itemCount: orderList == null ? 0 : orderList.length,
                      itemBuilder: (BuildContext context, int index) {
                        Order oa = orderList[index];

//                print(foods);
//                print(foods.length);
                        return OrderUserItem(
                          menuId: oa.menuItemId,
                          img: oa.menuImageSource,
                          isFav: false,
                          name: oa.menuName,
                          rating: 5.0,
                          raters: 23,
                          price: oa.menuPrice,
                          deleteOrder: () {
                            dbOrderManager.deleteOrder(oa.id);
                            setState(() {
                              orderList.removeAt(index);
                            });
                            Provider.of<MyOrderModel>(context, listen: false)
                                .sumValueMinus(int.parse(oa.menuPrice));
                          },
                          update: () {
                            int f = int.parse(oa.menuQuantity);
                            f++;
                            String m = f.toString();
                            setState(() {
//                        int m = int.parse(ca.id);
                              Provider.of<MyOrderModel>(context, listen: false)
                                  .changeValue(oa.id, m);
                              Provider.of<MyOrderModel>(context, listen: false)
                                  .sumValuePlus(int.parse(oa.menuPrice));
                            });
                          },
                          decrease: () {
                            int f = int.parse(oa.menuQuantity);
                            f--;
                            String m = f.toString();
                            setState(() {
//                        int m = int.parse(ca.id);
                              Provider.of<MyOrderModel>(context, listen: false)
                                  .changeValue(oa.id, m);
                              Provider.of<MyOrderModel>(context, listen: false)
                                  .sumValueMinus(int.parse(oa.menuPrice));
                            });
                          },
                          quantity: oa.menuQuantity.toString(),
                        );
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            );
          }),
          bottomNavigationBar: Container(
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(height: 10.0),
                Center(
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Total Price:",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Container(
                        child: Consumer<MyOrderModel>(
                            builder: (contex, myModel, child) {
                          taka = myModel._sumToatal.toString();
                          return Text(
                            "${myModel._sumToatal}",
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w900,
                              color: Theme.of(context).accentColor,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                RaisedButton(
                  child: Text(
                    "Order",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    // orderItem();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return OrderPaymentScreen(int.parse(taka));
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 10.0),
              ],
            ),
          )),
    );
    //);
  }

  @override
  bool get wantKeepAlive => true;
}

class MyOrderModel with ChangeNotifier {
  int Sum = 0;

  int get _sumToatal => Sum;

  sumValueAdd(int sumTemp) {
    // Sum=Sum+sumTemp;
    Sum = sumTemp;
    print("Sum22 ++ ${Sum}");
    notifyListeners();
  }

  sumValueMinus(int sumTemp) {
    Sum = Sum - sumTemp;

    print("Sum33 --- ${Sum}");
    notifyListeners();
  }

  sumValuePlus(int sumTemp) {
    Sum = Sum + sumTemp;

    print("Sum33 --- ${Sum}");
    notifyListeners();
  }

  ////

  OrderProvider dbManager = OrderProvider();
  List<Order> studentList;

  Future<List<Order>> getCartList() async {
    notifyListeners();
    return await dbManager.getOrder();
  }

  void changeValue(int id, String quantity) async {
    print('id :  $id');
    print('quantity :  $quantity');
    /* print("${id}...${name}");
    dbManager.updateCart(
        new Cart(id: int.parse(id),menuItemId: "1",menuName: name));*/
    await dbManager.updateTitle(id, quantity);
//    await dbManager.getupdateMenuQuantity(id,name);
    notifyListeners();
  }

/* totalMenuWithQuantity()async{
   Sum= await dbManager.getMenuPrice();*/ /*.then((onValue){
     print("onValue..${onValue}");
     Sum=onValue;
   });*/ /*
   notifyListeners();
   return Sum;

 }*/

}
