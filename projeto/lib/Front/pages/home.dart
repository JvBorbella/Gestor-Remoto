import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/back/company_sales_monitor.dart';
import 'package:projeto/back/total_values.dart';
import 'package:projeto/front/components/global/structure/navbar.dart';
import 'package:projeto/front/components/global/structure/request_card.dart';

import 'package:projeto/front/components/home/elements/filial_card_content.dart';
import 'package:projeto/front/components/home/elements/modal_button.dart';
import 'package:projeto/front/components/home/elements/text_button.dart';
import 'package:projeto/front/components/home/structure/filial_card.dart';
import 'package:projeto/front/components/home/structure/total_values_card.dart';
import 'package:projeto/front/components/request_home/elements/request_button.dart';
import 'package:projeto/front/components/request_home/elements/request_number.dart';
import 'package:projeto/front/components/request_home/structure/request_card_text.dart';
import 'package:projeto/front/components/style.dart';

class Home extends StatefulWidget {
  final token;
  final String url;
  final String urlBasic;

  const Home({
    Key? key,
    this.token,
    this.url = '',
    this.urlBasic = '',
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String urlController = '';
  List<MonitorVendasEmpresa> empresasHoje = [];
  List<MonitorVendasEmpresa> empresasOntem = [];
  List<MonitorVendasEmpresa> empresasSemana = [];
  List<MonitorVendasEmpresa> empresasMes = [];
  List<MonitorVendasEmpresa> empresasMesAnt = [];
  late double vendadia = 0.0;
  late double vendadiaanterior = 0.0;
  late double vendasemana = 0.0;
  late double vendames = 0.0;
  // late int ticketHoje = -1;
  // late int ticketOntem = -1;
  late int solicitacoesremotas = -1;
  // Valor padrão de carregamento
  bool isLoading = true;
  NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  void initState() {
    super.initState();
    loadData();
    fetchDataSemana();
    fetchDataMes();
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
        drawer: Drawer(
          width: 250,
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    UserAccountsDrawerHeader(
                        accountName: Text('Teste'),
                        accountEmail: Text('Teste')),
                    NavbarButton()
                  ],
                ),
              ),
              ListTile(),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => _refreshData(),
          child: ListView(
            children: [
              Navbar(
                children: [
                  // DrawerButton(
                  //   style: ButtonStyle(
                  //     iconColor: MaterialStatePropertyAll(Style.tertiaryColor),
                  //   ),
                  // ),
                  NavbarButton(),
                ],
                text: 'Página inicial',
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Total de hoje',
                              style: TextStyle(
                                color: Style.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            TotalCard(
                              text: '',
                              children: vendadia,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Total de ontem',
                              style: TextStyle(
                                color: Style.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            TotalCard(
                              text: '',
                              children: vendadiaanterior,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Total da semana',
                              style: TextStyle(
                                color: Style.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            TotalCard(
                              text: '',
                              children: vendasemana,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Total do mês',
                              style: TextStyle(
                                color: Style.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            TotalCard(
                              text: '',
                              children: vendames,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
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
                              NumberOfRequisitions(
                                  solicitacoesremotas: solicitacoesremotas),
                            ],
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: [
                              TextRequisition(
                                solicitacoesremotas: solicitacoesremotas,
                              ),
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
                                url: widget.url,
                                token: widget.token,
                                urlBasic: widget.urlBasic,
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
                                if (empresasSemana.isNotEmpty &&
                                    empresasMes.isNotEmpty)
                                  TextBUtton(
                                    url: widget.url,
                                    token: widget.token,
                                    empresasHoje: empresasHoje,
                                    empresasOntem: empresasOntem,
                                    empresasSemana: empresasSemana,
                                    empresasMes: empresasMes,
                                    empresasMesAnt: empresasMesAnt,
                                    empresaNome:empresasHoje[index].empresaNome,
                                    
                                  )
                                else
                                  TextBUtton(
                                    url: widget.url,
                                    token: widget.token,
                                    empresasHoje: empresasHoje,
                                    empresasOntem: empresasOntem,
                                    empresasSemana: empresasSemana,
                                    empresasMes: empresasMes,
                                    empresasMesAnt: empresasMesAnt,
                                    empresaNome:
                                        empresasHoje[index].empresaNome,
                                    
                                  ),
                                if (empresasSemana.isNotEmpty &&
                                    empresasMes.isNotEmpty)
                                  ConteudoFilialCard(
                                    valorHoje: empresasHoje[index].valortotal,
                                    valorOntem: empresasOntem[index].valortotal,
                                    valorSemana:
                                        empresasSemana[index].valortotal,
                                    valorMes: empresasMes[index].valortotal,
                                  )
                                else
                                  ConteudoFilialCard(
                                    valorHoje: empresasHoje[index].valortotal,
                                    valorOntem: empresasOntem[index].valortotal,
                                    valorSemana: 0,
                                    valorMes: 0,
                                  )
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        FilialCard(
                          children: [
                            Column(
                              children: [
                                if (empresasSemana.isNotEmpty &&
                                    empresasMes.isNotEmpty)
                                  TextBUtton(
                                    url: widget.url,
                                    empresasHoje: empresasHoje,
                                    empresasOntem: empresasOntem,
                                    empresasSemana: empresasSemana,
                                    empresasMes: empresasMes,
                                    empresasMesAnt: empresasMesAnt,
                                    token: widget.token,
                                    empresaNome:
                                        empresasHoje[index].empresaNome,
                                   
                                  )
                                else
                                  TextBUtton(
                                    url: widget.url,
                                    token: widget.token,
                                    empresasHoje: empresasHoje,
                                    empresasOntem: empresasOntem,
                                    empresasSemana: empresasSemana,
                                    empresasMes: empresasMes,
                                    empresasMesAnt: empresasMesAnt,
                                    empresaNome:
                                        empresasHoje[index].empresaNome,
                                    
                                  ),
                                if (empresasSemana.isNotEmpty &&
                                    empresasMes.isNotEmpty)
                                  ConteudoFilialCard(
                                    valorHoje: empresasHoje[index].valortotal,
                                    valorOntem: 0,
                                    valorSemana:
                                        empresasSemana[index].valortotal,
                                    valorMes: empresasMes[index].valortotal,
                                  )
                                else
                                  ConteudoFilialCard(
                                    valorHoje: empresasHoje[index].valortotal,
                                    valorOntem: 0,
                                    valorSemana: 0,
                                    valorMes: 0,
                                  )
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                },
              ),
              if (empresasHoje.isEmpty)
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: empresasOntem.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          FilialCard(
                            children: [
                              Column(
                                children: [
                                  TextBUtton(
                                    url: widget.url,
                                    empresasHoje: empresasHoje,
                                    empresasOntem: empresasOntem,
                                    empresasSemana: empresasSemana,
                                    empresasMes: empresasMes,
                                    empresasMesAnt: empresasMesAnt,
                                    token: widget.token,
                                    empresaNome:
                                        empresasOntem[index].empresaNome,
                                    
                                  ),
                                  ConteudoFilialCard(
                                    valorHoje: 0,
                                    valorOntem: empresasOntem[index].valortotal,
                                    valorSemana:
                                        empresasSemana[index].valortotal,
                                    valorMes: empresasMes[index].valortotal,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
              if (empresasHoje.isEmpty && empresasOntem.isEmpty)
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: empresasSemana.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          FilialCard(
                            children: [
                              Column(
                                children: [
                                  TextBUtton(
                                    url: widget.url,
                                    token: widget.token,
                                    empresasHoje: empresasHoje,
                                    empresasOntem: empresasOntem,
                                    empresasSemana: empresasSemana,
                                    empresasMes: empresasMes,
                                    empresasMesAnt: empresasMesAnt,
                                    empresaNome:
                                        empresasHoje[index].empresaNome,
                                   
                                  ),
                                  ConteudoFilialCard(
                                    valorHoje: 0,
                                    valorOntem: 0,
                                    valorSemana:
                                        empresasSemana[index].valortotal,
                                    valorMes: empresasMes[index].valortotal,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
              if (empresasHoje.isEmpty &&
                  empresasOntem.isEmpty &&
                  empresasSemana.isEmpty)
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: empresasMes.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          FilialCard(
                            children: [
                              Column(
                                children: [
                                  TextBUtton(
                                    url: widget.url,
                                    token: widget.token,
                                    empresasHoje: empresasHoje,
                                    empresasOntem: empresasOntem,
                                    empresasSemana: empresasSemana,
                                    empresasMes: empresasMes,
                                    empresasMesAnt: empresasMesAnt,
                                    empresaNome: empresasMes[index].empresaNome,
                                   
                                  ),
                                  ConteudoFilialCard(
                                    valorHoje: 0,
                                    valorOntem: 0,
                                    valorSemana: 0,
                                    valorMes: empresasMes[index].valortotal,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
              if (empresasHoje.isEmpty &&
                  empresasOntem.isEmpty &&
                  empresasMes.isEmpty &&
                  empresasSemana.isEmpty)
                Center(
                  child: Text('Não há dados de vendas'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadData() async {
    // Utiliza Future.wait para buscar os dados de forma paralela
    await Future.wait([
      fetchData(),
      fetchDataOntem(),
      fetchedDataMonitorVendas(),
      fetchDataRequests(),
    ]);
    // Todos os dados foram carregados, agora atualiza o estado para parar o carregamento
    setState(
      () {
        isLoading = false;
        // Verifica se os dados de solicitacoesremotas foram carregados corretamente
        if (solicitacoesremotas != -1) {
          solicitacoesremotas =
              NumberOfRequisitions(solicitacoesremotas: solicitacoesremotas)
                  .solicitacoesremotas;
        }
      },
    );
  }

  Future<void> _refreshData() async {
    // Aqui você pode chamar os métodos para recarregar os dados
    // Exemplo: await loadData();
    setState(() {
      isLoading =
          true; // Define isLoading como true para mostrar o indicador de carregamento
    });
    await loadData();
    setState(() {
      isLoading =
          false; // Define isLoading como false para parar o indicador de carregamento
    });
  }

  Future<void> fetchData() async {
    List<MonitorVendasEmpresa>? fetchedData =
        await DataServiceHoje.fetchData(widget.token, widget.url);

    if (fetchedData != null) {
      setState(() {
        empresasHoje = fetchedData;
      });
    }
  }

  Future<void> fetchDataOntem() async {
    List<MonitorVendasEmpresa>? fetchedDataOntem =
        await DataServiceOntem.fetchDataOntem(widget.token, widget.url);

    if (fetchedDataOntem != null) {
      setState(() {
        empresasOntem = fetchedDataOntem;
      });
    }
  }

  Future<void> fetchDataSemana() async {
    List<MonitorVendasEmpresa>? fetchedDataSemana =
        await DataServiceSemana.fetchDataSemana(widget.token, widget.url);

    if (fetchedDataSemana != null) {
      setState(() {
        empresasSemana = fetchedDataSemana;
      });
    }
  }

  Future<void> fetchDataMes() async {
    List<MonitorVendasEmpresa>? fetchedDataMes =
        await DataServiceMes.fetchDataMes(widget.token, widget.url);

    if (fetchedDataMes != null) {
      setState(() {
        empresasMes = fetchedDataMes;
      });
    }
  }

  Future<void> fetchedDataMonitorVendas() async {
    Map<String, double?>? fetchedDataMonitorVendas =
        await DataServiceMonitorVendas.fetchDataMonitorVendas(
            widget.token, widget.url);

    // ignore: unnecessary_null_comparison
    if (fetchedDataMonitorVendas != null) {
      setState(() {
        vendadia = fetchedDataMonitorVendas['vendadia'] ?? 0.0;
        vendadiaanterior = fetchedDataMonitorVendas['vendadiaanterior'] ?? 0.0;
        vendasemana = fetchedDataMonitorVendas['vendasemana'] ?? 0.0;
        vendames = fetchedDataMonitorVendas['vendames'] ?? 0.0;
      });
    }
  }

  Future<void> fetchDataRequests() async {
    int? fetchedDataRequests = await DataServiceMonitorVendas.fetchDataRequests(
        widget.token, widget.url);

    if (fetchedDataRequests != null) {
      setState(() {
        solicitacoesremotas = fetchedDataRequests;
      });
    }
  }
}
