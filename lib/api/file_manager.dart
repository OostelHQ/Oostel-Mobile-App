

import 'package:shared_preferences/shared_preferences.dart';

class FileManager
{

  static Future<void> saveAuthDetails(Map<String, String>? auth) async
  {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString("user_rediones_email", auth == null ? "" : auth["email"]!);
    await instance.setString("user_rediones_password", auth == null ? "" : auth["password"]!);
  }

  static Future<Map<String, String>?> loadAuthDetails() async
  {
    SharedPreferences instance = await SharedPreferences.getInstance();
    String? email = instance.getString("user_rediones_email");
    String? password = instance.getString("user_rediones_password");

    if(email == null || password == null || email.isEmpty || password.isEmpty) return null;
    return {
      "email" : email,
      "password" : password
    };
  }

}