import 'package:shared_preferences/shared_preferences.dart';

class UserShareFrence {


 static Future<String> getStringUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("UserEmail33");
    String userEmail=prefs.getString('UserEmail');
   return userEmail;

  }
 static addStringUserEmail(String UserEmail ,String UserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("UserEmail22");
    prefs.setString('UserEmail',UserEmail);
    prefs.setString("UserId", UserId);
  }

 static Future<String> removeStringUserEmailID() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   print("removeUserEmailID....");
   prefs.remove('UserEmail');
   prefs.remove("UserId");
   return "success";
 }

 static Future<String> getStringUserID() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String UserId= prefs.getString('UserId');
   print("UserId .. ${UserId}");
   return UserId;
 }

static Future<int> getStringAppReview() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   int appReview= prefs.getInt('appReview7');
   print("appReview 22${appReview}");
   return appReview;
 }
 static addStringAppReview() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   print("appReview22");
   prefs.setInt('appReview7',123);
 }


 static Future<String> getStringUserToken() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String userToken= prefs.getString('userToken');
   print("userToken 22${userToken}");
   return userToken;
 }

 static addStringUserToken(String userToken) async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   print("$userToken");
   prefs.setString('userToken',userToken);
 }
}