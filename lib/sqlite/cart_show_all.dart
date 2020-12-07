import 'package:flutter/material.dart';
import 'package:flutterapptestpush/sqlite/cart.dart';
import 'package:flutterapptestpush/sqlite/cart_provider.dart';
import 'package:provider/provider.dart';
import 'cart_add_new.dart';
import 'order.dart';
import 'order_provider.dart';

class ShowCartAll extends StatefulWidget {
  @override
  _ShowCartAllState createState() => _ShowCartAllState();
}

class _ShowCartAllState extends State<ShowCartAll> {
  OrderProvider dbManager = OrderProvider();
  Order student;
  List<Order> studentList;

  @override
  void didUpdateWidget(ShowCartAll oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyOrderModel2>(
      create: (context)=>MyOrderModel2(),
      child: Scaffold(
      appBar: AppBar(
        title: Text('Hello world'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddCartNew(false)));
            },
          )
        ],
      ),
      body: Consumer<MyOrderModel2>(
    builder: (contex,myModel2,child){
     return FutureBuilder(
        future: myModel2.getCartList(),
        builder: (context, i) {
          if (i.hasData) {
            studentList = i.data;
            return ListView.builder(
              itemCount: studentList.length,
              itemBuilder: (BuildContext context, index) {
                Order st = studentList[index];
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        width: 100.0,
                        child: Column(
                          children: <Widget>[
                            Text('name: ${st.menuQuantity}'),
                            RaisedButton(
                              child: Text('Add new'),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddCartNew(false)));
                              },
                            ),
                          ],
                        ),
                      ),
                      RaisedButton(
                        child: Text('Delete'),
                        onPressed: () {
                        /*  dbManager.deleteCart(st.id);
                          setState(() {
                            studentList.removeAt(index);
                          });*/
                          Provider.of<MyOrderModel2>(context,listen: false).changeValue(st.menuItemId.toString(),"1");
                        },
                      ),
                      RaisedButton(
                        child: Text('Edit'),
                        onPressed: () {
                          student = st;
                          print(student);
                        /*  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddCartNew(
                                        true,
                                        student: st,
                                      )));*/
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
          return CircularProgressIndicator();
        },
      );
    }
      ),
    ),);
  }
}

class MyOrderModel2 with ChangeNotifier {
  OrderProvider dbManager = OrderProvider();
  List<Order> studentList;

  Future<List<Order>> getCartList()async {
    notifyListeners();
    return await dbManager.getOrder();
      /*.then((onValue){
        print("onValue...${onValue}");
       studentList=onValue;
       return studentList;
     });*/


  }
  changeValue(String id,String name)async{
   /* print("${id}...${name}");
    dbManager.updateCart(
        new Cart(id: int.parse(id),menuItemId: "1",menuName: name));*/

     await dbManager.getupdateMenuQuantity(id,name);

    notifyListeners();
  }
}
