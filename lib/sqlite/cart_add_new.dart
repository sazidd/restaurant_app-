
import 'package:flutter/material.dart';
import 'package:flutterapptestpush/sqlite/cart.dart';
import 'package:flutterapptestpush/sqlite/cart_provider.dart';

class AddCartNew extends StatefulWidget {
  final bool edit;
  final Cart student;

  AddCartNew(this.edit, {this.student}) : assert(edit == true || student == null);

  @override
  _AddCartNewState createState() => _AddCartNewState();
}

class _AddCartNewState extends State<AddCartNew> {
  TextEditingController _userIdController = TextEditingController();
  final _form_key = GlobalKey<FormState>();
  CartProvider dbManager = CartProvider();
  @override
  void initState() {
    super.initState();
    if (widget.edit == true) {
      _userIdController.text = widget.student.userId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi'),
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: _form_key,
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _userIdController,
                  decoration: InputDecoration(hintText: 'type you name'),
//                  keyboardType: TextInputType.number,
                ),
                RaisedButton(
                  child: Text('Save'),
                  onPressed: () {
                    setState(() {
                      _saveData();
                    });
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _saveData() {
    if (widget.edit == false) {
      dbManager.insertCart(Cart(userId: _userIdController.text));
    } else {
      dbManager.updateCart(
          new Cart(userId: _userIdController.text, id: widget.student.id));
    }
  }
}
