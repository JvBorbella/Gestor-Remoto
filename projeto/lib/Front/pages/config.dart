import 'package:flutter/material.dart';
import 'package:projeto/Back/Url-Connect.dart';
import 'package:projeto/Front/components/Global/Estructure/navbar.dart';
import 'package:projeto/Front/components/Login_Config/Elements/buttom.dart';
import 'package:projeto/Front/components/Login_Config/Elements/input.dart';
import 'package:projeto/Front/components/Login_Config/Estructure/form-card.dart';
import 'package:projeto/Front/pages/login.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController urlController = TextEditingController();
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
                          height: 15,
                        ),
                        //Chamando elementos para dentro do container
                        Input(
                          type: TextInputType.text,
                          text: 'Configuração de IP',
                          obscureText: false,
                          controller: urlController,
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Column(
                          children: [
                            Row(
                              //Alinhamento dos buttons
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //Chamando os button
                                TextButton(
                                  child: Text('Salvar'),
                                  onPressed: () {
                                    String url = urlController.text;
                                    ApiService.fetchData(url).then((response) {
                                      // Faça algo com a resposta (exibição na tela, etc.)
                                      if (response == 200) {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()),
                                        );
                                      };
                                    }).catchError((error) {
                                      // Trate erros (exibição de mensagem de erro, etc.)
                                      print(error);
                                    });
                                  },
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                ButtomInitial(
                                    text: 'Cancelar',
                                    destination: LoginPage(),
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
}