import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:projeto/Front/components/Style.dart';
import 'package:projeto/Front/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginFunction {
  static Future<void> login(
    BuildContext context,
    String url,
    TextEditingController userController,
    TextEditingController passwordController,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      var username = userController.text;
      var password = passwordController.text;
      var md5Password = md5.convert(utf8.encode(password)).toString();
      var authorization = Uri.parse('$url/ideia/secure/login?');

      var response = await http.post(
        authorization,
        headers: {
          'auth-user': username,
          'auth-pass': md5Password,
        },
      );

      if (response.statusCode == 200) {
        var token = jsonDecode(response.body)['data']['token'];
        await sharedPreferences.setString(
          'token',
          "Token ${jsonDecode(response.body)['data']['token']}",
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Home(
              url: '$url/ideia/secure',
              urlBasic: url,
              token: token,
            ),
          ),
        );
      } else if (response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              'Sem conexão com o servidor!',
              style: TextStyle(
                fontSize: 13,
                color: Style.tertiaryColor,
              ),
            ),
            backgroundColor: Style.errorColor,
          ),
        );
        print('Url não encontrada');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              'Login inválido',
              style: TextStyle(
                fontSize: 13,
                color: Style.tertiaryColor,
              ),
            ),
            backgroundColor: Style.errorColor,
          ),
        );
        print('Acesso inválido');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Não foi possível iniciar a sessão',
            style: TextStyle(
              fontSize: 13,
              color: Style.tertiaryColor,
            ),
          ),
          backgroundColor: Style.errorColor,
        ),
      );
      print('Erro durante a solicitação HTTP: $e');
    }
  }
}
