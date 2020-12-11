import 'package:flutter/material.dart';

import 'package:flutterapptestpush/sqlite/order.dart';
import 'package:flutterapptestpush/sqlite/order_provider.dart';
import 'package:flutterapptestpush/widgets/cart_item.dart';

import 'package:flutterapptestpush/sqlite/cart.dart';
import 'package:flutterapptestpush/sqlite/cart_provider.dart';
import 'package:flutterapptestpush/widgets/order_item.dart';
import 'package:flutterapptestpush/widgets/order_user_item.dart';

class OrderUserScreen extends StatefulWidget {
  @override
  _OrderUserScreenState createState() => _OrderUserScreenState();
}

class _OrderUserScreenState extends State<OrderUserScreen>
    with AutomaticKeepAliveClientMixin<OrderUserScreen> {
  OrderDb dbOrderManager = OrderDb();
  Order order;
  List<Order> orderList;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: FutureBuilder(
          future: dbOrderManager.getOrder(),
          builder: (context, i) {
            if (i.hasData) {
              orderList = i.data;
              return ListView.builder(
                itemCount: orderList == null ? 0 : orderList.length,
                itemBuilder: (BuildContext context, int index) {
//                Food food = Food.fromJson(foods[index]);
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
                    quantity: oa.menuQuantity,
                    deleteOrder: () {
                      dbOrderManager.deleteOrder(id: oa.id);
                      setState(() {
                        orderList.removeAt(index);
                      });
                    },
                  );
                },
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
