

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:intl/intl.dart';
import 'package:flutterapptestpush/db/services.dart';
import 'package:flutterapptestpush/model/reservation_model.dart';
import 'package:flutterapptestpush/screens/reservation_screen_one_month.dart';
import 'package:flutterapptestpush/util/usershareperf.dart';

import 'join.dart';

class ReservationScreen extends StatefulWidget {
  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen>{

  TextEditingController _userIdController = TextEditingController();
  TextEditingController _numberOfTableController = TextEditingController();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();

  //full reservation
  TextEditingController _userFIdController = TextEditingController();
  TextEditingController _numberFOfTableController = TextEditingController();
  TextEditingController _startFTimeController = TextEditingController();
  TextEditingController _endFTimeController = TextEditingController();
  TextEditingController _startFDateController = TextEditingController();
  TextEditingController _endFDateController = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey;
  String userId;

  _addReservationTable() {
    if(["", null, false, 0].contains(userId)){
      //when user id is empty
      _ackAlert(context,"Wish List Operation");
    }else{
      //when user id not is empty
    _userIdController.text = 4.toString();
    _numberOfTableController.text = tableNumber.toString();
    if (_numberOfTableController.text.isEmpty ||
        _startDateController.text.isEmpty || _endDateController.text.isEmpty ||
        _startTimeController.text.isEmpty || _endTimeController.text.isEmpty

    ) {
      print('Empty Fieldsdfrgesdfrs');

      return;
    }
    Services.addReservationTable(
      userId, _numberOfTableController.text,
      _startDateController.text, _endDateController.text,
      _startTimeController.text, _endTimeController.text,
    )
        .then((result) {
      if ('success' == result) {
        print('Success');
        // Refresh the List after adding each employee...
//        _clearValues();
      }
    });
  }
  }

  _addFReservationTable() {
    if(["", null, false, 0].contains(userId)){
      //when user id is empty
      _ackAlert(context,"Wish List Operation");
    }else{
      //when user id not is empty
    _userFIdController.text = 0.toString();
    _numberFOfTableController.text = 0.toString();
    if (_numberFOfTableController.text.isEmpty ||
        _startFTimeController.text.isEmpty ||
        _endFTimeController.text.isEmpty ||
        _startFDateController.text.isEmpty || _endFDateController.text.isEmpty

    ) {
      return;
    }
    Services.addReservationTable(
      userId, _numberFOfTableController.text,
      _startFTimeController.text, _endFTimeController.text,
      _startFDateController.text, _endFDateController.text,
    )
        .then((result) {
      if ('success' == result) {
        print('Success');
        // Refresh the List after adding each employee...
//        _clearValues();
      }
    });
  }
  }
//  _clearValues() {
//    _numberOfTableController.text = '';
//    _startDateController.text = '';
//  }

  Future<void> _ackAlert(BuildContext context,String msg) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ALERT'),
          content:  Text('After login you can done ${msg}'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Login'),
              onPressed: () {
                Navigator.of(context).pop();

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context){
                      return JoinApp();
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  List<Reservation> _reservation;

  int tableNumber = 0;
  _increase(){
    setState(() {
      tableNumber++;
    });
  }
  _decrease(){
    setState(() {
      if(tableNumber>=1){
        tableNumber--;
      }
    });
  }
  @override
  void initState() {
    UserShareFrence.getStringUserID().then((value) {
      print('value......... ${value}');
      setState(() {
        userId=value;

      });
    });
    super.initState();
    _reservation = [];

    _getReservation();


  }

  _getReservation() {
    Services.getReservation().then((reservation) {
      setState(() {
        _reservation = reservation;
        print("reservation: ${reservation}");
      });
      print("Length ${reservation.length}");
    });
  }

  DateTime _startDateTime = DateTime.now();
  DateTime _endDateTime = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();

  DateTime _fStartDateTime = DateTime.now();
  DateTime _fEndDateTime = DateTime.now();
  TimeOfDay _fStartTime = TimeOfDay.now();
  TimeOfDay _fEndTime = TimeOfDay.now();

// start nubmber of table
  Future<Null> _selectStartDate(BuildContext context)async{
//    _numberOfTableController.text = 0.toString();
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _startDateTime == null ? DateTime.now() : _startDateTime,
      firstDate: DateTime(2001),
      lastDate: DateTime(2021),
    );
   // if(picked != null && picked!= _startDateTime){
      setState(() {
        _startDateTime = picked;

    });
    //    }
    var parsedDate = DateTime.parse(_startDateTime.toIso8601String());
    String convertedDate = new DateFormat("yyyy-MM-dd").format(parsedDate);

    _startDateController.text = convertedDate;
  }

  Future<Null> _selectEndDate(BuildContext context)async{
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _endDateTime == null ? DateTime.now() : _endDateTime,
      firstDate: DateTime(2001),
      lastDate: DateTime(2021),
    );
  //  if(picked != null && picked!= _endDateTime){
      setState(() {
        _endDateTime = picked;

      });
  //  }
    var parsedDate = DateTime.parse(_endDateTime.toIso8601String());
    String convertedDate = new DateFormat("yyyy-MM-dd").format(parsedDate);

    _endDateController.text = convertedDate;
  }
  Future<Null> _selectStartTime(BuildContext context )async{
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: _startTime
    );
  //  if(picked != null && picked!= _startTime){
      setState(() {
        _startTime = picked;
      });
  //  }
    _startTimeController.text = _startTime.format(context);
  }
  Future<Null> _selectEndTime(BuildContext context )async{
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: _endTime
    );
 //   if(picked != null && picked!= _endTime){
      setState(() {
        _endTime = picked;
      });
  //  }
    _endTimeController.text = _endTime.format(context);
  }
//end number of table


  //full resturant
  Future<Null> _fSelectStartDate(BuildContext context)async{
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _fStartDateTime == null ? DateTime.now() : _fStartDateTime,
      firstDate: DateTime(2001),
      lastDate: DateTime(2021),
    );
//    if(picked != null && picked!= _fStartDateTime){
      setState(() {
        _fStartDateTime = picked;

      });
  //  }
    var parsedDate = DateTime.parse(_fStartDateTime.toIso8601String());
    String convertedDate = new DateFormat("yyyy-MM-dd").format(parsedDate);

    _startFDateController.text = convertedDate;
  }
  Future<Null> _fSelectEndDate(BuildContext context)async{
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _fEndDateTime == null ? DateTime.now() : _fEndDateTime,
      firstDate: DateTime(2001),
      lastDate: DateTime(2021),
    );
 //   if(picked != null && picked!= _fEndDateTime){
      setState(() {
        _fEndDateTime = picked;

      });
 //   }
    var parsedDate = DateTime.parse(_fEndDateTime.toIso8601String());
    String convertedDate = new DateFormat("yyyy-MM-dd").format(parsedDate);

    _endFDateController.text = convertedDate;
  }
  Future<Null> _fSelectStartTime(BuildContext context )async{
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: _fStartTime
    );
  //  if(picked != null && picked!= _fStartTime){
      setState(() {
        _fStartTime = picked;
      });
 //   }
    _startFTimeController.text = _fStartTime.format(context);
  }
  Future<Null> _fSelectEndTime(BuildContext context )async{
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: _fEndTime
    );
 //   if(picked != null && picked!= _fEndTime){
      setState(() {
        _fEndTime = picked;
      });
   // }
    _endFTimeController.text = _fEndTime.format(context);
  }

  //end full resturant




  Widget submitButton() {
    return RaisedButton(
      color: Colors.redAccent,
      child: Text('Submit!'),
      onPressed: () {
        _addReservationTable();
      },
    );
  }
  Widget fSubmitButton() {
    return RaisedButton(
      color: Colors.redAccent,
      child: Text('Submit'),
      onPressed: () {
        _addFReservationTable();
      },
    );
  }
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("More Table Not Abailable"),
//          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: <Widget>[
         /*   SizedBox(
              height: 10.0,
            ),
            FlatButton(
              child: Row(
                children: <Widget>[
                  Container(
                    height: 40.0,
                    width:  MediaQuery.of(context).size.width/2,
                    color: Colors.lightGreen,
                    child: Center(child: Text('One month Reservation',style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white
                    ),)),
                  ),

                  Container(
                    height: 40.0,
                    width:  MediaQuery.of(context).size.width/2,
                    child: IconButton(
                      icon: Icon(Icons.chevron_right),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return ReservationOneMonth();
                            },
                          ),
                        );
                      },

                    ),

                  ),

                ],
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ReservationOneMonth();
                    },
                  ),
                );
              },
            ),*/
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 200.0,
              child: Image.asset(
                'assets/reservation1.jpg',
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),

            SizedBox(height: 20.0,),
            Container(
              constraints: BoxConstraints.tightFor(height: 400.0),
              child: ListView.builder(
                  itemCount: _reservation.length,
                  itemBuilder: (BuildContext context,index){
                    int numbersOfTable = int.parse(_reservation[index].numberOfTable);
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0, right: 8.0),
                          child: Container(
                            height: 150.0,
                            width: MediaQuery.of(context).size.width*1,
                            child: Row(
                              children: <Widget>[




                                Container(
                                  width: MediaQuery.of(context).size.width*.38,
                                  color: Colors.blue,
                                  child: Image.asset('assets/reservation1.jpg'),
                                ),
//
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Text('Choose number of table'),
                                      Row(
                                        children: <Widget>[
                                          FlatButton(
                                            onPressed: (){
                                              tableNumber< numbersOfTable  ? _increase() :_showDialog();
                                            },
                                            child: Icon(
                                              FontAwesomeIcons.plus,size: 16,
                                            ),
                                          ),
                                          Text(tableNumber.toString(),
                                              style: TextStyle(fontWeight: FontWeight.bold,
                                                  fontSize: 16)
                                          ),
                                          FlatButton(
                                            onPressed: (){
                                              _decrease();
                                            },
                                            child: Icon(FontAwesomeIcons.minus,size: 16,),
                                          ),

                                        ],
                                      ),
                                      /*Text('Price: \$ ${_reservation[index].price}',
                                        style: TextStyle(fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        ),
                                      ),*/
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                 /* FlatButton(
                                    child: Container(
                                      height: 40.0,
                                      width: 150.0,
                                      color: Colors.redAccent,
                                      child: Center(child: Text('Start Date',style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white
                                      ),)),
                                    ),
                                    onPressed: () {
                                      _selectStartDate(context);
                                    },
                                  ),*/

                                  IconButton(
                                    icon: Icon(
                                          Icons.calendar_today,
                                      color: Colors.redAccent,
                                      size: 16,
                                    ),
                                    onPressed: () {
                                      _selectStartDate(context);
                                    },
                                  ),
                                  SizedBox(width: 5,),
                                  InkWell(
                                    onTap: () {
                                      _selectStartDate(context);
                                    },
                                    child: new Text('Start Date: ${_startDateController.text}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold
                                      ),

                                    ),
                                  )


                                ],
                              ),
                              Row(
                                children: <Widget>[
                                 /* FlatButton(
                                    child: Container(
                                      height: 40.0,
                                      width: 150.0,
                                      color: Colors.redAccent,
                                      child: Center(child: Text('End Date',style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white
                                      ),)),
                                    ),
                                    onPressed: () {
                                      _selectEndDate(context);
                                    },
                                  ),*/

                                  IconButton(
                                    icon: Icon(
                                      Icons.calendar_today,
                                      color: Colors.redAccent,
                                      size: 16,
                                    ),
                                    onPressed: () {
                                      _selectEndDate(context);
                                    },
                                  ),
                                  SizedBox(width: 5,),

                                  InkWell(
                                  onTap: () {
                                    _selectEndDate(context);
                                  },
                                  child: new  Text('End Date: ${_endDateController.text}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  ),

                                ],
                              ),
                              Row(
                                children: <Widget>[
                                 /* FlatButton(
                                    child: Container(
                                      height: 40.0,
                                      width: 150.0,
                                      color: Colors.lightGreen,
                                      child: Center(child: Text('Start Time',style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white
                                      ),)),
                                    ),
                                    onPressed: () {
                                      _selectStartTime(context);
                                    },
                                  ),*/
                                  IconButton(
                                    icon: Icon(
                                      Icons.watch_later,
                                      color: Colors.lightGreen,
                                      size: 16,
                                    ),
                                    onPressed: () {
                                      _selectStartTime(context);
                                    },
                                  ),
                                  SizedBox(width: 5,),
                                  InkWell(
                                    onTap: () {
                                      _selectStartTime(context);
                                    },
                                    child: new  Text('Start Time: ${_startTimeController.text}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  )


                                ],
                              ),
                              Row(
                                children: <Widget>[
                             /*     FlatButton(
                                    child: Container(
                                      height: 40.0,
                                      width: 150.0,
                                      color: Colors.lightGreen,
                                      child: Center(child: Text('End Time',style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white
                                      ),)),
                                    ),
                                    onPressed: () {
                                      _selectEndTime(context);
                                    },
                                  ),*/
                                  IconButton(
                                    icon: Icon(
                                      Icons.watch_later,
                                      color: Colors.lightGreen,
                                      size: 16,
                                    ),
                                    onPressed: () {
                                      _selectEndTime(context);
                                    },
                                  ),

                                  SizedBox(width: 5,),
                                  InkWell(
                                    onTap: () {
                                      _selectEndTime(context);
                                    },
                                    child: new  Text('End Time: ${_endTimeController.text}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  )

                                ],
                              ),
                              submitButton()

                            ],
                          ),
                        ),
                        SizedBox(height: 20.0,),
                      ],
                    );
                  }
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0,),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 8.0),
                    child: Container(
                        constraints: BoxConstraints.tightFor(height: 300.0),
                        height: MediaQuery.of(context).size.width*.5,
                        width: MediaQuery.of(context).size.width*1,
                        child: Column(children: <Widget>[
                          Text('Full Resturant Reservation',style: TextStyle(
                              fontSize: 20,fontWeight:FontWeight.bold
                          ),),
                          Image.asset('assets/reservation1.jpg',fit: BoxFit.fill,),
                        ],)
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                           /* FlatButton(
                              child: Container(
                                height: 40.0,
                                width: 150.0,
                                color: Colors.redAccent,
                                child: Center(child: Text('Start Date',style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white
                                ),)),
                              ),
                              onPressed: () {
                                _fSelectStartDate(context);

                              },
                            ),*/
                            IconButton(
                              icon: Icon(
                                Icons.calendar_today,
                                color: Colors.redAccent,
                                size: 16,
                              ),
                              onPressed: () {
                                _fSelectStartDate(context);
                              },
                            ),
                            SizedBox(width: 5,),
                            InkWell(
                              onTap: () {
                                _fSelectStartDate(context);
                              },
                              child: new  Text('Start Date: ${_startFDateController.text}',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            )


                          ],
                        ),
                        Row(
                          children: <Widget>[
                           /* FlatButton(
                              child: Container(
                                height: 40.0,
                                width: 150.0,
                                color: Colors.redAccent,
                                child: Center(child: Text('End Date',style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white
                                ),)),
                              ),
                              onPressed: () {
                                _fSelectEndDate(context);
                              },
                            ),*/
                            IconButton(
                              icon: Icon(
                                Icons.calendar_today,
                                color: Colors.redAccent,
                                size: 16,
                              ),
                              onPressed: () {
                                _fSelectEndDate(context);
                              },
                            ),
                            SizedBox(width: 5,),
                            InkWell(
                              onTap: () {
                                _fSelectEndDate(context);
                              },
                              child: new Text('End Date: ${_endFDateController.text}',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            )

                          ],
                        ),
                        Row(
                          children: <Widget>[
                          /*  FlatButton(
                              child: Container(
                                height: 40.0,
                                width: 150.0,
                                color: Colors.lightGreen,
                                child: Center(child: Text('Start Time',style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white
                                ),)),
                              ),
                              onPressed: () {
                                _fSelectStartTime(context);
                              },
                            ),*/
                            IconButton(
                              icon: Icon(
                                Icons.watch_later,
                                color: Colors.lightGreen,
                                size: 16,
                              ),
                              onPressed: () {
                                _fSelectStartTime(context);
                              },
                            ),
                            SizedBox(width: 5,),
                            InkWell(
                              onTap: () {
                                _fSelectStartTime(context);
                              },
                              child: new  Text('Start Time: ${_startFTimeController.text}',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            )

                          ],
                        ),
                        Row(
                          children: <Widget>[
                            /*FlatButton(
                              child: Container(
                                height: 40.0,
                                width: 150.0,
                                color: Colors.lightGreen,
                                child: Center(child: Text('End Time',style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white
                                ),)),
                              ),
                              onPressed: () {
                                _fSelectEndTime(context);
                              },
                            ),*/
                            IconButton(
                              icon: Icon(
                                Icons.watch_later,
                                color: Colors.lightGreen,
                                size: 16,
                              ),
                              onPressed: () {
                                _fSelectEndTime(context);
                              },
                            ),
                            SizedBox(width: 5,),
                            InkWell(
                              onTap: () {
                                _fSelectEndTime(context);
                              },
                              child: new  Text('End Time: ${_endFTimeController.text}',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            )

                          ],
                        ),
                        fSubmitButton()

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}
