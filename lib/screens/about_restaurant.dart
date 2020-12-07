import 'package:flutter/material.dart';
import 'package:flutterapptestpush/db/services.dart';
import 'package:flutterapptestpush/model/ReservationTable.dart';

class AboutResaurant extends StatefulWidget {
  @override
  _AboutResaurant createState() => _AboutResaurant();
}

class _AboutResaurant extends State<AboutResaurant> {


  @override
  void initState() {

    super.initState();
  }





  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[

                    SizedBox(height: 20.0,),
                   Container(
                          constraints: BoxConstraints.tightFor(height: 250.0),
                          height: MediaQuery.of(context).size.height*2,
                          width: MediaQuery.of(context).size.width,
                          child: Column(children: <Widget>[
                            Text('About Restaurant',style: TextStyle(
                                fontSize: 20,fontWeight:FontWeight.bold
                            ),),
                            Image.asset('assets/reservation1.jpg',fit: BoxFit.fill,),
                          ],)
                      ),
                    SizedBox(height: 20.0,),
                    Row(
                      children: <Widget>[
                              Text(
                              "Name :",
                              style: TextStyle(
                                fontSize: 16,

                                fontWeight: FontWeight.w300,
                                  ),
                              ),

                            Text(
                          "",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  SizedBox(height: 10,),
                    Row(
                      children: <Widget>[
                        Text(
                          "Adress :",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),

                        Text(
                          "",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: <Widget>[
                        Text(
                          "Phone :",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),

                        Text(
                          "",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: <Widget>[
                        Text(
                          "Mobile :",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),

                        Text(
                          "",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 10,),
                  ],
                ),


              ),
            ],
          ),
        ),
      ),
    );
  }
}
