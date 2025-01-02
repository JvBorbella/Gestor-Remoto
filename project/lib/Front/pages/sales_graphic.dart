import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/Front/components/global/elements/navbar_button.dart';
import 'package:project/Front/components/style.dart';
import 'package:project/Front/pages/home_page.dart';
import 'package:project/back/payment_condition.dart';
import 'package:project/back/payment_values.dart';
import 'package:project/front/components/global/structure/navbar.dart';
import 'package:project/front/components/login_config/elements/action_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalesGraphic extends StatefulWidget {
  const SalesGraphic({super.key});

  @override
  State<SalesGraphic> createState() => _SalesGraphicState();
}

class _SalesGraphicState extends State<SalesGraphic> {
  List<PaymentValues> paymentsValues = [];
  List<PaymentCondition> payments = [];
  String urlBasic = '';
  String cond_pgto = '';
  NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  DateTime selectedDate = DateTime.now();
  int flagDay = 0;
  int flagPeriodic = 0;

  String dataInicial = 'Filtre a data';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  bool loadingPieChart = true;
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: Style.CircularProgressIndicatorWidth(context),
                  width: Style.CircularProgressIndicatorWidth(context),
                  child: CircularProgressIndicator(
                    strokeWidth: Style.CircularProgressIndicatorSize(context),
                  )),
              SizedBox(
                height: Style.height_10(context),
              ),
              Container(
                  padding: EdgeInsets.all(Style.height_12(context)),
                  child: Text(
                    'Esta ação pode levar alguns minutos. Por favor, aguarde.',
                    style: TextStyle(
                        fontSize: Style.height_15(context),
                        color: Style.primaryColor),
                    textAlign: TextAlign.center,
                  ))
            ],
          ),
        ),
      );
    }
    return SafeArea(
      child: WillPopScope(
          child: Scaffold(
              body: ListView(
            children: [
              Navbar(children: [
                NavbarButton(
                  destination: HomePage(
                      // url: widget.url,
                      // token: widget.token,
                      ),
                  Icons: Icons.arrow_back_ios_new,
                ),
              ], text: 'Dados de vendas'),
              SizedBox(
                height: Style.height_10(context),
              ),
              Container(
                alignment: Alignment(0, 0),
                child: Text(
                  'Por métodos de pagamento',
                  style: TextStyle(
                      fontSize: Style.height_15(context),
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: Style.height_10(context),
              ),
              if (loadingPieChart)
                Container(
                    height: Style.height_250(context),
                    width: Style.width_250(context),
                    alignment: Alignment(0, 0),
                    decoration: BoxDecoration(),
                    child: CircularProgressIndicator(
                      strokeWidth: Style.CircularProgressIndicatorSize(context),
                    ))
              else
                Container(
                    height: Style.height_250(context),
                    width: Style.width_250(context),
                    alignment: Alignment(0, 0),
                    decoration: BoxDecoration(),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        PieChart(
                          PieChartData(
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius:
                                Style.height_60(context), // Espaço no centro
                            centerSpaceColor: Colors.transparent,
                            sections: mapToPieChartSections(paymentsValues),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: Style.width_100(context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Total:',
                                style: TextStyle(
                                  fontSize: Style.height_12(context),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                '${currencyFormat.format(paymentsValues.fold(0.0, (sum, item) => sum + (item.valor ?? 0.0)))}',
                                style: TextStyle(
                                  fontSize: Style.height_12(context),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                                softWrap: true,
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              SizedBox(
                height: Style.height_20(context),
              ),
              if (loadingPieChart)
                Container(
                  child: Text(''),
                )
              else
                Container(
                  padding: EdgeInsets.all(Style.height_12(context)),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _consolidatePayments(paymentsValues).length,
                      itemBuilder: (context, index) {
                        final consolidatedPayments =
                            _consolidatePayments(paymentsValues);
                        final payment = consolidatedPayments[index];

                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.square,
                                    size: Style.height_10(context),
                                    color: _generateDynamicColor(index),
                                  ),
                                  SizedBox(
                                    width: Style.height_2(context),
                                  ),
                                  Text(
                                    '${payment.nomecondicaopagamento} - ${currencyFormat.format(payment.valor)}',
                                    style: TextStyle(
                                        fontSize: Style.height_10(context),
                                        color: Style.primaryColor),
                                  )
                                ],
                              ),
                            )
                          ],
                        );
                      }),
                ),
              Container(
                  padding: EdgeInsets.all(Style.height_5(context)),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Container(
                                    alignment: Alignment(0, 0),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Style.height_10(context))),
                                    height: Style.height_200(context),
                                    width: Style.width_100(context),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'Como deseja filtrar?',
                                                style: TextStyle(
                                                  fontSize:
                                                      Style.height_15(context),
                                                  color: Style.primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.clip,
                                                softWrap: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ActionButton(
                                                height: Style.ActionButtonSize(
                                                    context),
                                                text: 'Data',
                                                onPressed: () async {
                                                  final DateTime? dateTime =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              selectedDate,
                                                          firstDate:
                                                              DateTime(2000),
                                                          lastDate:
                                                              DateTime(3000));
                                                  if (dateTime != null) {
                                                    setState(() {
                                                      selectedDate = dateTime;
                                                      loadingPieChart = true;
                                                    });
                                                  }
                                                  setState(() {
                                                    flagDay = 1;
                                                    flagPeriodic = 0;
                                                    fetchDataPaymentValues();
                                                    dataInicial =
                                                        '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year}';
                                                  });
                                                  _closeModal();
                                                }),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ActionButton(
                                                height: Style.ActionButtonSize(
                                                    context),
                                                text: 'Período',
                                                onPressed: () async {
                                                  final DateTime? dateTime =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              selectedDate,
                                                          firstDate:
                                                              DateTime(2000),
                                                          lastDate:
                                                              DateTime(3000));
                                                  if (dateTime != null) {
                                                    setState(() {
                                                      selectedDate = dateTime;
                                                      loadingPieChart = true;
                                                    });
                                                  }
                                                  setState(() {
                                                    flagDay = 0;
                                                    flagPeriodic = 1;
                                                    fetchDataPaymentValues();
                                                    dataInicial =
                                                        '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year} - ${DateFormat('dd/MM/yyyy').format(DateTime.parse(DateTime.now().toString()))}';
                                                  });
                                                  _closeModal();
                                                }),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(Style.height_12(context)),
                            child: Text(
                              dataInicial,
                              style: TextStyle(
                                color: Style.secondaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: Style.height_12(context),
                              ),
                            ),
                          )),
                    ],
                  )),
              Container(
                width: Style.width_280(context),
                padding: EdgeInsets.all(Style.height_15(context)),
                margin: EdgeInsets.only(bottom: Style.height_10(context)),
                decoration: BoxDecoration(
                  color: Style.defaultColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      height: Style.height_30(context),
                      child: PopupMenuButton<String>(
                        itemBuilder: (BuildContext context) =>
                            buildMenuItems(payments),
                        onSelected: (value) async {
                          setState(() {
                            loadingPieChart = true;
                            cond_pgto = value;
                            print(cond_pgto);
                          });
                          setState(() {
                            fetchDataPaymentValues();
                          });
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // width: 150,
                                child: Text(
                                  cond_pgto == ''
                                      ? 'Filtre o método de pagamento'
                                      : cond_pgto,
                                  style: TextStyle(
                                    color: Style.secondaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: Style.height_12(context),
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow
                                      .clip, // corta o texto no limite da largura
                                  softWrap:
                                      true, // permite a quebra de linha conforme necessário
                                ),
                              ),
                              SizedBox(
                                width: Style.height_2(context),
                              ),
                              Icon(
                                Icons.arrow_drop_down_circle,
                                color: Style.primaryColor,
                                size: Style.height_20(context),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(Style.height_12(context)),
                child: Text(
                  'OBS: Números dos métodos de pagamento são inicialmente carregados com base nas vendas do dia.',
                  style: TextStyle(
                      fontSize: Style.height_15(context),
                      color: Style.quarantineColor),
                ),
              ),
            ],
          )),
          onWillPop: () async {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
            return true;
          }),
    );
  }

  List<PopupMenuItem<String>> buildMenuItems(
      List<PaymentCondition> paymentsCondition) {
    List<PopupMenuItem<String>> staticItems = [
      PopupMenuItem(
          enabled: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: Style.height_5(context)),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Style.height_5(context)),
                    color: Style.errorColor),
                child: IconButton(
                  onPressed: () {
                    _closeModal();
                  },
                  icon:
                      Image.asset('assets/images/icon_remove/icon_remove.png'),
                  style: ButtonStyle(
                      iconColor: WidgetStatePropertyAll(Style.tertiaryColor)),
                ),
              ),
            ],
          )),
      PopupMenuItem<String>(
        value: '',
        child: Text('Todos'),
      ), // Divisor
    ];
    const PopupMenuDivider();

    List<PopupMenuItem<String>> dynamicItems =
        paymentsCondition.map((payments) {
      return PopupMenuItem<String>(
        value: payments.nome,
        child: Text((payments.nome).toString()),
      );
    }).toList();

    return staticItems + dynamicItems;
  }

  List<PieChartSectionData> mapToPieChartSections(
      List<PaymentValues> payments) {
    if (payments.isEmpty) {
      return [
        PieChartSectionData(
          value: 1,
          title: 'Sem dados',
          radius: Style.height_60(context),
          color: Colors.grey, // Indica ausência de dados
          titleStyle: TextStyle(
            fontSize: Style.height_12(context),
            fontWeight: FontWeight.bold,
            color: Colors.white,
            overflow: TextOverflow.clip,
          ),
        )
      ];
    }
    final Map<String, double> groupedData = {};
    for (var payment in payments) {
      final nome = payment.nomecondicaopagamento ?? '';
      final valor = payment.valor ?? 0.0;

      // Soma os valores para cada nomecondicaopagamento
      groupedData[nome] = (groupedData[nome] ?? 0.0) + valor;
    }
    int index = 0;
    return groupedData.entries.map((entry) {
      // final nome = entry.key;
      final totalValor = entry.value;

      return PieChartSectionData(
        value: totalValor,
        title: '',
        showTitle: true,
        radius: Style.height_50(context),
        color: _generateDynamicColor(index++),
        titleStyle: TextStyle(
          fontSize: Style.height_10(context),
          fontWeight: FontWeight.bold,
          color: Colors.white,
          overflow: TextOverflow.clip,
        ),
      );
    }).toList();
  }

  List<PaymentValues> _consolidatePayments(List<PaymentValues> payments) {
    final Map<String, double> groupedData = {};

    for (var payment in payments) {
      // final condicaopagamentoid = payment.condicaopagamento_id ?? '';
      final nome = payment.nomecondicaopagamento ?? 'Desconhecido';
      final valor = payment.valor ?? 0.0;

      groupedData[nome] = (groupedData[nome] ?? 0.0) + valor;
    }

    // Converte o Map consolidado para uma lista de PaymentValues
    return groupedData.entries.map((entry) {
      return PaymentValues(
        condicaopagamento_id: entry.key,
        nomecondicaopagamento: entry.key,
        valor: entry.value,
        flagexcluido: entry.key,
      );
    }).toList();
  }

  // Função para gerar cores dinâmicas
  Color _generateDynamicColor(int index) {
    final List<Color> colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.yellow,
      Colors.pink,
      Colors.cyan,
    ];
    return colors[index % colors.length];
  }

  void _closeModal() {
    //Função para fechar o modal
    Navigator.of(context).pop();
  }

  Future<void> _loadSavedUrlBasic() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedUrlBasic = await sharedPreferences.getString('urlBasic') ?? '';
    setState(() {
      urlBasic = savedUrlBasic;
    });
  }

  Future<void> loadData() async {
    await Future.wait([
      _loadSavedUrlBasic(),
    ]);

    if (urlBasic.isNotEmpty) {
      await Future.wait([
        fetchDataPayments(),
        fetchDataPaymentValues(),
      ]);
    }
    // Todos os dados foram carregados, agora atualiza o estado para parar o carregamento
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchDataPayments() async {
    List<PaymentCondition>? fetchedData =
        await DataServicePaymentsCondition.fetchDataPaymentsCondition(
            context, urlBasic);
    if (fetchedData != null) {
      setState(() {
        payments = fetchedData;
      });
      print(
          'Body do Json Payments Condition na tela sales_graphic: $fetchDataPayments');
    }
  }

  void _onProductAdded() {
    setState(() {
      paymentsValues = [];
      loadingPieChart = false;
    });
  }

  Future<void> fetchDataPaymentValues({bool? ascending}) async {
    List<PaymentValues>? fetchedData =
        await DataServicePaymentValues.fetchDataPaymentValues(
            context,
            urlBasic,
            cond_pgto,
            selectedDate.year.toString(),
            selectedDate.month.toString(),
            selectedDate.day.toString(),
            flagDay,
            flagPeriodic,
            _onProductAdded);

    if (fetchedData != null) {
      setState(() {
        paymentsValues = fetchedData;
        loadingPieChart = false;
      });
    }
    setState(() {
      loadingPieChart = false;
    });
  }
}
