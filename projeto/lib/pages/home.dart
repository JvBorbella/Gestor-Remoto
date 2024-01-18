import 'package:flutter/material.dart';
import 'package:projeto/components/Home/Elements/Conteudo-FilialCard.dart';
import 'package:projeto/components/Home/Elements/ModalButtom.dart';
import 'package:projeto/components/Home/Elements/TextButton.dart';
import 'package:projeto/components/Home/Requisitions/Buttons/requisition-button.dart';
import 'package:projeto/components/Global/Estructure/navbar.dart';
import 'package:projeto/components/Home/Requisitions/Elements/number-requisition.dart';
import 'package:projeto/components/Global/Estructure/requisition-card.dart';
import 'package:projeto/components/Home/Requisitions/Elements/text-requisition.dart';
import 'package:projeto/components/Home/Estructure/total-card.dart';
import 'package:projeto/components/Home/Estructure/filial-card.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    int numberOfRequisitions = NumberOfRequisitions().numberOfRequisitions;
    return Scaffold(
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
                                  color: Color(0xff00568E),
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
            FilialCard(
              // height: MediaQuery.of(context).size.width < 600
              //     ? MediaQuery.of(context).size.width * 0.45
              //     : MediaQuery.of(context).size.width * 0.11,
              children: [
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
            FilialCard(
              // height: MediaQuery.of(context).size.width < 600
              //     ? MediaQuery.of(context).size.width * 0.45
              //     : MediaQuery.of(context).size.width * 0.11,
              children: [
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
            FilialCard(
              // height: MediaQuery.of(context).size.width < 600
              //     ? MediaQuery.of(context).size.width * 0.45
              //     : MediaQuery.of(context).size.width * 0.11,
              children: [
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
          ],
        ),
      ),
    );
  }
}
