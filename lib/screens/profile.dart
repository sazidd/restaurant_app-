import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterapptestpush/db/services.dart';
import 'package:flutterapptestpush/model/Users.dart';
import 'package:flutterapptestpush/providers/app_provider.dart';
import 'package:flutterapptestpush/screens/join.dart';
import 'package:flutterapptestpush/screens/splash.dart';
import 'package:flutterapptestpush/util/const.dart';
import 'package:flutterapptestpush/util/usershareperf.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

String userId;
Users users;
var isLoading = false;

  @override
  void initState() {


    UserShareFrence.getStringUserID().then((value) {
      print('value......... ${value}');
      setState(() {
        userId=value;
        //_getUserInfo(userId);
      });
    });
    super.initState();
  }


/*Future<Users>_getUserInfo(String userId) {

    Services.getUserInfo(userId)
        .then((result) {

     return result;
    });

  }*/

  _logout(){

    UserShareFrence.removeStringUserEmailID().then((onValue){
      print('remove value.. ${onValue}');
    });

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context){
          return SplashScreen();
        },
      ),
    );
  }

  _login(){
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context){
            return JoinApp();
          },
        ),
      );
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),

        child:FutureBuilder(
          future:  Services.getUserInfo(userId),
          builder: (BuildContext context, AsyncSnapshot<Users> response) {
            if(response.data !=null){


              return ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Image.asset(
                          "assets/human_blank.png",
                          fit: BoxFit.cover,
                          width: 100.0,
                          height: 100.0,
                        ),
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                  Text(
                                    response.data.firstname,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 5.0),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                               Text(
                                 response.data.email,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                InkWell(
                                  onTap: (){
                                    _logout();
                                  },
                                  child: Text("Logout",
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).accentColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                        flex: 3,
                      ),
                    ],
                  ),

                  Divider(),
                  Container(height: 15.0),

                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "Account Information".toUpperCase(),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  ListTile(
                    title: Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    subtitle: Text(
                      response.data.firstname,
                    ),

                    trailing: IconButton(
                      icon: Icon(
                        Icons.edit,
                        size: 20.0,
                      ),
                      onPressed: (){
                      },
                      tooltip: "Edit",
                    ),
                  ),

                  ListTile(
                    title: Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    subtitle: Text(
                      response.data.email,
                    ),
                  ),

                  ListTile(
                    title: Text(
                      "Phone",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    subtitle: Text(
                      response.data.phone,
                    ),
                  ),

                  ListTile(
                    title: Text(
                      "Address",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    subtitle: Text(
                      response.data.address,
                    ),
                  ),



                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? SizedBox()
                      : ListTile(
                    title: Text(
                      "Dark Theme",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    trailing: Switch(
                      value: Provider.of<AppProvider>(context).theme == Constants.lightTheme
                          ? false
                          : true,
                      onChanged: (v) async{
                        if (v) {
                          Provider.of<AppProvider>(context, listen: false)
                              .setTheme(Constants.darkTheme, "dark");
                        } else {
                          Provider.of<AppProvider>(context, listen: false)
                              .setTheme(Constants.lightTheme, "light");
                        }
                      },
                      activeColor: Theme.of(context).accentColor,
                    ),
                  ),
                ],
              );

            }else{
              return ListView(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Image.asset(
                          "assets/human_blank.png",
                          fit: BoxFit.cover,
                          width: 100.0,
                          height: 100.0,
                        ),
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Name",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 5.0),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Email",
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                InkWell(
                                  onTap: (){
                                   _login();
                                  },
                                  child: Text("Login",
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).accentColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                        flex: 3,
                      ),
                    ],
                  ),

                  Divider(),
                  Container(height: 15.0),

                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "Account Information".toUpperCase(),
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  ListTile(
                    title: Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    subtitle: Text(
                     "",
                    ),

                    trailing: IconButton(
                      icon: Icon(
                        Icons.edit,
                        size: 20.0,
                      ),
                      onPressed: (){
                      },
                      tooltip: "Edit",
                    ),
                  ),

                  ListTile(
                    title: Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    subtitle: Text(
                      "",
                    ),
                  ),

                  ListTile(
                    title: Text(
                      "Phone",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    subtitle: Text(
                      "",
                    ),
                  ),

                  ListTile(
                    title: Text(
                      "Address",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    subtitle: Text(
                     "",
                    ),
                  ),



                  MediaQuery.of(context).platformBrightness == Brightness.dark
                      ? SizedBox()
                      : ListTile(
                    title: Text(
                      "Dark Theme",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    trailing: Switch(
                      value: Provider.of<AppProvider>(context).theme == Constants.lightTheme
                          ? false
                          : true,
                      onChanged: (v) async{
                        if (v) {
                          Provider.of<AppProvider>(context, listen: false)
                              .setTheme(Constants.darkTheme, "dark");
                        } else {
                          Provider.of<AppProvider>(context, listen: false)
                              .setTheme(Constants.lightTheme, "light");
                        }
                      },
                      activeColor: Theme.of(context).accentColor,
                    ),
                  ),
                ],
              );
            }

          }
        )
      ),
    );
  }
}
