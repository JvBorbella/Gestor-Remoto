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
        // scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
           bodySmall: TextStyle(
              fontFamily: 'Poppins-Medium',
              fontSize: MediaQuery.of(context).size.height * 0.012
            ),
            bodyMedium: TextStyle(
              fontFamily: 'Poppins-Medium',
              fontSize: MediaQuery.of(context).size.height * 0.018
            ),
            bodyLarge: TextStyle(
              fontFamily: 'Poppins-Medium',
              fontSize: MediaQuery.of(context).size.width * 0.025,
            ),
            labelSmall: TextStyle(
              fontFamily: 'Poppins-Medium',
              fontSize: MediaQuery.of(context).size.height * 0.012
            ),
            labelMedium: TextStyle(
              fontFamily: 'Poppins-Medium',
              fontSize: MediaQuery.of(context).size.height * 0.018,
            ),
            labelLarge: TextStyle(
              fontFamily: 'Poppins-Medium',
              fontSize: MediaQuery.of(context).size.height * 0.025,
            ),
            ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      //Tela em que inicia após compilar.
      home: const SplashPage(),
    );
  }
}

void main() => runApp(const MyApp());
