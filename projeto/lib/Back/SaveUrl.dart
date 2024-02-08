import 'package:flutter/material.dart';
import 'package:projeto/Front/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveUrlService {
  Future<void> saveUrl(BuildContext context, String url) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('saveUrl', url).then((response) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Ip salvo com sucesso!',
            style: TextStyle(
              fontSize: 13,
              // Adicione as cores ou estilos necessários
            ),
          ),
          backgroundColor: Colors.green, // Adicione a cor desejada
        ),
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoginPage(url: url),
        ),
      );
    });
  }
}
