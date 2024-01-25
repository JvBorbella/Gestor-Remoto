import 'package:flutter/material.dart';
import 'package:projeto/Back/Token-Verification.dart';
import 'package:projeto/Front/components/Splash/Elements/Text-Splash.dart';
import 'package:projeto/Front/components/Style.dart';
import 'package:projeto/Front/pages/home.dart';
import 'dart:async';
import 'package:projeto/Front/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  //Função para iniciar o timer quando o widget for carregado
  void initState() {
    super.initState();
    verificarToken().then((value) {
      if (value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage())
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //Estilização da tela splash
        decoration: BoxDecoration(
            //Gradiente color usado na tela splash
            gradient: Style.gradient),
        //Conteúdo da tela
        child: Row(
          //Alinhamentos
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Image.network(
                      'https://ideiatecnologia.com.br/wp-content/webp-express/webp-images/uploads/2023/11/imagem_2023-11-13_202733151.png.webp',
                      color: Style.tertiaryColor,
                      height: 90,
                    ),
                  ],
                ),
                Row(
                  //Chamando a animação do texto abaixo da imagem
                  children: [
                    AnimatedTextMove(
                      text: 'Gestor Remoto',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Future<bool> verificarToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('token') != null) {
      return true;
    } else {
      return false;
    }
  }
}
