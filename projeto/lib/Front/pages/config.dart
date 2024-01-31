import 'package:flutter/material.dart';
import 'package:projeto/Front/components/Global/Estructure/navbar.dart';
import 'package:projeto/Front/components/Login_Config/Elements/ButtonConfig.dart';
import 'package:projeto/Front/components/Login_Config/Elements/input.dart';
import 'package:projeto/Front/components/Login_Config/Estructure/form-card.dart';
import 'package:projeto/Front/components/Style.dart';
import 'package:projeto/Front/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigPage extends StatefulWidget {
  final String initialUrl;

  const ConfigPage({super.key, this.initialUrl = ''});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  TextEditingController urlController = TextEditingController();

  Future<String> _getUrl() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('saveUrl') ?? '';
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
                //Chamando elementos dentro da navbar
              ], text: 'Configurações'),
              //Conteúdo da página abaixo da navbar
              Expanded(
                child: Column(
                  //Alinhamento
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Chamando o form Container
                    FormCard(
                      children: [
                        SizedBox(
                          height: Style.ImageToInputSpace,
                        ),
                        //Chamando elementos para dentro do container
                        FutureBuilder<String>(
                          future: _getUrl(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              // Configurando o valor inicial do controlador
                              urlController.text = snapshot.data ?? '';

                              return Input(
                                type: TextInputType.text,
                                text: 'Configuração de IP',
                                obscureText: false,
                                controller: urlController,
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                        SizedBox(
                          height: Style.InputToButtonSpace,
                        ),
                        Column(
                          children: [
                            Row(
                              //Alinhamento dos buttons
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //Chamando os button
                                ButtonConfig(
                                  text: 'Salvar',
                                  onPressed: () {
                                    _saveUrl(urlController.text);
                                  },
                                  height:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),

                                SizedBox(
                                  width: Style.ButtonSpace,
                                ),
                                ButtonConfig(
                                    text: 'Voltar',
                                    onPressed: () async {
                                      String url = urlController.text;
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              LoginPage(url: url),
                                        ),
                                      );
                                    },
                                    height: MediaQuery.of(context).size.width *
                                        0.05),
                              ],
                            ),
                          ],
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

  void _saveUrl(String url) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('saveUrl', urlController.text).then((response) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Ip salvo com sucesso!',
            style: TextStyle(
              fontSize: 13,
              color: Style.tertiaryColor,
            ),
          ),
          backgroundColor: Style.sucefullColor,
        ),
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => LoginPage(url: urlController.text),
        ),
      );
      print(response);
    });
  }
}
