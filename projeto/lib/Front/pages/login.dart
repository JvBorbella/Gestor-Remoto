import 'package:flutter/material.dart';
import 'package:projeto/Front/components/Global/Estructure/navbar.dart';
import 'package:projeto/Front/components/Login_Config/Elements/buttom.dart';
import 'package:projeto/Front/components/Login_Config/Elements/input.dart';
import 'package:projeto/Front/components/Login_Config/Estructure/form-card.dart';
import 'package:projeto/Front/pages/config.dart';
import 'package:projeto/Front/pages/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              //Chamando a navbar
              Navbar(children: [
                //Chamando os elementos internos da navbar
              ], text: 'Login'),
              //expanded para preencher o espaço de tela completo abaixo da navbar
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Chamando o container com os elementos para login
                  FormCard(
                    children: [
                      SizedBox(
                        height: 35,
                      ),
                      Input(
                        text: 'Email',
                        type: TextInputType.emailAddress,
                        obscureText: false,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Input(
                        text: 'Senha',
                        type: TextInputType.text,
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      ButtomInitial(
                        text: 'Entrar',
                        destination: Home(),
                        height: MediaQuery.of(context).size.width * 0.05,
                      ),
                      ButtomInitial(
                        text: 'Configurar',
                        destination: ConfigPage(),
                        height: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ],
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
