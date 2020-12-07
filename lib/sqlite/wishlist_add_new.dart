
import 'package:flutter/material.dart';
import 'package:flutterapptestpush/sqlite/wishlist.dart';
import 'package:flutterapptestpush/sqlite/wishlist_provider.dart';

class AddNew extends StatefulWidget {
  final bool edit;
  final Wishlist student;

  AddNew(this.edit, {this.student}) : assert(edit == true || student == null);

  @override
  _AddNewState createState() => _AddNewState();
}

class _AddNewState extends State<AddNew> {
  TextEditingController _userIdController = TextEditingController();
  final _form_key = GlobalKey<FormState>();
  WishlistProvider dbManager = WishlistProvider();
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
      dbManager.insertWishlist(Wishlist(userId: _userIdController.text));
    } else {
      dbManager.updateWishlist(
          new Wishlist(userId: _userIdController.text, id: widget.student.id));
    }
  }
}
