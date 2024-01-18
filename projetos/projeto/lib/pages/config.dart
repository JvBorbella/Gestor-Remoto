import 'package:flutter/material.dart';
import 'package:projeto/components/Global/Estructure/navbar.dart';
import 'package:projeto/components/Login_Config/Elements/buttom.dart';
import 'package:projeto/components/Login_Config/Elements/input.dart';
import 'package:projeto/components/Login_Config/Estructure/form-card.dart';
import 'package:projeto/pages/login.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              ButtomInitial(
                                text: 'Salvar',
                                destination: LoginPage(),
                                height: MediaQuery.of(context).size.width * 0.05
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              ButtomInitial(
                                text: 'Cancelar',
                                destination: LoginPage(),
                                height: MediaQuery.of(context).size.width * 0.05
                              ),
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
    );
  }
}
