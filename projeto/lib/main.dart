import 'package:flutter/material.dart';
import 'package:projeto/Front/pages/splash.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Gestor Remoto",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        primaryColor: Color(0xff00568e),
        secondaryHeaderColor: Color(0xff42b9f0),
        primaryColorLight: Color(0xfffffffff),
        primaryColorDark: Color(0xffA6A6A6),        
      ),
      //Tela em que inicia após compilar.
      home: const Splash(),
    );
  }
}
void main() => runApp(const MyApp());