import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveUserService {
  Future<void> saveUser(BuildContext context, String username) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('saveUser', username).then((response) {
      print(response);
    });
  }
}
