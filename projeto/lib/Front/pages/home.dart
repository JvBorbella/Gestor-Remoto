import 'package:flutter/material.dart';
import 'package:projeto/Back/Data.dart';
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
  final String url;
  const Home({Key? key, this.token, this.url = ''}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String urlController = '';
  late String empresa;
  bool isLoading = true;
  int numberOfRequisitions = NumberOfRequisitions().numberOfRequisitions;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: ListView(
            children: [
              Navbar(
                children: [
                  NavbarButton(),
                ],
                text: 'Página inicial',
              ),
              TotalCard(),
              RequisitionCard(
                children: [
                  Row(
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
                              Padding(
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
              ),
              SizedBox(
                height: 10,
              ),
              FilialCard(
                children: [
                  Column(
                    children: [
                      TextBUtton(
                        text: empresa,
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

  Future<void> fetchData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    String? fetchedData = await DataService.fetchData(widget.token, widget.url);

    if (fetchedData != null) {
      setState(() {
        empresa = fetchedData;
        isLoading = false; // Marcamos como carregado
      });
      print('Código da empresa: $empresa');
    }

    print('Valor da variável empresa: $empresa');
  }
}
