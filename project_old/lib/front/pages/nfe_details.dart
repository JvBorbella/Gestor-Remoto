import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/Front/components/global/elements/navbar_button.dart';
import 'package:project/Front/components/global/structure/navbar.dart';
import 'package:project/Front/components/style.dart';
import 'package:project/Front/pages/nfe_list.dart';
import 'package:project/back/nfe_info_functions/nfe_items.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NfeDetails extends StatefulWidget {
  final documentonfe_id;
  final selectDate;
  final flagDay;
  final flagPeriodic;
  final empresa_id;
  final empresa_nome;
  final codTipoNfe;
  final searchcontroller;

  final num_doc;
  final chv_nfe;
  final serie;
  final dt_doc;
  final dt_e_s;
  final vl_doc;
  final vl_desc;
  final vl_merc;
  final vl_frete;
  final vl_bc_icms;
  final vl_icms;
  final vl_bc_icms_st;
  final vl_icms_st;
  final vl_ipi;
  final vl_cofins;
  final vl_pis_st;
  final vl_pis;
  final vl_cofins_st;
  final vl_ii;
  final vl_out_da;
  final vl_seg;
  final vl_icmsfecp;
  final vl_icmsfecp_st;
  final desc_nat_op;
  final cod_mod;
  final em_razaosocial;
  final dest_razaosocial;
  final codigoretorno;
  final descricaoretorno;
  final finalidade;

  const NfeDetails({
    Key? key,
    this.documentonfe_id,
    this.selectDate,
    this.flagDay,
    this.flagPeriodic,
    this.empresa_id,
    this.empresa_nome,
    this.codTipoNfe,
    this.searchcontroller,
    this.num_doc,
    this.chv_nfe,
    this.serie,
    this.dt_doc,
    this.dt_e_s,
    this.vl_doc,
    this.vl_desc,
    this.vl_merc,
    this.vl_frete,
    this.vl_bc_icms,
    this.vl_icms,
    this.vl_bc_icms_st,
    this.vl_icms_st,
    this.vl_ipi,
    this.vl_cofins,
    this.vl_pis_st,
    this.vl_pis,
    this.vl_cofins_st,
    this.vl_ii,
    this.vl_out_da,
    this.vl_seg,
    this.vl_icmsfecp,
    this.vl_icmsfecp_st,
    this.desc_nat_op,
    this.cod_mod,
    this.em_razaosocial,
    this.dest_razaosocial,
    this.codigoretorno,
    this.descricaoretorno,
    this.finalidade,
  });

  @override
  State<NfeDetails> createState() => _NfeDetailsState();
}

class _NfeDetailsState extends State<NfeDetails> {
  bool isLoading = true;

  String urlBasic = '';

  NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'pt_BR', symbol: '');

  NumberFormat currencyFormatDefault =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  List<NfeItems> nfeItems = [];

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
    return SafeArea(
      // child: WillPopScope(
      child: Scaffold(
        body: ListView(
          children: [
            Navbar(text: 'Detalhes da Nota', children: [
              NavbarButton(
                  destination: NfeList(
                    selectDate: widget.selectDate,
                    flagDay: widget.flagDay,
                    flagPeriodic: widget.flagPeriodic,
                    empresa_id: widget.empresa_id,
                    empresa_nome: widget.empresa_nome,
                    codTipoNfe: widget.codTipoNfe,
                    searchcontroller: widget.searchcontroller,
                  ),
                  Icons: Icons.arrow_back_ios_new_outlined)
            ]),
            Container(
              padding: EdgeInsets.all(Style.height_12(context)),
              child: Container(
                padding: EdgeInsets.all(Style.height_8(context)),
                decoration: BoxDecoration(
                    color: Style.primaryColor,
                    borderRadius:
                        BorderRadius.circular(Style.height_10(context))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Número',
                              style: TextStyle(
                                  fontSize: Style.height_10(context),
                                  color: Style.tertiaryColor),
                            ),
                            Text(
                              widget.num_doc,
                              style: TextStyle(
                                  fontSize: Style.height_20(context),
                                  color: Style.tertiaryColor,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Chave',
                              style: TextStyle(
                                  fontSize: Style.height_10(context),
                                  color: Style.tertiaryColor),
                            ),
                            Container(
                              width: Style.width_320(context),
                              child: Text(
                                widget.chv_nfe,
                                style: TextStyle(
                                  fontSize: Style.height_12(context),
                                  color: Style.tertiaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                                softWrap: true,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Série',
                              style: TextStyle(
                                  fontSize: Style.height_8(context),
                                  color: Style.tertiaryColor),
                            ),
                            Container(
                              // width: Style.width_50(context),
                              child: Text(
                                widget.serie,
                                style: TextStyle(
                                  fontSize: Style.height_12(context),
                                  color: Style.tertiaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                                softWrap: true,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Modelo',
                              style: TextStyle(
                                  fontSize: Style.height_8(context),
                                  color: Style.tertiaryColor),
                            ),
                            Container(
                              // width: Style.width_100(context),
                              child: Text(
                                widget.cod_mod,
                                style: TextStyle(
                                  fontSize: Style.height_12(context),
                                  color: Style.tertiaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                                softWrap: true,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Tipo',
                              style: TextStyle(
                                  fontSize: Style.height_8(context),
                                  color: Style.tertiaryColor),
                            ),
                            if (widget.finalidade == '1')
                              Container(
                                // width: Style.width_80(context),
                                child: Text(
                                  'Saída',
                                  style: TextStyle(
                                    fontSize: Style.height_12(context),
                                    color: Style.tertiaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                ),
                              )
                            else if (widget.finalidade == '4')
                              Container(
                                // width: Style.width_80(context),
                                child: Text(
                                  'Entrada',
                                  style: TextStyle(
                                    fontSize: Style.height_12(context),
                                    color: Style.tertiaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.clip,
                                  softWrap: true,
                                ),
                              )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Data',
                              style: TextStyle(
                                  fontSize: Style.height_8(context),
                                  color: Style.tertiaryColor),
                            ),
                            Container(
                              // width: Style.width_53(context),
                              child: Text(
                                '${DateFormat('dd/MM/yyyy').format((widget.dt_doc)).toString()}',
                                style: TextStyle(
                                  fontSize: Style.height_10(context),
                                  color: Style.tertiaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                                softWrap: true,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Status',
                              style: TextStyle(
                                  fontSize: Style.height_10(context),
                                  color: Style.tertiaryColor),
                            ),
                            Container(
                              width: Style.width_320(context),
                              child: Text(
                                widget.codigoretorno,
                                style: TextStyle(
                                  fontSize: Style.height_12(context),
                                  color: Style.tertiaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                                softWrap: true,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Retorno',
                              style: TextStyle(
                                  fontSize: Style.height_10(context),
                                  color: Style.tertiaryColor),
                            ),
                            Container(
                              width: Style.width_320(context),
                              child: Text(
                                widget.descricaoretorno,
                                style: TextStyle(
                                  fontSize: Style.height_12(context),
                                  color: Style.tertiaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                                softWrap: true,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Operação',
                              style: TextStyle(
                                  fontSize: Style.height_10(context),
                                  color: Style.tertiaryColor),
                            ),
                            Container(
                              width: Style.width_320(context),
                              child: Text(
                                widget.desc_nat_op,
                                style: TextStyle(
                                  fontSize: Style.height_12(context),
                                  color: Style.tertiaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                                softWrap: true,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(Style.height_12(context)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Emitente',
                    style: TextStyle(
                        fontSize: Style.height_10(context),
                        color: Style.quarantineColor),
                  ),
                  Text(
                    widget.em_razaosocial,
                    style: TextStyle(
                      fontSize: Style.height_15(context),
                      color: Style.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Destinatário',
                    style: TextStyle(
                      fontSize: Style.height_10(context),
                      color: Style.quarantineColor,
                    ),
                  ),
                  Text(
                    widget.dest_razaosocial,
                    style: TextStyle(
                      fontSize: Style.height_15(context),
                      color: Style.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    'Produtos',
                    style: TextStyle(
                        fontSize: Style.height_20(context),
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.all(Style.height_12(context)),
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: Style.quarantineColor),
                            borderRadius: BorderRadius.circular(
                                Style.height_10(context))),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Style.primaryColor,
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
                                    width: Style.width_180(context),
                                    height: Style.height_50(context),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                width: 2,
                                                color: const Color.fromARGB(
                                                    255, 1, 64, 106)))),
                                    child: Text(
                                      'Desc.',
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
                                      'Qtde.',
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
                                      'Vl. Unit.',
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
                                itemCount: nfeItems.length,
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
                                                    color:
                                                        Style.disabledColor))),
                                        child: Text(
                                          (nfeItems[index].codigo).toString(),
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
                                        width: Style.width_180(context),
                                        height: Style.height_50(context),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                right: BorderSide(
                                                    width: 2,
                                                    color:
                                                        Style.disabledColor))),
                                        child: Text(
                                          (nfeItems[index].nome).toString(),
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
                                                    color:
                                                        Style.disabledColor))),
                                        child: Text(
                                          (nfeItems[index].quantidade_comercial)
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
                                          currencyFormat
                                              .format(nfeItems[index]
                                                  .valor_unit_comercial)
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
            Container(
              padding: EdgeInsets.all(Style.height_25(context)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Totais',
                    style: TextStyle(
                        fontSize: Style.height_20(context),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: Style.height_10(context),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Vl. Total dos produtos: ',
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.quarantineColor,
                              ),
                            ),
                            Text(
                              'Vl. Total do IPI: ',
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.quarantineColor,
                              ),
                            ),
                            Text(
                              'Vl. Frete: ',
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.quarantineColor,
                              ),
                            ),
                            Text(
                              'Outras Despesas: ',
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.quarantineColor,
                              ),
                            ),
                            Text(
                              'Vl. Seguro: ',
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.quarantineColor,
                              ),
                            ),
                            Text(
                              'Descontos: ',
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.quarantineColor,
                              ),
                            ),
                            Text(
                              'BC. IMCS: ',
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.quarantineColor,
                              ),
                            ),
                            Text(
                              'Vl. ICMS: ',
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.quarantineColor,
                              ),
                            ),
                            Text(
                              'Vl. FCP: ',
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.quarantineColor,
                              ),
                            ),
                            Text(
                              'Vl. II: ',
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.quarantineColor,
                              ),
                            ),
                            Text(
                              'BC. ICMS ST: ',
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.quarantineColor,
                              ),
                            ),
                            Text(
                              'Vl. ICMS ST: ',
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.quarantineColor,
                              ),
                            ),
                            Text(
                              'Vl. FCP ST: ',
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.quarantineColor,
                              ),
                            ),
                            Text(
                              'Vl. COFINS: ',
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.quarantineColor,
                              ),
                            ),
                            Text(
                              'Vl. PIS: ',
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.quarantineColor,
                              ),
                            ),
                            Text(
                              'Vl. PIS ST: ',
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.quarantineColor,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              currencyFormat.format(widget.vl_merc).toString(),
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              currencyFormat.format(widget.vl_ipi).toString(),
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              currencyFormat.format(widget.vl_frete).toString(),
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              currencyFormat
                                  .format(widget.vl_out_da)
                                  .toString(),
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              currencyFormat.format(widget.vl_seg).toString(),
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              currencyFormat.format(widget.vl_desc).toString(),
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              currencyFormat
                                  .format(widget.vl_bc_icms)
                                  .toString(),
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              currencyFormat.format(widget.vl_icms).toString(),
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              currencyFormat
                                  .format(widget.vl_icmsfecp)
                                  .toString(),
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              currencyFormat.format(widget.vl_ii).toString(),
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              currencyFormat
                                  .format(widget.vl_bc_icms_st)
                                  .toString(),
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              currencyFormat
                                  .format(widget.vl_icms_st)
                                  .toString(),
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              currencyFormat
                                  .format(widget.vl_icmsfecp_st)
                                  .toString(),
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              currencyFormat
                                  .format(widget.vl_cofins)
                                  .toString(),
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              currencyFormat.format(widget.vl_pis).toString(),
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              currencyFormat
                                  .format(widget.vl_pis_st)
                                  .toString(),
                              style: TextStyle(
                                fontSize: Style.height_10(context),
                                color: Style.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(Style.height_12(context)),
              child: Container(
                padding: EdgeInsets.all(Style.height_8(context)),
                decoration: BoxDecoration(
                    // color: Style.primaryColor,
                    borderRadius:
                        BorderRadius.circular(Style.height_10(context))),
                child: Column(
                  children: [
                    Text(
                      'Valor Total',
                      style: TextStyle(
                        fontSize: Style.height_10(context),
                        color: Style.primaryColor,
                      ),
                    ),
                    Text(
                      currencyFormatDefault.format(widget.vl_doc).toString(),
                      style: TextStyle(
                        fontSize: Style.height_15(context),
                        color: Style.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // onWillPop: () async {
      //   Navigator.of(context).pushReplacement(MaterialPageRoute(
      //     builder: (context) => NfeList(selectDate: widget.selectDate, flagDay: widget.flagDay, flagPeriodic: widget.flagPeriodic, empresa_id: widget.empresa_id, empresa_nome: widget.empresa_nome, codTipoNfe: widget.codTipoNfe),
      //   ));
      //   return true;
      // })
    );
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
      await Future.wait([fetchDataNFeItems()]);
    }
    // Todos os dados foram carregados, agora atualiza o estado para parar o carregamento
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchDataNFeItems({bool? ascending}) async {
    List<NfeItems>? fetchedData = await DataServiceNfeItem.fetchDataNfeItem(
        context, urlBasic, widget.documentonfe_id);

    if (fetchedData != null) {
      setState(() {
        nfeItems = fetchedData;
        // loadingPieChart = false;
        isLoading = false;
      });
    }
  }

  // Future<void> fetchDataNfeDetails({bool? ascending}) async {
  //   Map<String, dynamic?>? fetchedData = await DataServiceNfeDetailsRequest.fetchDataNfeDetailsRequest(
  //       context,
  //       urlBasic,
  //       widget.documentonfe_id);

  //   if (fetchedData != null) {
  //     setState(() {
  //       num_doc = fetchedData['num_doc'] ?? '';
  //       chv_nfe = fetchedData['chv_nfe'] ?? '';
  //       serie = fetchedData['serie'] ?? '';
  //       dt_doc = fetchedData['dt_doc'] ?? 0.0;
  //       dt_e_s = fetchedData['dt_e_s'] ?? 0.0;
  //       vl_doc = fetchedData['vl_doc'] ?? 0.0;
  //       vl_desc = fetchedData['vl_desc'] ?? 0.0;
  //       vl_merc = fetchedData['vl_merc'] ?? 0.0;
  //       vl_frete = fetchedData['vl_frete'] ?? 0.0;
  //       vl_bc_icms = fetchedData['vl_bc_icms'] ?? 0.0;
  //       vl_icms = fetchedData['vl_icms'] ?? 0.0;
  //       vl_bc_icms_st = fetchedData['vl_bc_icms_st'] ?? 0.0;
  //       vl_icms_st = fetchedData['vl_icms_st'] ?? 0.0;
  //       vl_ipi = fetchedData['vl_ipi'] ?? 0.0;
  //       vl_cofins = fetchedData['vl_cofins'] ?? 0.0;
  //       vl_pis_st = fetchedData['vl_pis_st'] ?? 0.0;
  //       vl_cofins_st = fetchedData['vl_cofins_st'] ?? 0.0;
  //       vl_ii = fetchedData['vl_ii'] ?? 0.0;
  //       desc_nat_op = fetchedData['desc_nat_op'] ?? '';
  //       cod_mod = fetchedData['cod_mod'] ?? '';
  //       em_razaosocial = fetchedData['em_razaosocial'] ?? '';
  //       dest_razaosocial = fetchedData['dest_razaosocial'] ?? '';
  //       codigoretorno = fetchedData['codigoretorno'] ?? '';
  //       descricaoretorno = fetchedData['descricaoretorno'] ?? '';
  //       isLoading = false;
  //     });
  //   }
  // }
}
