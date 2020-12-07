import 'package:flutter/material.dart';
import 'package:flutterapptestpush/widgets/grid_product.dart';

import 'package:flutterapptestpush/sqlite/wishlist.dart';
import 'package:flutterapptestpush/sqlite/wishlist_provider.dart';

class FavoriteMenuScreen extends StatefulWidget {
  @override
  _FavoriteMenuScreenState createState() => _FavoriteMenuScreenState();
}

class _FavoriteMenuScreenState extends State<FavoriteMenuScreen> with AutomaticKeepAliveClientMixin<FavoriteMenuScreen>{

  WishlistProvider dbWishlistManager = WishlistProvider();
  Wishlist wishlist;
  List<Wishlist> wishlistList;

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
          "Wish Panel",
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            Text(
              "My Favorite Items",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              constraints: BoxConstraints.tightFor(height: 600.0),
              child: FutureBuilder(
                future: dbWishlistManager.getWishlistList(),
                builder: (context, i) {
                  if (i.hasData) {
                    wishlistList = i.data;
                    return GridView.builder(
                      shrinkWrap: true,
                      primary: false,
//                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.25),
                      ),
                      itemCount: wishlistList == null ? 0 :wishlistList.length,
                      itemBuilder: (BuildContext context, int index) {
//                Food food = Food.fromJson(foods[index]);
                        Wishlist wish = wishlistList[index];
//                print(foods);
//                print(foods.length);

                        return GridProduct(
                          img: wish.menuImageSource,
                          isFav: true,
                          name: wish.menuName,
                          rating: 5.0,
                          raters: 23,
                          price: wish.menuPrice,
                          deleteItem: (){
                            dbWishlistManager.deleteWishlist(wish.id);
                            setState(() {
                              wishlistList.removeAt(index);
                            });
                          },
                        );
                      },
                    );
                  }
                  return Center(child: Text("There are No Wish List"));
                },
              ),
            ),


            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}