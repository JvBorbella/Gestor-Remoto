import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/Front/components/global/elements/calendar.dart';
import 'package:project/Front/components/style.dart';
import 'package:project/Front/pages/home_page.dart';
import 'package:project/Front/pages/ocurrences_details_page.dart';
import 'package:project/back/ocurrences_info_functions/get_ocurrence.dart';
import 'package:project/back/customer_info_functions/person.dart';
import 'package:project/front/components/global/elements/navbar_button.dart';
import 'package:project/front/components/global/structure/navbar.dart';
import 'package:project/front/components/login_config/elements/input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OcurrencesPage extends StatefulWidget {
  final selectDate;
  final selectedDates;

  const OcurrencesPage({Key? key, this.selectDate, this.selectedDates});

  @override
  State<OcurrencesPage> createState() => _OcurrencesPageState();
}

class _OcurrencesPageState extends State<OcurrencesPage> {
  List<GetOcurrence> ocurrences = [];

  String token = '',
      urlBasic = '',
      empresaid = '',
      nomepessoa = '',
      pessoa_id = '';

  DateTime selectedDate = DateTime.now();
  List<DateTime?> selectDates = [DateTime.now()];

  bool isLoading = true,
      isLoadingOcurrence = true,
      flagWithDivergence = false,
      flagNoDivergence = false;

  TextEditingController numController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    if (widget.selectDate != null) {
      selectedDate = widget.selectDate;
    }
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
                  // color: Style.defaultColor,
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.15),
                  //     spreadRadius: 5,
                  //     blurRadius: 7,
                  //     offset: Offset(0, 3),
                  //   ),
                  // ],
                  ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      modalFilters();
                      // final selectedDates = await showCalendarDialog(context);
                      // var concat = selectDates.length == 2
                      //     ? "BETWEEN%20'${selectDates.map((date) => DateFormat('yyyy-MM-dd').format(date!)).join("'%20AND%20'").toString()}'"
                      //     : "LIKE%20'${selectDates.map((date) => DateFormat('yyyy-MM-dd').format(date!)).join("")}%25'";
                      // await DataServiceOcurrence.fetchDataOcurrence(
                      //     context,
                      //     token,
                      //     urlBasic,
                      //     empresaid,
                      //     // selectedDate.year.toString(),
                      //     // selectedDate.month.toString().padLeft(2, '0'),
                      //     // selectedDate.day.toString().padLeft(2, '0'),
                      //     // selectDates.length == 2
                      //     //     ? selectDates
                      //     //         .map((date) =>
                      //     //             DateFormat('BETWEEN%20yyy-MM-dd')
                      //     //                 .format(date!))
                      //     //         .join("'%20AND%20'")
                      //     //         .toString()
                      //     //     : selectDates
                      //     //         .map((date) =>
                      //     //             DateFormat('yyy-MM-dd').format(date!))
                      //     //         .join("")
                      //     concat);
                      // isLoadingOcurrence = true;
                      // setState(() {
                      //   fetchDataOcurrences();
                      // });
                    },
                    icon: Icon(Icons.filter_alt_rounded),
                    iconSize: Style.height_15(context),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(
                    width: Style.height_10(context),
                  ),
                  Text(
                    selectDates.isNotEmpty
                        ? selectDates
                            .map((date) =>
                                DateFormat('dd/MM/yyyy').format(date!))
                            .join(' - ')
                        : 'Selecione uma ou mais datas',
                  ),
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
                      //margin: EdgeInsets.only(bottom: Style.height_20(context)),
                      decoration: BoxDecoration(
                          //color: Style.defaultColor,
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.withOpacity(0.15),
                          //     spreadRadius: 5,
                          //     blurRadius: 7,
                          //     offset: Offset(0, 3),
                          //   ),
                          // ],
                          ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              modalFilters();
                              // final selectedDates =
                              //     await showCalendarDialog(context);

                              // if (selectedDates != null) {
                              //   setState(() {
                              //     selectDates = selectedDates;
                              //   });
                              // }
                              // var concat = selectDates.length == 2
                              //     ? "BETWEEN%20'${selectDates.map((date) => DateFormat('yyyy-MM-dd').format(date!)).join("'%20AND%20'").toString()}'"
                              //     : "LIKE%20'${selectDates.map((date) => DateFormat('yyyy-MM-dd').format(date!)).join("")}%25'";
                              // // final DateTime? dateTime = await showDatePicker(
                              // //     context: context,
                              // //     initialDate: selectedDate,
                              // //     firstDate: DateTime(2000),
                              // //     lastDate: DateTime(3000));
                              // // if (dateTime != null) {
                              // //   setState(() {
                              // //     selectedDate = dateTime;
                              // //   });
                              // // }
                              // if (selectedDates != selectDates) {
                              //   isLoadingOcurrence = false;
                              // } else {
                              //   isLoadingOcurrence = true;
                              // }

                              // await DataServiceOcurrence.fetchDataOcurrence(
                              //     context,
                              //     token,
                              //     urlBasic,
                              //     empresaid,
                              //     // selectedDate.year.toString(),
                              //     // selectedDate.month.toString().padLeft(2, '0'),
                              //     // selectedDate.day.toString().padLeft(2, '0'),
                              //     // selectDates.length == 2
                              //     //     ? selectDates
                              //     //         .map((date) =>
                              //     //             DateFormat('BETWEEN%20yyy-MM-dd')
                              //     //                 .format(date!))
                              //     //         .join("'%20AND%20'")
                              //     //         .toString()
                              //     //     : selectDates
                              //     //         .map((date) => DateFormat('yyy-MM-dd')
                              //     //             .format(date!))
                              //     //         .join("")
                              //     concat);
                              // setState(() {
                              //   fetchDataOcurrences();
                              // });
                            },
                            icon: Icon(Icons.filter_alt_rounded),
                            iconSize: Style.height_15(context),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          SizedBox(
                            width: Style.height_10(context),
                          ),
                          Text(
                            selectDates.isNotEmpty
                                ? selectDates
                                    .map((date) =>
                                        DateFormat('dd/MM/yyyy').format(date!))
                                    .join(' - ')
                                : 'Selecione uma ou mais datas',
                          ),
                          // Text(
                          //     '${selectedDate.day.toString().padLeft(2, '0')}/${selectedDate.month.toString().padLeft(2, '0')}/${selectedDate.year} - ${DateFormat('dd/MM/yyyy').format(DateTime.parse(DateTime.now().toString()))}'),
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
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary),
                                            top: BorderSide(
                                                width: Style.height_05(context),
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiary))),
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
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                  ),
                                                ),
                                                Text(
                                                  ocurrences[index]
                                                      .numero
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: Style.height_10(
                                                        context),
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
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
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
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
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
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
                                            if (ocurrences[index]
                                                        .flagdivergencia ==
                                                    0 ||
                                                ocurrences[index]
                                                        .flagdivergencia ==
                                                    1)
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
                                                      .push(MaterialPageRoute(
                                                          builder: (context) =>
                                                              OcurrencesDetails(
                                                                pessoaid:
                                                                    ocurrences[
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
                                                                justificativacancelamento:
                                                                    ocurrences[
                                                                            index]
                                                                        .justificativacancelamento
                                                                        .toString(),
                                                                dataentrega:
                                                                    ocurrences[
                                                                            index]
                                                                        .dataentrega,
                                                                datacadastro:
                                                                    ocurrences[
                                                                            index]
                                                                        .datacadastro,
                                                                flagfinalizada:
                                                                    ocurrences[
                                                                            index]
                                                                        .flagfinalizada,
                                                                flagprocessada:
                                                                    ocurrences[
                                                                            index]
                                                                        .flagprocessada,
                                                                flagcancelado:
                                                                    ocurrences[
                                                                            index]
                                                                        .flagcancelado,
                                                                datahoracancelamento:
                                                                    ocurrences[
                                                                            index]
                                                                        .datahoracancelamento,
                                                                datafinalizada:
                                                                    ocurrences[
                                                                            index]
                                                                        .datafinalizada,
                                                                dataprocessada:
                                                                    ocurrences[
                                                                            index]
                                                                        .dataprocessada,
                                                                ocorrenciaprodutoid:
                                                                    ocurrences[
                                                                            index]
                                                                        .ocorrenciaprodutoid,
                                                                dataano:
                                                                    selectedDate
                                                                        .year
                                                                        .toString(),
                                                                datames:
                                                                    selectedDate
                                                                        .month
                                                                        .toString(),
                                                                datadia:
                                                                    selectedDate
                                                                        .day
                                                                        .toString(),
                                                                selectDate: selectDates
                                                                            .length ==
                                                                        2
                                                                    ? "BETWEEN%20'${selectDates.map((date) => DateFormat('yyyy-MM-dd').format(date!)).join("'%20AND%20'").toString()}'"
                                                                    : "LIKE%20'${selectDates.map((date) => DateFormat('yyyy-MM-dd').format(date!)).join("")}%25'",
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
  }

  Future<void> fetchDataOcurrences() async {
    var concat = selectDates.length == 2
        ? "BETWEEN%20'${selectDates.map((date) => DateFormat('yyyy-MM-dd').format(date!)).join("'%20AND%20'").toString()}'"
        : "LIKE%20'${selectDates.map((date) => DateFormat('yyyy-MM-dd').format(date!)).join("")}%25'";
    List<GetOcurrence>? fetchedData =
        await DataServiceOcurrence.fetchDataOcurrence(
            context,
            token,
            urlBasic,
            empresaid,
            concat,
            flagWithDivergence,
            flagNoDivergence,
            numController.text);
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

  void modalFilters() async {
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          final selectedDates =
                              await showCalendarDialog(context);

                          if (selectedDates != null) {
                            setState(() {
                              selectDates = selectedDates;
                            });
                          }
                          var concat = selectDates.length == 2
                              ? "BETWEEN%20'${selectDates.map((date) => DateFormat('yyyy-MM-dd').format(date!)).join("'%20AND%20'").toString()}'"
                              : "LIKE%20'${selectDates.map((date) => DateFormat('yyyy-MM-dd').format(date!)).join("")}%25'";
                          if (selectedDates != selectDates) {
                            isLoadingOcurrence = false;
                          } else {
                            isLoadingOcurrence = true;
                          }

                          await DataServiceOcurrence.fetchDataOcurrence(
                              context,
                              token,
                              urlBasic,
                              empresaid,
                              concat,
                              flagWithDivergence,
                              flagNoDivergence,
                              numController.text);
                        },
                        child: Text('Data/Período')),
                    ElevatedButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Status da ocorrência'),
                            Icon(Icons.arrow_drop_down)
                          ],
                        )),
                    Container(
                      child: Row(
                        children: [
                          Checkbox(
                              value: flagWithDivergence,
                              onChanged: (value) {
                                setState(() {
                                  flagNoDivergence = false;
                                  flagWithDivergence = value!;
                                });
                              }),
                          Text('Com divergências')
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Checkbox(
                              value: flagNoDivergence,
                              onChanged: (value) {
                                setState(() {
                                  flagWithDivergence = false;
                                  flagNoDivergence = value!;
                                });
                              }),
                          Text('Sem divergências')
                        ],
                      ),
                    ),
                    Input(
                      text: 'Número da ocorrência',
                      type: TextInputType.text,
                      controller: numController,
                    )
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Fechar')),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          fetchDataOcurrences();
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text('Salvar')),
                ],
              ),
            ));
  }
}
