import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:projeto/Front/components/Home/Elements/Conteudo-FilialCard.dart';
import 'package:projeto/Front/components/Home/Elements/ModalButtom.dart';
import 'package:projeto/Front/components/Home/Elements/TextButton.dart';
import 'package:projeto/Front/components/Home/Requisitions/Buttons/requisition-button.dart';
import 'package:projeto/Front/components/Global/Estructure/navbar.dart';
import 'package:projeto/Front/components/Home/Requisitions/Elements/number-requisition.dart';
import 'package:projeto/Front/components/Global/Estructure/requisition-card.dart';
import 'package:projeto/Front/components/Home/Requisitions/Elements/text-requisition.dart';
import 'package:projeto/Front/components/Home/Estructure/total-card.dart';
import 'package:projeto/Front/components/Home/Estructure/filial-card.dart';
import 'package:projeto/Front/components/Style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  final token;
  final url;
  const Home({Key? key, this.token, this.url}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    print('Valor de token: ${widget.token}');
    print('Url recebida na Home: ${widget.url}');
    int numberOfRequisitions = NumberOfRequisitions().numberOfRequisitions;
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: ListView(
            children: [
              //Chamando a navbar
              Navbar(
                children: [
                  //Chamando os elementos internos da navbar
                  NavbarButton(),
                ],
                text: 'Página inicial',
              ),
              //Chamando o card que armazenará o total do dia
              TotalCard(),
              //Chamando o card que receberá as solicitações dos usuários
              RequisitionCard(
                children: [
                  Row(
                    //Alinhamento interno
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 2,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              //Chamando os elementos para dentro do card
                              Padding(
                                //Condição para ajustar o posicionamento do texto de acordo com a formatação do número de requisições
                                padding: numberOfRequisitions <= 0
                                    ? EdgeInsets.only(left: 30)
                                    : EdgeInsets.all(0),
                              ),
                              Text(
                                'Requisições',
                                style: TextStyle(
                                    color: Style.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              NumberOfRequisitions(),
                            ],
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: [
                              TextRequisition(),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            //Alinhamento do button
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RequisitionButtom(
                                text: 'Liberação remota',
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
                //Altura do card
                // height: 150,
              ),
              SizedBox(
                height: 10,
              ),
              //Chamando os cards que armazenarão as informações de cada empresa
              FilialCard(
                // height: MediaQuery.of(context).size.width < 600
                //     ? MediaQuery.of(context).size.width * 0.45
                //     : MediaQuery.of(context).size.width * 0.11,
                children: [
                  //Chamando os elementos internos do card
                  Column(
                    children: [
                      TextBUtton(
                        text: '(Empresa)',
                      ),
                      ConteudoFilialCard(),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> dados() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = widget.token;
    var UrlRequisition = Uri.parse(widget.url + '/ideia/secure/monitorvendasempresas/hoje?');
    
    var response = await http.post(
        UrlRequisition,
        headers: {
          'token': token,
        },
      );

      if (response.statusCode == 200) {
         var empresa = jsonDecode(response.body)['data']['empresa_codigo'];
      }    

    // await sharedPreferences.setString(
    //   'token',
    //   "Token ${jsonDecode(response.body)['data']['token']}",
    // );
  }
}
