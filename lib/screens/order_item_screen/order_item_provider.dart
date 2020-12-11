import 'package:flutter/foundation.dart';
import 'package:flutterapptestpush/sqlite/order.dart';
import 'package:flutterapptestpush/sqlite/order_provider.dart';

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

  OrderDb dbManager = OrderDb();
  List<Order> studentList;

  Future<List<Order>> getCartList() async {
    // notifyListeners();
    return await dbManager.getOrder();
  }

  void changeValue(int id, String quantity) async {
    print('id :  $id');
    print('quantity :  $quantity');
    /* print("${id}...${name}");
    dbManager.updateCart(
        new Cart(id: int.parse(id),menuItemId: "1",menuName: name));*/
    await dbManager.updateTitle(id: id, quantity: quantity);
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
