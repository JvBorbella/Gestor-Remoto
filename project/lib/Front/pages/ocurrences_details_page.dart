import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/Front/components/Login_Config/Elements/input_blocked.dart';
import 'package:project/Front/components/global/elements/navbar_button.dart';
import 'package:project/Front/pages/ocurrences_page.dart';
import 'package:project/back/ocurrences_info_functions/get_ocurrence.dart';
import 'package:project/back/customer_info_functions/person.dart';

import 'package:project/front/components/global/structure/navbar.dart';
import 'package:project/Front/components/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OcurrencesDetails extends StatefulWidget {
  //ocorrenciaproduto
  final pessoaid;
  final nome;
  final codigo;
  final numero;
  final identificador;
  final obs;
  final justificativacancelamento;
  final dataentrega;
  final datacadastro;
  final flagfinalizada;
  final flagprocessada;
  final flagcancelado;
  final datahoracancelamento;
  final datafinalizada;
  final dataprocessada;
  final ocorrenciaprodutoid;

  final dataano;
  final datames;
  final datadia;

  final selectDate;

  const OcurrencesDetails(
      {Key? key,
      this.pessoaid,
      this.nome,
      this.codigo,
      this.numero,
      this.identificador,
      this.obs,
      this.justificativacancelamento,
      this.dataentrega,
      this.datacadastro,
      this.flagfinalizada,
      this.flagprocessada,
      this.flagcancelado,
      this.datahoracancelamento,
      this.datafinalizada,
      this.dataprocessada,
      this.ocorrenciaprodutoid,
      this.dataano,
      this.datames,
      this.datadia,
      this.selectDate});

  @override
  State<OcurrencesDetails> createState() => _OcurrencesDetailsState();
}

class _OcurrencesDetailsState extends State<OcurrencesDetails> {
  List<GetOcurrenceItem> ocurrencesItem = [];

  String token = '';
  String urlBasic = '';
  String empresaid = '';

  String nomepessoa = '';

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
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
    }
    return WillPopScope(
        child: SafeArea(
          child: Scaffold(
            body: ListView(
              children: [
                Navbar(text: 'Detalhes da Ocorrência', children: [
                  NavbarButton(volta: 'volta', Icons: Icons.arrow_back_ios_new)
                ]),
                Container(
                  padding: EdgeInsets.all(Style.height_12(context)),
                  child: Container(
                    padding: EdgeInsets.all(Style.height_8(context)),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius:
                            BorderRadius.circular(Style.height_10(context))),
                    child: Column(
                      children: [
                        Text('Nome',
                            style: TextStyle(
                              fontSize: Style.height_8(context),
                              color: Style.tertiaryColor,
                            )),
                        Text(
                          widget.nome,
                          style: TextStyle(
                              fontSize: Style.height_15(context),
                              color: Style.tertiaryColor,
                              fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: Style.height_10(context),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text('Código',
                                    style: TextStyle(
                                      fontSize: Style.height_8(context),
                                      color: Style.tertiaryColor,
                                    )),
                                Container(
                                  width: Style.width_100(context),
                                  child: Text(
                                    widget.codigo,
                                    style: TextStyle(
                                        fontSize: Style.height_10(context),
                                        color: Style.tertiaryColor,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    overflow: TextOverflow.clip,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text('Número',
                                    style: TextStyle(
                                      fontSize: Style.height_8(context),
                                      color: Style.tertiaryColor,
                                    )),
                                Container(
                                  width: Style.width_100(context),
                                  child: Text(
                                    widget.numero,
                                    style: TextStyle(
                                        fontSize: Style.height_10(context),
                                        color: Style.tertiaryColor,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                    softWrap: true,
                                    overflow: TextOverflow.clip,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text('Identificador',
                                style: TextStyle(
                                  fontSize: Style.height_8(context),
                                  color: Style.tertiaryColor,
                                )),
                            Container(
                              // width: Style.width_150(context),
                              child: Text(
                                widget.identificador,
                                style: TextStyle(
                                    fontSize: Style.height_10(context),
                                    color: Style.tertiaryColor,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: Style.height_10(context),
                        ),
                        Text('Data de entrega',
                            style: TextStyle(
                              fontSize: Style.height_8(context),
                              color: Style.tertiaryColor,
                            )),
                        Text(
                          widget.dataentrega != null
                              ? DateFormat('dd/MM/yyyy HH:mm:ss').format(
                                  DateTime.parse(widget.dataentrega.toString()))
                              : '',
                          style: TextStyle(
                              fontSize: Style.height_15(context),
                              color: Style.tertiaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                // Container(
                //   padding: EdgeInsets.only(
                //     left: Style.height_12(context),
                //     right: Style.height_12(context),
                //     bottom: Style.height_12(context),
                //   ),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Theme.of(context).colorScheme.primary
                //     ),
                //     child: Column(
                //       children: [
                //         Text(
                //           'Cliente',
                //           style: TextStyle(
                //             color: Style.tertiaryColor,
                //             fontSize: Style.height_10(context),
                //           ),
                //         ),
                //         Text(
                //           nomepessoa,
                //           style: TextStyle(
                //             color: Style.tertiaryColor,
                //             fontSize: Style.height_15(context),
                //             fontWeight: FontWeight.bold
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.only(
                    left: Style.height_12(context),
                    right: Style.height_12(context),
                    bottom: Style.height_12(context),
                  ),
                  alignment: Alignment.center,
                  child: Table(
                    border: TableBorder.all(
                        width: 1,
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius:
                            BorderRadius.circular(Style.height_10(context))),
                    children: [
                      TableRow(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(Style.height_10(context)),
                              topRight:
                                  Radius.circular(Style.height_10(context)),
                            ),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          children: [
                            Container(
                              padding: EdgeInsets.all(Style.height_5(context)),
                              // alignment: Alignment(0, 0),
                              child: Text(
                                'Data Cadastro',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Style.tertiaryColor,
                                    fontSize: Style.height_8(context),
                                    fontWeight: FontWeight.bold),
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: Style.height_10(context),
                                bottom: Style.height_10(context),
                              ),
                              // alignment: Alignment(0, 0),
                              child: Text(
                                'Status',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Style.tertiaryColor,
                                    fontSize: Style.height_8(context),
                                    fontWeight: FontWeight.bold),
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(Style.height_5(context)),
                              // alignment: Alignment(0, 0),
                              child: Text(
                                'Data Finalizado',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Style.tertiaryColor,
                                    fontSize: Style.height_8(context),
                                    fontWeight: FontWeight.bold),
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(Style.height_5(context)),
                              // alignment: Alignment(0, 0),
                              child: Text(
                                'Data Processado',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Style.tertiaryColor,
                                    fontSize: Style.height_8(context),
                                    fontWeight: FontWeight.bold),
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(Style.height_5(context)),
                              // alignment: Alignment(0, 0),
                              child: Text(
                                'Data Cancelado',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Style.tertiaryColor,
                                    fontSize: Style.height_8(context),
                                    fontWeight: FontWeight.bold),
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ]),
                      TableRow(decoration: BoxDecoration(), children: [
                        Text(
                          DateFormat('dd/MM/yyyy HH:mm:ss')
                              .format(widget.datacadastro),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: Style.height_8(context)),
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: Style.height_5(context),
                            bottom: Style.height_5(context),
                          ),
                          child: Text(
                            widget.flagprocessada == 1
                                ? 'Processada'
                                : widget.flagfinalizada == 1
                                    ? 'Finalizada'
                                    : widget.flagcancelado == 1
                                        ? 'Cancelada'
                                        : 'Em aberto',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: Style.height_8(context)),
                            softWrap: true,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        Text(
                          widget.datafinalizada != null
                              ? DateFormat('dd/MM/yyyy HH:mm:ss').format(
                                  DateTime.parse(
                                      widget.datafinalizada.toString()))
                              : '',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: Style.height_8(context)),
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                        Text(
                          widget.dataprocessada != null
                              ? DateFormat('dd/MM/yyyy HH:mm:ss').format(
                                  DateTime.parse(
                                      widget.dataprocessada.toString()))
                              : '',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: Style.height_8(context)),
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                        Text(
                          widget.datahoracancelamento != null
                              ? DateFormat('dd/MM/yyyy HH:mm:ss').format(
                                  DateTime.parse(
                                      widget.datahoracancelamento.toString()))
                              : '',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: Style.height_8(context)),
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                      ])
                    ],
                  ),
                ),
                if (widget.flagcancelado == 1)
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: Style.height_12(context),
                            right: Style.height_12(context),
                            bottom: Style.height_10(context)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Justificativa de Cancelamento:',
                              style: TextStyle(
                                  fontSize: Style.height_10(context),
                                  color: Style.errorColor,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                            InputBlocked(
                              value: widget.justificativacancelamento,
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: Style.height_12(context),
                          right: Style.height_12(context),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Observação:',
                              style: TextStyle(
                                  fontSize: Style.height_10(context),
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                            Container(
                              height: Style.height_100(context),
                              padding: EdgeInsets.all(Style.height_8(context)),
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      Style.height_10(context))),
                              child: Text(
                                widget.obs,
                                textAlign: TextAlign.start,
                                softWrap: true,
                                overflow: TextOverflow.clip,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                else
                  Container(
                    padding: EdgeInsets.only(
                      left: Style.height_12(context),
                      right: Style.height_12(context),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Observação:',
                          style: TextStyle(
                              fontSize: Style.height_10(context),
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        Container(
                          height: Style.height_100(context),
                          padding: EdgeInsets.all(Style.height_8(context)),
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.tertiary,
                              border: Border.all(
                                width: 1,
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(
                                  Style.height_10(context))),
                          child: Text(
                            widget.obs,
                            textAlign: TextAlign.start,
                            softWrap: true,
                            overflow: TextOverflow.clip,
                          ),
                        )
                      ],
                    ),
                  ),
                Container(
                  padding: EdgeInsets.only(
                    top: Style.height_12(context),
                    left: Style.height_12(context),
                    right: Style.height_12(context),
                  ),
                  alignment: Alignment.center,
                  child: Table(
                    // border: TableBorder.all(
                    //     width: 1,
                    //     color: Theme.of(context).colorScheme.primary,
                    //     borderRadius: BorderRadius.circular(
                    //       Style.height_10(context)
                    //     )
                    children: [],
                  ),
                ),
                Container(
                  child: Text(
                    'Produtos',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: Style.height_15(context),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(Style.height_12(context)),
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Theme.of(context).colorScheme.tertiary),
                          borderRadius:
                              BorderRadius.circular(Style.height_10(context))),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.only(
                                  topLeft:
                                      Radius.circular(Style.height_10(context)),
                                  topRight:
                                      Radius.circular(Style.height_10(context)),
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
                                              color: const Color.fromARGB(
                                                  255, 1, 64, 106)))),
                                  child: Text(
                                    'Código',
                                    style: TextStyle(
                                        color: Style.tertiaryColor,
                                        fontSize: Style.height_8(context),
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
                                  width: Style.width_130(context),
                                  height: Style.height_50(context),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 2,
                                              color: const Color.fromARGB(
                                                  255, 1, 64, 106)))),
                                  child: Text(
                                    'Nome',
                                    style: TextStyle(
                                        color: Style.tertiaryColor,
                                        fontSize: Style.height_8(context),
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
                                  width: Style.height_30(context),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 2,
                                              color: const Color.fromARGB(
                                                  255, 1, 64, 106)))),
                                  child: Text(
                                    'Qtde',
                                    style: TextStyle(
                                        color: Style.tertiaryColor,
                                        fontSize: Style.height_8(context),
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
                                  width: Style.height_50(context),
                                  height: Style.height_50(context),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 2,
                                              color: const Color.fromARGB(
                                                  255, 1, 64, 106)))),
                                  child: Text(
                                    'Qtde. Informada',
                                    style: TextStyle(
                                        color: Style.tertiaryColor,
                                        fontSize: Style.height_8(context),
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
                                  width: Style.height_40(context),
                                  height: Style.height_50(context),
                                  // decoration: BoxDecoration(
                                  //     border: Border.all(
                                  //         width: 1,
                                  //         color: const Color.fromARGB(
                                  //             255, 1, 64, 106)),
                                  //     borderRadius: BorderRadius.only(
                                  //         topRight: Radius.circular(
                                  //             Style.height_10(context)))),
                                  child: Text(
                                    'Qtde. Estoque',
                                    style: TextStyle(
                                        color: Style.tertiaryColor,
                                        fontSize: Style.height_8(context),
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
                              itemCount: ocurrencesItem.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Container(
                                      alignment: Alignment(0, 0),
                                      padding: EdgeInsets.all(
                                          Style.height_5(context)),
                                      width: Style.width_53(context),
                                      height: Style.height_50(context),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                                  width: 2,
                                                  color: Theme.of(context).colorScheme.tertiary))),
                                      child: Text(
                                        ocurrencesItem[index]
                                            .codigoproduto
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: Style.height_8(context),
                                            fontWeight: FontWeight.bold),
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment(0, 0),
                                      padding: EdgeInsets.all(
                                          Style.height_5(context)),
                                      width: Style.width_130(context),
                                      height: Style.height_50(context),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                                  width: 2,
                                                  color: Theme.of(context).colorScheme.tertiary))),
                                      child: Text(
                                        ocurrencesItem[index]
                                            .nomeproduto
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: Style.height_8(context),
                                            fontWeight: FontWeight.bold),
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment(0, 0),
                                      padding: EdgeInsets.only(
                                        top: Style.height_12(context),
                                        bottom: Style.height_12(context),
                                      ),
                                      width: Style.height_30(context),
                                      height: Style.height_50(context),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                                  width: 2,
                                                  color: Theme.of(context).colorScheme.tertiary))),
                                      child: Text(
                                        ocurrencesItem[index]
                                            .quantidade
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: Style.height_8(context),
                                            fontWeight: FontWeight.bold),
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment(0, 0),
                                      padding: EdgeInsets.only(
                                        top: Style.height_12(context),
                                        bottom: Style.height_12(context),
                                      ),
                                      width: Style.height_50(context),
                                      height: Style.height_50(context),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                                  width: 2,
                                                  color: Theme.of(context).colorScheme.tertiary))),
                                      child: Text(
                                        ocurrencesItem[index]
                                            .quantidadeinformada
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: Style.height_8(context),
                                            fontWeight: FontWeight.bold),
                                        softWrap: true,
                                        overflow: TextOverflow.clip,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment(0, 0),
                                      padding: EdgeInsets.only(
                                        top: Style.height_12(context),
                                        bottom: Style.height_12(context),
                                      ),
                                      width: Style.height_40(context),
                                      height: Style.height_50(context),
                                      decoration: BoxDecoration(),
                                      child: Text(
                                        ocurrencesItem[index]
                                            .quantidadeestoque
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: Style.height_8(context),
                                            fontWeight: FontWeight.bold),
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
        ),
        onWillPop: () async {
          // Navigator.of(context).pushReplacement(MaterialPageRoute(
          //     builder: (context) =>
          //         OcurrencesPage(selectDate: widget.selectDate)));
          return true;
        });
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
    await Future.wait([fetchDataOcurrencesItem()]);
    await Future.wait([fetchDataPerson()]);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchDataOcurrencesItem() async {
    List<GetOcurrenceItem>? fetchedData =
        await DataServiceOcurrenceItem.fetchDataOcurrenceItem(
            token,
            urlBasic,
            empresaid,
            widget.ocorrenciaprodutoid,
            // widget.dataano,
            // widget.datames,
            // widget.datadia,
            widget.selectDate);
    if (fetchedData != null) {
      setState(() {
        ocurrencesItem = fetchedData;
      });
      setState(() {
        isLoading =
            false; // Define isLoading como true para mostrar o indicador de carregamento
      });
    }
  }

  Future<void> fetchDataPerson() async {
    Map<String, String?>? fetchDataPerson =
        await DataServicePerson.fetchDataPerson(
            token, urlBasic, widget.pessoaid.toString());
    setState(() {
      nomepessoa = fetchDataPerson['nome'] ?? '';
    });
  }
}
