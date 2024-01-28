import 'dart:convert';
import 'package:projeto/Back/Url-Connect.dart';
import 'package:flutter/material.dart';
import 'package:projeto/Front/components/Global/Estructure/navbar.dart';
import 'package:projeto/Front/components/Login_Config/Elements/ButtonConfig.dart';
import 'package:projeto/Front/components/Login_Config/Elements/buttom.dart';
import 'package:projeto/Front/components/Login_Config/Elements/input.dart';
import 'package:projeto/Front/components/Login_Config/Estructure/form-card.dart';
import 'package:projeto/Front/components/Style.dart';
import 'package:projeto/Front/pages/config.dart';
import 'package:projeto/Front/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  final String url;

  const LoginPage({super.key, this.url = ''});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String urlController = '';
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userController.text =
        ''; // Você pode inicializar com um valor padrão se necessário
    _passwordController.text =
        ''; // Você pode inicializar com um valor padrão se necessário
  }

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
                          height: Style.ImageToInputSpace,
                        ),
                        Input(
                          text: 'Usuário',
                          type: TextInputType.text,
                          obscureText: false,
                          controller: _userController,
                          validator: (user) {
                            if (user == null || user.isEmpty) {
                              return 'Por favor, digite sua senha';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: Style.inputSpace,
                        ),
                        Input(
                            text: 'Senha',
                            type: TextInputType.text,
                            obscureText: true,
                            controller: _passwordController,
                            validator: (senha) {
                              if (senha == null || senha.isEmpty) {
                                return 'Por favor, digite sua senha';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: Style.InputToButtonSpace,
                        ),
                        ButtonConfig(
                          text: 'Entrar',
                          onPressed: () async {
                            if (_userController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty) {
                              login();
                            } else {
                              print('Por favor, preencha todos os campos.');
                            }
                          },
                          height: MediaQuery.of(context).size.width * 0.05,
                        ),
                        ButtomInitial(
                          text: 'Configurar',
                          destination: ConfigPage(initialUrl: urlController),
                          height: MediaQuery.of(context).size.width * 0.05,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      var url = Uri.parse(widget.url);
      print('URL recebida: $url');
      print('Username: ${_userController.text}');
      print('Password: ${_passwordController.text}');
      print(widget.url);

      var username = _userController.text;
      var password = _passwordController.text;

      var basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));

      var response = await http.post(
        url,
        headers: {
          'Authorization': basicAuth,
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        await sharedPreferences.setString(
          'token',
          "Token ${jsonDecode(response.body)['token']}",
        );
        print('Token ' + jsonDecode(response.body)['token']);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
      } else {
        print('Credenciais inválidas');
      }
    } catch (e) {
      print('Erro durante a solicitação HTTP: $e');
      print('Detalhes do erro: ${e.toString()}');
    }
  }
}
