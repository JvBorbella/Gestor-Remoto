import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/Front/components/style.dart';
import 'package:project/Front/pages/home_page.dart';
import 'package:project/Front/pages/ocurrences_details_page.dart';
import 'package:project/back/get_ocurrence.dart';
import 'package:project/back/person.dart';
import 'package:project/front/components/global/elements/navbar_button.dart';
import 'package:project/front/components/global/structure/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OcurrencesPage extends StatefulWidget {
  final selectDate;

  const OcurrencesPage({Key? key, this.selectDate});

  @override
  State<OcurrencesPage> createState() => _OcurrencesPageState();
}

class _OcurrencesPageState extends State<OcurrencesPage> {
  List<GetOcurrence> ocurrences = [];

  String token = '';
  String urlBasic = '';
  String empresaid = '';

  String nomepessoa = '';
  String pessoa_id = '';

  DateTime selectedDate = DateTime.now();

  bool isLoading = true;
  bool isLoadingOcurrence = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    if (widget.selectDate != null) {
      selectedDate = widget.selectDate;
    }
    print('Data: $selectedDate');
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: Container(
              height: Style.CircularProgressIndicatorWidth(context),
              width: Style.CircularProgressIndicatorWidth(context),
              child: CircularProgressIndicator(
                strokeWidth: Style.CircularProgressIndicatorSize(context),
              )),
        ),
      );
    } else if (isLoadingOcurrence) {
      return SafeArea(
          child: Scaffold(
        body: Column(children: [
          Navbar(text: 'Ocorrências', children: [
            NavbarButton(
                destination: HomePage(),
                Icons: Icons.arrow_back_ios_new_rounded)
          ]),
          Container(
              padding: EdgeInsets.all(Style.height_15(context)),
              margin: EdgeInsets.only(bottom: Style.height_20(context)),
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
                  IconButton(
                    onPressed: () async {
                      final DateTime? dateTime = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(3000));
                      if (dateTime != null) {
                        setState(() {
                          selectedDate = dateTime;
                        });
                      }
                      await DataServiceOcurrence.fetchDataOcurrence(
                        context,
                        token,
                        urlBasic,
                        empresaid,
                        selectedDate.year.toString(),
                        selectedDate.month.toString().padLeft(2, '0'),
                        selectedDate.day.toString().padLeft(2, '0'),
                      );
                      isLoadingOcurrence = true;
                      setState(() {
                        fetchDataOcurrences();
                      });
                    },
                    icon: Icon(Icons.filter_alt_rounded),
                    iconSize: Style.height_15(context),
                    color: Style.secondaryColor,
                  ),
                  SizedBox(
                    width: Style.height_10(context),
                  ),
                  Text(
                      '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year} - ${DateFormat('dd/MM/yyyy').format(DateTime.parse(DateTime.now().toString()))}'),
                ],
              )),
          Expanded(
            child: Center(
              child: Container(
                  height: Style.CircularProgressIndicatorWidth(context),
                  width: Style.CircularProgressIndicatorWidth(context),
                  child: CircularProgressIndicator(
                    strokeWidth: Style.CircularProgressIndicatorSize(context),
                  )),
            ),
          )
        ]),
      ));
    }

    return SafeArea(
        child: WillPopScope(
            child: Scaffold(
              body: Column(
                children: [
                  Navbar(text: 'Ocorrências', children: [
                    NavbarButton(
                        destination: HomePage(),
                        Icons: Icons.arrow_back_ios_new_rounded)
                  ]),
                  Container(
                      padding: EdgeInsets.all(Style.height_15(context)),
                      margin: EdgeInsets.only(bottom: Style.height_20(context)),
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
                          IconButton(
                            onPressed: () async {
                              final DateTime? dateTime = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(3000));
                              if (dateTime != null) {
                                setState(() {
                                  selectedDate = dateTime;
                                });
                              }
                              isLoadingOcurrence = true;
                              await DataServiceOcurrence.fetchDataOcurrence(
                                context,
                                token,
                                urlBasic,
                                empresaid,
                                selectedDate.year.toString(),
                                selectedDate.month.toString().padLeft(2, '0'),
                                selectedDate.day.toString().padLeft(2, '0'),
                              );
                              setState(() {
                                fetchDataOcurrences();
                              });
                            },
                            icon: Icon(Icons.filter_alt_rounded),
                            iconSize: Style.height_15(context),
                            color: Style.secondaryColor,
                          ),
                          SizedBox(
                            width: Style.height_10(context),
                          ),
                          Text(
                              '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year} - ${DateFormat('dd/MM/yyyy').format(DateTime.parse(DateTime.now().toString()))}'),
                        ],
                      )),
                  Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: ocurrences.length,
                          itemBuilder: (context, index) {
                            DataServicePerson.fetchDataPerson(token, urlBasic,
                                ocurrences[index].pessoaid.toString());
                            return Container(
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.all(Style.height_8(context)),
                                    // alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: BorderDirectional(
                                            bottom: BorderSide(
                                                width: Style.height_05(context),
                                                color: Style.quarantineColor),
                                            top: BorderSide(
                                                width: Style.height_05(context),
                                                color: Style.quarantineColor))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                    width: Style.height_150(
                                                        context),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Descrição',
                                                          style: TextStyle(
                                                            fontSize:
                                                                Style.height_8(
                                                                    context),
                                                            color: Style
                                                                .primaryColor,
                                                          ),
                                                        ),
                                                        Text(
                                                          ocurrences[index]
                                                              .nome
                                                              .toString(),
                                                          style: TextStyle(
                                                            fontSize:
                                                                Style.height_12(
                                                                    context),
                                                            color: Style
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        )
                                                      ],
                                                    ))
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Nº da ocorrência',
                                                  style: TextStyle(
                                                    fontSize:
                                                        Style.height_8(context),
                                                    color: Style.primaryColor,
                                                  ),
                                                ),
                                                Text(
                                                  ocurrences[index]
                                                      .numero
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: Style.height_10(
                                                        context),
                                                    color: Style.primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'Status',
                                              style: TextStyle(
                                                fontSize:
                                                    Style.height_8(context),
                                                color: Style.primaryColor,
                                              ),
                                            ),
                                            if (ocurrences[index]
                                                    .flagprocessada ==
                                                1)
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text('Processada ',
                                                      style: TextStyle(
                                                          color: Style
                                                              .sucefullColor,
                                                          fontSize:
                                                              Style.height_8(
                                                                  context),
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              )
                                            else if (ocurrences[index]
                                                    .flagfinalizada ==
                                                1)
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text('Finalizada ',
                                                      style: TextStyle(
                                                          color: Style
                                                              .secondaryColor,
                                                          fontSize:
                                                              Style.height_8(
                                                                  context),
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              )
                                            else if (ocurrences[index]
                                                    .flagcancelado ==
                                                1)
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text('Cancelada ',
                                                      style: TextStyle(
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 255, 30, 14),
                                                          fontSize:
                                                              Style.height_8(
                                                                  context),
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              )
                                            else
                                              Text('Em aberto',
                                                  style: TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 255, 191, 0),
                                                      fontSize: Style.height_8(
                                                          context),
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            if (ocurrences[index].flagdivergencia == 0 ||
                                                ocurrences[index].flagdivergencia == 1)
                                              Text(
                                                'Há divergências ⚠️',
                                                style: TextStyle(
                                                    fontSize:
                                                        Style.height_8(context),
                                                    color: const Color.fromARGB(
                                                        255, 255, 149, 0)),
                                              ),
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        WidgetStatePropertyAll(
                                                            Style
                                                                .primaryColor)),
                                                onPressed: () async {
                                                  await Navigator.of(context)
                                                      .pushReplacement(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  OcurrencesDetails(
                                                                    pessoaid: ocurrences[
                                                                            index]
                                                                        .pessoaid,
                                                                    nome: ocurrences[
                                                                            index]
                                                                        .nome
                                                                        .toString(),
                                                                    codigo: ocurrences[
                                                                            index]
                                                                        .codigo
                                                                        .toString(),
                                                                    numero: ocurrences[
                                                                            index]
                                                                        .numero
                                                                        .toString(),
                                                                    identificador: ocurrences[
                                                                            index]
                                                                        .identificador
                                                                        .toString(),
                                                                    obs: ocurrences[
                                                                            index]
                                                                        .obs
                                                                        .toString(),
                                                                    justificativacancelamento: ocurrences[
                                                                            index]
                                                                        .justificativacancelamento
                                                                        .toString(),
                                                                    dataentrega:
                                                                        ocurrences[index]
                                                                            .dataentrega,
                                                                    datacadastro:
                                                                        ocurrences[index]
                                                                            .datacadastro,
                                                                    flagfinalizada:
                                                                        ocurrences[index]
                                                                            .flagfinalizada,
                                                                    flagprocessada:
                                                                        ocurrences[index]
                                                                            .flagprocessada,
                                                                    flagcancelado:
                                                                        ocurrences[index]
                                                                            .flagcancelado,
                                                                    datahoracancelamento:
                                                                        ocurrences[index]
                                                                            .datahoracancelamento,
                                                                    datafinalizada:
                                                                        ocurrences[index]
                                                                            .datafinalizada,
                                                                    dataprocessada:
                                                                        ocurrences[index]
                                                                            .dataprocessada,
                                                                    ocorrenciaprodutoid:
                                                                        ocurrences[index]
                                                                            .ocorrenciaprodutoid,
                                                                    dataano: selectedDate
                                                                        .year
                                                                        .toString(),
                                                                    datames: selectedDate
                                                                        .month
                                                                        .toString(),
                                                                    datadia:
                                                                        selectedDate
                                                                            .day
                                                                            .toString(),
                                                                    selectDate:
                                                                        selectedDate,
                                                                  )));
                                                },
                                                child: Container(
                                                  width:
                                                      Style.height_40(context),
                                                  height:
                                                      Style.height_15(context),
                                                  alignment: Alignment(0, 0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Style.height_5(
                                                                  context))),
                                                  child: Text(
                                                    'Detalhes',
                                                    style: TextStyle(
                                                        fontSize:
                                                            Style.height_10(
                                                                context),
                                                        color: Style
                                                            .tertiaryColor),
                                                  ),
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }))
                ],
              ),
            ),
            onWillPop: () async {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()));
              return true;
            }));
  }

  Future<void> _loadSavedToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedToken = await sharedPreferences.getString('token') ?? '';
    setState(() {
      token = savedToken;
    });
  }

  Future<void> _loadSavedUrlBasic() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedUrlBasic = await sharedPreferences.getString('urlBasic') ?? '';
    setState(() {
      urlBasic = savedUrlBasic;
    });
  }

  Future<void> _loadSavedEmpresa() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedEmpresa = await sharedPreferences.getString('empresa_id') ?? '';
    setState(() {
      empresaid = savedEmpresa;
    });
  }

  Future<void> loadData() async {
    await Future.wait([
      _loadSavedToken(),
      _loadSavedUrlBasic(),
      _loadSavedEmpresa(),
    ]);
    await Future.wait([fetchDataOcurrences()]);
    // await Future.wait([fetchDataPerson()]);
    setState(() {
      isLoading = false;
      isLoadingOcurrence = false;
    });
  }

  Future<void> _refreshData() async {
    setState(() {
      isLoading = true;
      isLoadingOcurrence = true;
    });
    await loadData();
    setState(() {
      isLoading = false;
      isLoadingOcurrence = false;
    });
  }

  Future<void> fetchDataPerson() async {
    Map<String, String?>? fetchData =
        await DataServicePerson.fetchDataPerson(token, urlBasic, pessoa_id);
    setState(() {
      nomepessoa = fetchData['nome'] ?? '';
    });
    print('Nomepessoa: ' + nomepessoa);
  }

  Future<void> fetchDataOcurrences() async {
    List<GetOcurrence>? fetchedData =
        await DataServiceOcurrence.fetchDataOcurrence(
      context,
      token,
      urlBasic,
      empresaid,
      selectedDate.year.toString(),
      selectedDate.month.toString(),
      selectedDate.day.toString(),
    );
    if (fetchedData != null) {
      setState(() {
        ocurrences = fetchedData;
      });
      setState(() {
        isLoading = false;
        isLoadingOcurrence = false;
      });
    } else {
      setState(() {
        isLoadingOcurrence = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          padding: EdgeInsets.all(Style.SaveUrlMessagePadding(context)),
          content: Text(
            'Não há ocorrências para esta data',
            style: TextStyle(
              fontSize: Style.SaveUrlMessageSize(context),
              color: Style.tertiaryColor,
            ),
          ),
          backgroundColor: Style.warningColor,
        ),
      );
    }
  }
}
