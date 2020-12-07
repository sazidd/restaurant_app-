import 'package:flutter/material.dart';
import 'package:flutterapptestpush/util/usershareperf.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutterapptestpush/db/services.dart';



class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameControl = new TextEditingController();
  final TextEditingController _addressControl = new TextEditingController();
  final TextEditingController _phoneControl = new TextEditingController();
  final TextEditingController _emailControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();

  String UserToken;

  _addRegistration(String usernameControl,String addressControl,String phoneControl,String emailControl,String passwordControl) {

    if(["", null, false, 0].contains(usernameControl) || ["", null, false, 0].contains(addressControl) || ["", null, false, 0].contains(phoneControl) || ["", null, false, 0].contains(emailControl) || ["", null, false, 0].contains(passwordControl)){

      print("user name and address and phone and email and password empty");
      _ackAlertValidation(context);
      return;
    }

    UserShareFrence.getStringUserToken().then((value) {
      UserToken=value;
      print('value......... ${value}');
    });
   // _showProgress('Updating Employee...');
    Services.addRegistration(usernameControl,addressControl,phoneControl, emailControl, passwordControl,UserToken).then((result) {
      print('up data ${usernameControl} ${emailControl} ${passwordControl}');
      if ('success' == result) {
      //  _getEmployees(); // Refresh the list after update
        print('up data33 ${result}');
        _ackAlert(context);
      }
    });
  }

  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registation Success'),
          content: const Text('Registation has been successed'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _ackAlertValidation(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registation Error'),
          content: const Text("User Name and Address and Phone and Email and Password Empty"),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0,0,20,0),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[

          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: 25.0,
            ),
            child: Text(
              "Create an account",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),

          SizedBox(height: 30.0),

          Card(
            elevation: 3.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Colors.white,),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Username",
                  prefixIcon: Icon(
                    Icons.perm_identity,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: _usernameControl,
              ),
            ),
          ),

          SizedBox(height: 10.0),

          Card(
            elevation: 3.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Colors.white,),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Address",
                  prefixIcon: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: _addressControl,
              ),
            ),
          ),

          SizedBox(height: 10.0),

          Card(
            elevation: 3.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Colors.white,),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Phone",
                  prefixIcon: Icon(
                    Icons.phone,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: _phoneControl,
              ),
            ),
          ),

          SizedBox(height: 10.0),

          //........
          Card(
            elevation: 3.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Colors.white,),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Email",
                  prefixIcon: Icon(
                    Icons.mail_outline,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                maxLines: 1,
                controller: _emailControl,
              ),
            ),
          ),

          SizedBox(height: 10.0),

          Card(
            elevation: 3.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(color: Colors.white,),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white,),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "Password",
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                ),
                obscureText: true,
                maxLines: 1,
                controller: _passwordControl,
              ),
            ),
          ),


          SizedBox(height: 40.0),

          Container(
            height: 50.0,
            child: RaisedButton(
              child: Text(
                "Register".toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: (){
               /* Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context){
                      return MainScreen();
                    },
                  ),
                );*/

                _addRegistration(_usernameControl.text.toString(),
                    _addressControl.text.toString(),
                    _phoneControl.text.toString(),
                    _emailControl.text.toString(),
                    _passwordControl.text.toString());
              },
              color: Theme.of(context).accentColor,
            ),
          ),

          SizedBox(height: 10.0),
          Divider(color: Theme.of(context).accentColor,),
          SizedBox(height: 10.0),


          Center(
            child: Container(
              width: MediaQuery.of(context).size.width/2,
              child: Row(
                children: <Widget>[
                  RawMaterialButton(
                    onPressed: (){},
                    fillColor: Colors.blue[800],
                    shape: CircleBorder(),
                    elevation: 4.0,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Icon(
                        FontAwesomeIcons.facebookF,
                        color: Colors.white,
//              size: 24.0,
                      ),
                    ),
                  ),

                  RawMaterialButton(
                    onPressed: () {

                    },
                    fillColor: Colors.white,
                    shape: CircleBorder(),
                    elevation: 4.0,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Icon(
                        FontAwesomeIcons.google,
                        color: Colors.blue[800],
//              size: 24.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20.0),


        ],
      ),
    );
  }
}
