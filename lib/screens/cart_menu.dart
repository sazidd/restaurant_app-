import 'package:flutter/material.dart';

import 'package:flutterapptestpush/widgets/cart_item.dart';

import 'package:flutterapptestpush/sqlite/cart.dart';
import 'package:flutterapptestpush/sqlite/cart_provider.dart';

class CartMenuScreen extends StatefulWidget {
  @override
  _CartMenuScreenState createState() => _CartMenuScreenState();
}

class _CartMenuScreenState extends State<CartMenuScreen>
    with AutomaticKeepAliveClientMixin<CartMenuScreen> {
  CartProvider dbCartManager = CartProvider();
  Cart cart;
  List<Cart> cartList;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
          "Cart Panel",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: FutureBuilder(
          future: dbCartManager.getCart(),
          builder: (context, i) {
            if (i.hasData) {
              cartList = i.data;
              return ListView.builder(
                itemCount: cartList == null ? 0 : cartList.length,
                itemBuilder: (BuildContext context, int index) {
//                Food food = Food.fromJson(foods[index]);
                  Cart ca = cartList[index];
//                print(foods);
//                print(foods.length);

                  return CartItem(
                    menuId: ca.menuItemId,
                    img: ca.menuImageSource,
                    isFav: false,
                    name: ca.menuName,
                    rating: 5.0,
                    raters: 23,
                    price: ca.menuPrice.toString(),
                    deleteCart: () {
                      dbCartManager.deleteCart(ca.id);
                      setState(() {
                        cartList.removeAt(index);
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
