import 'package:flutter/material.dart';

import 'package:flutterapptestpush/screens/details_item.dart';
import 'package:flutterapptestpush/util/const.dart';
import 'package:flutterapptestpush/widgets/smooth_star_rating.dart';

class GridProduct extends StatelessWidget {
  final String menuId;
  final String name;
  final String img;
  final bool isFav;
  final double rating;
  final int raters;
  final String price;
  final Function deleteItem;


  GridProduct({
    Key key,
    @required this.menuId,
    @required this.name,
    @required this.img,
    @required this.isFav,
    @required this.rating,
    @required this.raters,
    @required this.price,
    @required this.deleteItem,
  })
      :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
//      height: 300.0,
        child: InkWell(
          child: ListView(
            shrinkWrap: true,
            primary: false,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 100.0,
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        "$img",
                        fit: BoxFit.cover,
//                    height: 50,
                      ),
                    ),
                  ),

                  Positioned(
                    right: -10.0,
                    bottom: 3.0,
                    child: RawMaterialButton(
                      onPressed: (){},
                      fillColor: Colors.white,
                      shape: CircleBorder(),
                      elevation: 4.0,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: IconButton(
                          icon: Icon(
                            isFav
                                ?Icons.favorite
                                :Icons.favorite_border,
                            color: Colors.blue,
                            size: 17,
                          ),
                          onPressed: deleteItem,
                        ),
                      ),
                    ),
                  ),
                ],


              ),


              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                 Expanded(child:Padding(
                    padding: EdgeInsets.only(bottom: 2.0, top: 8.0,left: 10),
                    child: Text(
                      "$name",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w900,
                      ),
                      maxLines: 2,
                    ),
                  ),
                 ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 2.0, top: 8.0,right: 10),
                    child: Text(
                      "Price $price",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w900,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
                child: Row(
                  children: <Widget>[
                    SmoothStarRating(
                      starCount: 5,
                      color: Constants.ratingBG,
                      allowHalfRating: true,
                      rating: rating,
                      size: 10.0,
                    ),

                    Text(
                      " $rating ($raters Reviews)",
                      style: TextStyle(
                        fontSize: 11.0,
                      ),
                    ),

                  ],
                ),
              ),




            ],
          ),
          onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context){
                  return DetailsItem(menuId,img);
                },
              ),
            );
          },
        )
    );
  }
}


//
//InkWell(
//child: ListView(
//shrinkWrap: true,
//primary: false,
//children: <Widget>[
//Stack(
//children: <Widget>[
//Container(
//height: MediaQuery.of(context).size.height / 3.6,
//width: MediaQuery.of(context).size.width / 2.2,
//child: ClipRRect(
//borderRadius: BorderRadius.circular(8.0),
//child: Image.asset(
//"$img",
//fit: BoxFit.cover,
//),
//),
//),
//
//Positioned(
//right: -10.0,
//bottom: 3.0,
//child: RawMaterialButton(
//onPressed: (){},
//fillColor: Colors.white,
//shape: CircleBorder(),
//elevation: 4.0,
//child: Padding(
//padding: EdgeInsets.all(5),
//child: Icon(
//isFav
//?Icons.favorite
//    :Icons.favorite_border,
//color: Colors.red,
//size: 17,
//),
//),
//),
//),
//],
//
//
//),
//
//Padding(
//padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
//child: Text(
//"$name",
//style: TextStyle(
//fontSize: 20.0,
//fontWeight: FontWeight.w900,
//),
//maxLines: 2,
//),
//),
//
//Padding(
//padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
//child: Row(
//children: <Widget>[
//SmoothStarRating(
//starCount: 5,
//color: Constants.ratingBG,
//allowHalfRating: true,
//rating: rating,
//size: 10.0,
//),
//
//Text(
//" $rating ($raters Reviews)",
//style: TextStyle(
//fontSize: 11.0,
//),
//),
//
//],
//),
//),
//
//
//],
//),
//onTap: (){
//Navigator.of(context).push(
//MaterialPageRoute(
//builder: (BuildContext context){
//return ProductDetails();
//},
//),
//);
//},
//);