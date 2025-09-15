import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:project/Front/components/Login_Config/Elements/action_button.dart';
import 'package:project/Front/components/global/elements/search_bar.dart';

import 'package:project/Front/components/style.dart';
import 'package:project/Front/components/global/elements/navbar_button.dart';
import 'package:project/Front/components/global/structure/navbar.dart';
import 'package:project/Front/pages/home_page.dart';
import 'package:project/back/consult/credit_consult.dart';
import 'package:project/back/sales_info_functions/company_sales_monitor.dart';
import 'package:project/front/components/login_config/elements/input.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ConsultPage extends StatefulWidget {
  const ConsultPage({super.key});

  @override
  State<ConsultPage> createState() => _ConsultPageState();
}

class _ConsultPageState extends State<ConsultPage> {
  String token = '';
  String urlBasic = '';
  String url = '';
  String empresaid = '';

  String selectedOptionChild = '';

  final _cpfController = TextEditingController();

  List<CreditConsult> creditConsult = [];
  double valortotal = 0.0;

  NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'pt_BR', symbol: '');

  bool flagReturn = false;
  bool flagLoading = false, flagClear = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  final cpfCnpjFormatter = MaskTextInputFormatter(
    mask: '000.000.000-00',
    filter: {"0": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
    initialText: '',
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
            child: Scaffold(
              body: creditConsult.isEmpty
                  ? ListView(children: [
                      Navbar(
                        text: 'Consultar Créditos',
                        children: [
                          NavbarButton(
                            destination: HomePage(),
                            Icons: Icons.arrow_back_ios_new_rounded,
                          ),
                        ],
                      ),
                      Container(
                          //height: Style.height_150(context),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.all(Style.height_12(context)),
                                child: SearchBarDefault(
                                  hintText: 'Busque pelo CPF/CNPJ',
                                  controller: _cpfController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [cpfCnpjFormatter],
                                  onPressedPrefix: () async {
                                    setState(() {
                                      flagReturn = false;
                                      flagLoading = true;
                                    });
                                    fetchDataCredit();
                                  },
                                  onPressedSuffix: () async {
                                    _cpfController.clear();
                                    setState(() {
                                      flagClear = false;
                                    });
                                  },
                                  onChanged: (searchController) {
                                    print(searchController);
                                    if (searchController == '') {
                                      setState(() {
                                        flagClear = false;
                                      });
                                    } else {
                                      setState(() {
                                        flagClear = true;
                                      });
                                    }
                                  },
                                  onSubmited: (value) async {
                                    setState(() {
                                      flagReturn = false;
                                      flagLoading = true;
                                    });
                                    fetchDataCredit();
                                  },
                                  flagClear: flagClear,
                                  // onChanged: (value) {
                                  //   cpfCnpjFormatter.updateMask(
                                  //     mask: _cpfController.text.length <= 13
                                  //         ? '000.000.000-00'
                                  //         : '00.000.000/0000-00',
                                  //   );
                                  // },
                                ),
                                // Input(
                                //   text: 'Informe o CPF do cliente',
                                //   type: TextInputType.number,
                                //   controller: _cpfController,
                                //   onChanged: (value) {
                                //     cpfCnpjFormatter.updateMask(
                                //       mask: _cpfController.text.length <= 13
                                //           ? '000.000.000-00'
                                //           : '00.000.000/0000-00',
                                //     );
                                //   },
                                //   inputFormatters: [cpfCnpjFormatter],
                                // ),
                              ),
                              //
                            ],
                          ))),
                      Container(
                        height: Style.height_400(context),
                        child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/robot.png"),
                                SizedBox(
                                  height: Style.height_5(context),
                                ),
                                if (flagLoading == false)
                                  Text(
                                    'Busque pelo cliente/fornecedor',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: Style.height_15(context)),
                                    textAlign: TextAlign.center,
                                  )
                                else
                                  Container(
                                    width: Style.width_100(context),
                                    child: LinearProgressIndicator(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      minHeight: Style.height_2(context),
                                      year2023: false,
                                    ),
                                  )
                              ]),
                        ),
                      ),
                    ])
                  : ListView(
                      children: [
                        Navbar(
                          text: 'Consultar Créditos',
                          children: [
                            NavbarButton(
                              destination: HomePage(),
                              Icons: Icons.arrow_back_ios_new_rounded,
                            ),
                          ],
                        ),
                        Container(
                          //height: Style.height_150(context),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding:
                                      EdgeInsets.all(Style.height_12(context)),
                                  child: SearchBarDefault(
                                    hintText: 'Busque pelo CPF/CNPJ',
                                    controller: _cpfController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [cpfCnpjFormatter],
                                    onPressedPrefix: () async {
                                      setState(() {
                                        flagReturn = false;
                                        flagLoading = true;
                                      });
                                      fetchDataCredit();
                                    },
                                    onPressedSuffix: () async {
                                      _cpfController.clear();
                                      setState(() {
                                        flagClear = false;
                                      });
                                    },
                                    onChanged: (searchController) {
                                      print(searchController);
                                      if (searchController == '') {
                                        setState(() {
                                          flagClear = false;
                                        });
                                      } else {
                                        setState(() {
                                          flagClear = true;
                                        });
                                      }
                                    },
                                    onSubmited: (value) async {
                                      setState(() {
                                        flagReturn = false;
                                        flagLoading = true;
                                      });
                                      fetchDataCredit();
                                    },
                                    flagClear: flagClear,
                                    // onChanged: (value) {
                                    //   cpfCnpjFormatter.updateMask(
                                    //     mask: _cpfController.text.length <= 13
                                    //         ? '000.000.000-00'
                                    //         : '00.000.000/0000-00',
                                    //   );
                                    // },
                                  ),
                                  // Input(
                                  //   text: 'Informe o CPF do cliente',
                                  //   type: TextInputType.number,
                                  //   controller: _cpfController,
                                  //   onChanged: (value) {
                                  //     cpfCnpjFormatter.updateMask(
                                  //       mask: _cpfController.text.length <= 13
                                  //           ? '000.000.000-00'
                                  //           : '00.000.000/0000-00',
                                  //     );
                                  //   },
                                  //   inputFormatters: [cpfCnpjFormatter],
                                  // ),
                                ),
                                // ActionButton(
                                //   text: 'Consultar',
                                //   height: Style.ActionButtonSize(context),
                                //   onPressed: () async {
                                //     setState(() {
                                //       flagReturn = false;
                                //       flagLoading = true;
                                //     });
                                //     fetchDataCredit();
                                //   },
                                // ),
                                // SizedBox(
                                //   height: Style.height_5(context),
                                // ),
                              ],
                            ),
                          ),
                        ),
                        if (flagLoading)
                          Center(
                            child: Container(
                                height: Style.CircularProgressIndicatorWidth(
                                    context),
                                width: Style.CircularProgressIndicatorWidth(
                                    context),
                                child: CircularProgressIndicator(
                                  strokeWidth:
                                      Style.CircularProgressIndicatorSize(
                                          context),
                                )),
                          )
                        else
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  creditConsult.isEmpty
                                      ? ''
                                      : 'Cliente: ${creditConsult.first.nome}',
                                  style: TextStyle(
                                    fontSize: Style.height_15(context),
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  valortotal != 0.0
                                      ? 'Créditos disponíveis: ${currencyFormat.format(valortotal)}'
                                      : '',
                                  style: TextStyle(
                                    fontSize: Style.height_15(context),
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (flagReturn)
                          Container(
                            padding: EdgeInsets.all(Style.height_12(context)),
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .tertiary),
                                    borderRadius: BorderRadius.circular(
                                        Style.height_10(context))),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                Style.height_10(context)),
                                            topRight: Radius.circular(
                                                Style.height_10(context)),
                                          )),
                                      child: Row(
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            alignment: Alignment(0, 0),
                                            padding: EdgeInsets.only(
                                              top: Style.height_5(context),
                                              bottom: Style.height_5(context),
                                            ),
                                            width: Style.width_53(context),
                                            height: Style.height_50(context),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        width: 2,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 1, 64, 106)))),
                                            child: Text(
                                              'Nº Vale',
                                              style: TextStyle(
                                                  color: Style.tertiaryColor,
                                                  fontSize:
                                                      Style.height_8(context),
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment(0, 0),
                                            padding: EdgeInsets.only(
                                              top: Style.height_5(context),
                                              bottom: Style.height_5(context),
                                            ),
                                            width: Style.width_100(context),
                                            height: Style.height_50(context),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        width: 2,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 1, 64, 106)))),
                                            child: Text(
                                              'Desc.',
                                              style: TextStyle(
                                                  color: Style.tertiaryColor,
                                                  fontSize:
                                                      Style.height_8(context),
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment(0, 0),
                                            padding: EdgeInsets.only(
                                              top: Style.height_5(context),
                                              bottom: Style.height_5(context),
                                            ),
                                            height: Style.height_50(context),
                                            width: Style.height_50(context),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        width: 2,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 1, 64, 106)))),
                                            child: Text(
                                              'Cadastro',
                                              style: TextStyle(
                                                  color: Style.tertiaryColor,
                                                  fontSize:
                                                      Style.height_8(context),
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment(0, 0),
                                            padding: EdgeInsets.only(
                                              top: Style.height_5(context),
                                              bottom: Style.height_5(context),
                                            ),
                                            height: Style.height_50(context),
                                            width: Style.height_50(context),
                                            decoration: BoxDecoration(
                                                border: Border(
                                                    right: BorderSide(
                                                        width: 2,
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 1, 64, 106)))),
                                            child: Text(
                                              'Vencimento',
                                              style: TextStyle(
                                                  color: Style.tertiaryColor,
                                                  fontSize:
                                                      Style.height_8(context),
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment(0, 0),
                                            padding: EdgeInsets.only(
                                              top: Style.height_5(context),
                                              bottom: Style.height_5(context),
                                            ),
                                            width: Style.height_45(context),
                                            height: Style.height_50(context),
                                            child: Text(
                                              'Valor',
                                              style: TextStyle(
                                                  color: Style.tertiaryColor,
                                                  fontSize:
                                                      Style.height_8(context),
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: creditConsult.length,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              Container(
                                                alignment: Alignment(0, 0),
                                                padding: EdgeInsets.all(
                                                    Style.height_5(context)),
                                                width: Style.width_53(context),
                                                height:
                                                    Style.height_50(context),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        right: BorderSide(
                                                            width: 2,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .tertiary))),
                                                child: Text(
                                                  (creditConsult[index]
                                                          .numerodocumento)
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: Style.height_8(
                                                          context),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  softWrap: true,
                                                  overflow: TextOverflow.clip,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment(0, 0),
                                                padding: EdgeInsets.all(
                                                    Style.height_5(context)),
                                                width: Style.width_100(context),
                                                height:
                                                    Style.height_50(context),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        right: BorderSide(
                                                            width: 2,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .tertiary))),
                                                child: Text(
                                                  (creditConsult[index]
                                                          .descricao)
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: Style.height_8(
                                                          context),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  softWrap: true,
                                                  overflow: TextOverflow.clip,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment(0, 0),
                                                padding: EdgeInsets.only(
                                                  top: Style.height_12(context),
                                                  bottom:
                                                      Style.height_12(context),
                                                ),
                                                width: Style.height_50(context),
                                                height:
                                                    Style.height_50(context),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        right: BorderSide(
                                                            width: 2,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .tertiary))),
                                                child: Text(
                                                  '${DateFormat('dd/MM/yyyy').format(creditConsult[index].datadocumento)}'
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: Style.height_8(
                                                          context),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  softWrap: true,
                                                  overflow: TextOverflow.clip,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment(0, 0),
                                                padding: EdgeInsets.only(
                                                  top: Style.height_12(context),
                                                  bottom:
                                                      Style.height_12(context),
                                                ),
                                                width: Style.height_50(context),
                                                height:
                                                    Style.height_50(context),
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        right: BorderSide(
                                                            width: 2,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .tertiary))),
                                                child: Text(
                                                  '${DateFormat('dd/MM/yyyy').format(creditConsult[index].datavencimento)}'
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: Style.height_8(
                                                          context),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  softWrap: true,
                                                  overflow: TextOverflow.clip,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment(0, 0),
                                                padding: EdgeInsets.only(
                                                  top: Style.height_12(context),
                                                  bottom:
                                                      Style.height_12(context),
                                                ),
                                                width: Style.height_45(context),
                                                height:
                                                    Style.height_50(context),
                                                decoration: BoxDecoration(),
                                                child: Text(
                                                  '${currencyFormat.format(creditConsult[index].valor)}',
                                                  style: TextStyle(
                                                      fontSize: Style.height_8(
                                                          context),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  softWrap: true,
                                                  overflow: TextOverflow.clip,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  ],
                                )),
                          )
                      ],
                    ),
            ),
            onWillPop: () async {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()));
              return true;
            }));
  }

  Future<void> _loadSavedUrlBasic() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedUrlBasic = await sharedPreferences.getString('urlBasic') ?? '';
    setState(() {
      urlBasic = savedUrlBasic;
    });
  }

  Future<void> _loadSavedUrl() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedUrl = await sharedPreferences.getString('url') ?? '';
    setState(() {
      url = savedUrl;
    });
  }

  Future<void> _loadSavedToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedToken = await sharedPreferences.getString('token') ?? '';
    setState(() {
      token = savedToken;
    });
  }

  Future<void> _loadSavedEmpresa() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedEmpresa = await sharedPreferences.getString('empresa_id') ?? '';
    setState(() {
      empresaid = savedEmpresa;
    });
  }

  Future<void> fetchDataCredit({bool? ascending}) async {
    List<CreditConsult>? fetchedData =
        await DataServiceCreditConsult.fetchDataCreditConsult(
            context, urlBasic, empresaid, _cpfController.text);

    if (fetchedData != null) {
      setState(() {
        creditConsult = fetchedData;
        flagReturn = true;
        flagLoading = false;
      });
      _calculateTotal();
    } else {
      setState(() {
        valortotal = 0.0;
        flagLoading = false;
      });
    }
  }

  double _calculateTotal() {
    double total = 0.0;
    for (var credit in creditConsult) {
      total += credit.valor;
    }
    setState(() {
      valortotal = total;
    });
    return total;
  }

  Future<void> loadData() async {
    // Utiliza Future.wait para buscar os dados de forma paralela
    await Future.wait([
      _loadSavedToken(),
      _loadSavedUrl(),
      _loadSavedUrlBasic(),
      _loadSavedEmpresa()
    ]);
  }
}
