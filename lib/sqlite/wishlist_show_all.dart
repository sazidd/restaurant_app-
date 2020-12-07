import 'package:flutter/material.dart';
import 'package:flutterapptestpush/sqlite/wishlist.dart';
import 'package:flutterapptestpush/sqlite/wishlist_provider.dart';
import 'wishlist_add_new.dart';

class ShowAll extends StatefulWidget {
  @override
  _ShowAllState createState() => _ShowAllState();
}

class _ShowAllState extends State<ShowAll> {
  WishlistProvider dbManager = WishlistProvider();
  Wishlist student;
  List<Wishlist> studentList;

  @override
  void didUpdateWidget(ShowAll oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello world'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddNew(false)));
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: dbManager.getWishlistList(),
        builder: (context, i) {
          if (i.hasData) {
            studentList = i.data;
            return ListView.builder(
              itemCount: studentList.length,
              itemBuilder: (BuildContext context, index) {
                Wishlist st = studentList[index];
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        width: 100.0,
                        child: Column(
                          children: <Widget>[
                            Text('name: ${st.menuDescription}'),
                            RaisedButton(
                              child: Text('Add new'),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddNew(false)));
                              },
                            ),
                          ],
                        ),
                      ),
                      RaisedButton(
                        child: Text('Delete'),
                        onPressed: () {
                          dbManager.deleteWishlist(st.id);
                          setState(() {
                            studentList.removeAt(index);
                          });
                        },
                      ),
                      RaisedButton(
                        child: Text('Edit'),
                        onPressed: () {
                          student = st;
                          print(student);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddNew(
                                        true,
                                        student: st,
                                      )));
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
      ),

    );
  }
}
