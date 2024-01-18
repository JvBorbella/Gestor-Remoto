import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:projeto/Front/components/Splash/Elements/Text-Splash.dart';
import 'dart:async';

import 'package:projeto/Front/pages/login.dart';

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

    //Função para adicionar um timer à tela splash
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        //Função executada após o tempo acabar
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //Estilização da tela splash
        decoration: BoxDecoration(
          //Gradiente color usado na tela splash
          gradient: LinearGradient(
            colors: [
              Color(0xff0B4164),
              Color(0xff0476A8),
              Color(0xff009BC0),
              Color(0xff2EB9D3),
            ],
            //Direcionamento do gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
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
                      color: Color(0xffffffff),
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
}
