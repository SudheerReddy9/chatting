import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{
  // keys
  static String userLoggedInKey = "LOOGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";






  // saving data to SF

static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
  SharedPreferences sf = await SharedPreferences.getInstance();
  return sf.setBool(userLoggedInKey, isUserLoggedIn);
}

  static Future<bool> saveUserNameStatus(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(userNameKey, userName);
  }
  static Future<bool> saveUserEmailStatus(String userEmail) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(userEmailKey, userEmail);
  }


  // getting data from SF

static Future<bool?> getUserLoggedInStatus() async{
  SharedPreferences sf = await SharedPreferences.getInstance();
  return sf.getBool(userLoggedInKey);
}

  static Future<String?> getUserNameStatus() async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey);
  }

  static Future<String?> getUserEmailStatus() async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }




}