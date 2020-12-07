import 'package:flutter/material.dart';

import 'package:flutterapptestpush/util/const.dart';
import 'package:flutterapptestpush/widgets/smooth_star_rating.dart';


class OrderItem extends StatelessWidget {
  final String name;
  final String img;
  final bool isFav;
  final double rating;
  final int raters;
  final String price;
  final Function deleteOrder;


  OrderItem({
    Key key,
    @required this.name,
    @required this.img,
    @required this.isFav,
    @required this.rating,
    @required this.raters,
    @required this.price,
    @required this.deleteOrder,

  })
      :super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: InkWell(
        onTap: (){
         /* Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context){
                return ProductDetails();
              },
            ),
          );*/
        },
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 0.0, right: 10.0),
              child: Container(
                height: MediaQuery.of(context).size.width/3.5,
                width: MediaQuery.of(context).size.width/3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    "$img",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "$name",
                  style: TextStyle(
//                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 2.0),
                Row(
                  children: <Widget>[
                    SmoothStarRating(
                      starCount: 1,
                      color: Constants.ratingBG,
                      allowHalfRating: true,
                      rating: 5.0,
                      size: 12.0,
                    ),
                    SizedBox(width: 2.0),
                    Text(
                      "5.0 (23 Reviews)",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.remove_circle),
                      onPressed: deleteOrder,
                    )
                  ],
                ),
                SizedBox(height: 2.0),
                Row(
                  children: <Widget>[
                    Text(
                      "Price",
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(width: 2.0),

                    Text(
                      "${price}",
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).accentColor,
                      ),
                    ),

                  ],
                ),

                SizedBox(height: 1.0),

                    Text(
                      "Quantity: 1",
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),



              ],

            ),
          ],
        ),
      ),
    );
  }
}
