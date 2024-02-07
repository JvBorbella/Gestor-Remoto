import 'package:flutter/material.dart';
import 'package:projeto/Back/Today-Data.dart';
import 'package:projeto/Back/Value-Day.dart';
import 'package:projeto/Back/Yesterday-Data.dart';
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
  List<MonitorVendasEmpresaHoje> empresasHoje = [];
  List<MonitorVendasEmpresaOntem> empresasOntem = [];
  late double vendadia = 0.0;
  late int solicitacoesremotas = -1; // Valor padrão indicando que os dados ainda não foram carregados
 // Valor padrão de carregamento
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
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
        body: ListView(
          children: [
            Navbar(
              children: [
                NavbarButton(),
              ],
              text: 'Página inicial',
            ),
            TotalCard(vendadia: vendadia),
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
                              padding: solicitacoesremotas <= 0
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
                            NumberOfRequisitions(solicitacoesremotas: solicitacoesremotas),
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            TextRequisition(solicitacoesremotas: solicitacoesremotas,),
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
                              solicitacoesremotas: solicitacoesremotas,
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
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: empresasHoje.length,
              itemBuilder: (context, index) {
                // Verifica se empresasOntem possui elementos antes de acessá-los
                if (index < empresasOntem.length) {
                  return Column(
                    children: [
                      FilialCard(
                        children: [
                          Column(
                            children: [
                              TextBUtton(
                                text: empresasHoje[index].empresaNome,
                              ),
                              ConteudoFilialCard(
                                valorHoje: empresasHoje[index].valorHoje,
                                valorOntem: empresasOntem[index].valorOntem,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  // Trate o caso em que não há dados em empresasOntem para este índice
                  return Text(
                      'Dados de ontem não encontrados para esta empresa.');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loadData() async {
    // Utiliza Future.wait para buscar os dados de forma paralela
    await Future.wait([
      fetchData(),
      fetchDataOntem(),
      fetchDataValorHoje(),
    ]);
    // Todos os dados foram carregados, agora atualiza o estado para parar o carregamento
   setState(() {
  isLoading = false;
  // Verifica se os dados de solicitacoesremotas foram carregados corretamente
  if (solicitacoesremotas != -1) {
    solicitacoesremotas = NumberOfRequisitions(solicitacoesremotas: solicitacoesremotas).solicitacoesremotas;
    print(solicitacoesremotas);
  }
});

  }

  Future<void> fetchData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<MonitorVendasEmpresaHoje>? fetchedData =
        await DataService.fetchData(widget.token, widget.url);

    if (fetchedData != null) {
      setState(() {
        empresasHoje = fetchedData;
      });
    }
  }

  Future<void> fetchDataOntem() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<MonitorVendasEmpresaOntem>? fetchedDataOntem =
        await DataServiceOntem.fetchDataOntem(widget.token, widget.url);

    if (fetchedDataOntem != null) {
      setState(() {
        empresasOntem = fetchedDataOntem;
      });
    }
  }

  Future<void> fetchDataValorHoje() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    double? fetchedDataValorHoje =
        await DataServiceValorHoje.fetchDataValorHoje(widget.token, widget.url);

    if (fetchedDataValorHoje != null) {
      setState(() {
        vendadia = fetchedDataValorHoje;
      });
    }
  }
}
