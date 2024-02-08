import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveUserService {
  Future<void> saveUser(BuildContext context, String username) async {
    if (username.isNotEmpty) {
      try {
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.setString('saveUser', username);
      } catch (e) {

      }
    } else {
      print('Username is null or empty. Not saving.');
    }
  }

  void listenAndSaveUser(BuildContext context, TextEditingController controller) {
    controller.addListener(() {
      saveUser(context, controller.text);
    });
  }
}
