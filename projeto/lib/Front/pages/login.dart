import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projeto/Back/SaveUser.dart';
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
import 'package:crypto/crypto.dart';

class LoginPage extends StatefulWidget {
  final String url;

  const LoginPage({
    super.key,
    this.url = '',
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String urlController = '';
  final SaveUserService saveUserService = SaveUserService();
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userController.text = '';
    _passwordController.text = '';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadSavedUser();
  }

  Future<void> _loadSavedUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedUser = await sharedPreferences.getString('saveUser') ?? '';
    setState(() {
      _userController.text = savedUser;
    });
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
                            }),
                        SizedBox(
                          height: Style.InputToButtonSpace,
                        ),
                        ButtonConfig(
                          text: 'Entrar',
                          onPressed: () async {
                            if (_userController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty) {
                              saveUserService.saveUser(
                                  context, _userController.text);
                              login();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  content: Text(
                                    'Por favor, preencha todos os campos',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Style.tertiaryColor,
                                    ),
                                  ),
                                  backgroundColor: Style.errorColor,
                                ),
                              );
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
      var username = _userController.text;
      var password = _passwordController.text;
      var md5Password = md5.convert(utf8.encode(password)).toString();
      var authorization = Uri.parse(widget.url + '/ideia/secure/login?');

      // print('URL recebida da ConfigPage: $url');
      // print('Username: ${_userController.text}');
      // print('Password: ${_passwordController.text}');

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
        // print(response.body);
        print('Token ' + jsonDecode(response.body)['data']['token']);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Home(
              url: widget.url + '/ideia/secure',
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
