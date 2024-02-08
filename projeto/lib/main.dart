import 'package:flutter/material.dart';
import 'package:projeto/Front/pages/splash.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // void initState() {
  //   _loadSavedUrl();
  // }

  // Future<void> _loadSavedUrl() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String savedUrl = sharedPreferences.getString('saveUrl') ?? '';
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Gestor Remoto",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      //Tela em que inicia após compilar.
      home: const Splash(),
    );
  }
}

void main() => runApp(const MyApp());
