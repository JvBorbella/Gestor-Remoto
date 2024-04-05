import 'package:flutter/material.dart';
import 'package:projeto/front/pages/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Gestor Remoto",
      theme: ThemeData(
        textTheme: TextTheme(
            bodyText1: TextStyle(
              fontFamily: 'Poppins-Medium',
              fontSize: MediaQuery.of(context).size.width < 720
                  ? MediaQuery.of(context).size.width * 0.038
                  : MediaQuery.of(context).size.width * 0.04,
            ),
            bodyText2: TextStyle(
              fontFamily: 'Poppins-Medium',
              fontSize: MediaQuery.of(context).size.width < 720
                  ? MediaQuery.of(context).size.width * 0.035
                  : MediaQuery.of(context).size.width * 0.04,
            )),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      //Tela em que inicia após compilar.
      home: const SplashPage(),
    );
  }
}

void main() => runApp(const MyApp());
