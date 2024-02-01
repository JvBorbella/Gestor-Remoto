import 'package:flutter/material.dart';
import 'package:projeto/Front/components/Style.dart';
import 'package:projeto/Front/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveUrl extends StatefulWidget {
  const SaveUrl({Key? key}) : super(key: key);

  @override
  State<SaveUrl> createState() => _SaveUrlState();
}

class _SaveUrlState extends State<SaveUrl> {
  TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material();
  }

  void SaveUrl(String url) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('saveUrl', urlController.text).then((response) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Ip salvo com sucesso!',
            style: TextStyle(
              fontSize: 13,
              color: Style.tertiaryColor,
            ),
          ),
          backgroundColor: Style.sucefullColor,
        ),
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoginPage(url: urlController.text),
        ),
      );
      print(response);
    });
  }
}
