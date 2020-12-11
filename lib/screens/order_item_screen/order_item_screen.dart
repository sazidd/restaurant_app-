import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  OrderDb dbOrderManager = OrderDb();
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
    _orderItemBloc.add(FetchOrder());
    super.initState();
    StripeService.init();
    UserShareFrence.getStringUserID().then((value) {
      print('value......... $value');
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
            "Order Item",
          ),
        ),
        body: BlocConsumer<OrderItemBloc, OrderItemState>(
          listener: (context, state) {},
          builder: (contex, state) {
            if (state is OrderItemSuccess) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    // if (i.hasData) {
                    //   orderList = i.data;
                    //   if (oneLoadSum == true) {
                    //     Provider.of<MyOrderModel>(context, listen: true)
                    //         .sumValueAdd(_menuPriceTotall);
                    //     oneLoadSum = false;
                    //   }

                    ListView.builder(
                  itemCount: state.orders == null ? 0 : state.orders.length,
                  itemBuilder: (context, index) {
                    Order order = state.orders[index];

//                print(foods);
//                print(foods.length);
                    return OrderUserItem(
                      menuId: order.menuItemId,
                      img: order.menuImageSource,
                      isFav: false,
                      name: order.menuName,
                      rating: 5.0,
                      raters: 23,
                      price: order.menuPrice,
                      deleteOrder: () {
                        // _orderItemBloc.add(OrderDelete());

                        // dbOrderManager.deleteOrder(order.id);
                        // setState(() {
                        // orderList.removeAt(index);
                        // });
                        // Provider.of<MyOrderModel>(context,
                        //         listen: false)
                        //     .sumValueMinus(int.parse(order.menuPrice));
                      },
                      update: () {
                        // context.watch<OrderItemBloc>();

//                                 int f = int.parse(order.menuQuantity);
//                                 f++;
//                                 String m = f.toString();
//                                 setState(() {
// //                        int m = int.parse(ca.id);
//                                   Provider.of<MyOrderModel>(context,
//                                           listen: false)
//                                       .changeValue(order.id, m);
//                                   Provider.of<MyOrderModel>(context,
//                                           listen: false)
//                                       .sumValuePlus(int.parse(order.menuPrice));
//                                 });
                      },
                      decrease: () {
//                                 int f = int.parse(order.menuQuantity);
//                                 f--;
//                                 String m = f.toString();
//                                 setState(() {
// //                        int m = int.parse(ca.id);
//                                   Provider.of<MyOrderModel>(context,
//                                           listen: false)
//                                       .changeValue(order.id, m);
//                                   Provider.of<MyOrderModel>(context,
//                                           listen: false)
//                                       .sumValueMinus(int.parse(order.menuPrice));
//                                 });
                      },
                      quantity: order.menuQuantity.toString(),
                    );
                  },
                ),
              );
            }
            return Container();
          },
        ),
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
                      child: BlocBuilder<OrderItemBloc, OrderItemState>(
                        builder: (context, state) {
                          if (state is OrderItemSuccess) {
                            // taka = state.toString();
                            return Text(
                              "${state.total}",
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w900,
                                color: Theme.of(context).accentColor,
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                      //  Consumer<MyOrderModel>(
                      //     builder: (contex, myModel, child) {
                      //   taka = myModel._sumToatal.toString();
                      //   return Text(
                      //     "${myModel._sumToatal}",
                      //     style: TextStyle(
                      //       fontSize: 14.0,
                      //       fontWeight: FontWeight.w900,
                      //       color: Theme.of(context).accentColor,
                      //     ),
                      //   );
                      // },
                      // ),
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
        ));
    //);
  }

  @override
  bool get wantKeepAlive => true;
}
