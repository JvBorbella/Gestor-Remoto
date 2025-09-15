import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:project/Front/components/global/elements/navbar_button.dart';
import 'package:project/Front/components/global/structure/navbar.dart';
import 'package:project/Front/components/style.dart';
import 'package:project/back/nfe_info_functions/nfe_items.dart';
import 'package:project/back/nfe_info_functions/payment_nfe.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:xml/xml.dart';

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
  final em_cnpj;
  final em_cpf;
  final em_ie;
  final em_fone;
  final em_end;
  final em_num;
  final em_bairro;
  final em_mun;
  final em_uf;
  final em_cep;
  final dest_razaosocial;
  final dest_cnpj;
  final dest_cpf;
  final dest_end;
  final dest_num;
  final dest_cep;
  final dest_bairro;
  final dest_mun;
  final dest_fone;
  final dest_ie;
  final dest_uf;
  final trans_razaosocial;
  final trans_cnpj;
  final trans_cpf;
  final trans_ie;
  final trans_fone;
  final trans_end;
  final trans_num;
  final trans_mun;
  final trans_uf;
  final trans_cep;
  final trans_placa;
  final trans_placa_uf;
  final quant_volume;
  final peso_liq;
  final peso_bruto;
  final marca;
  final especie;
  final codigorastreio;
  final ind_frete;
  final codigoretorno;
  final descricaoretorno;
  final finalidade;

  final empresa_codigo;
  final empresaNome;
  final mensagem;

  final xmldistribuicao;
  //final datahoraaut;

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
    this.em_cnpj,
    this.em_cpf,
    this.em_ie,
    this.em_fone,
    this.em_end,
    this.em_num,
    this.em_bairro,
    this.em_mun,
    this.em_uf,
    this.em_cep,
    this.dest_razaosocial,
    this.dest_cnpj,
    this.dest_cpf,
    this.dest_end,
    this.dest_num,
    this.dest_cep,
    this.dest_bairro,
    this.dest_mun,
    this.dest_fone,
    this.dest_ie,
    this.dest_uf,
    this.trans_razaosocial,
    this.trans_cnpj,
    this.trans_cpf,
    this.trans_ie,
    this.trans_fone,
    this.trans_end,
    this.trans_num,
    this.trans_mun,
    this.trans_uf,
    this.trans_cep,
    this.trans_placa,
    this.trans_placa_uf,
    this.quant_volume,
    this.peso_liq,
    this.peso_bruto,
    this.marca,
    this.especie,
    this.codigorastreio,
    this.ind_frete,
    this.codigoretorno,
    this.descricaoretorno,
    this.finalidade,
    this.empresa_codigo,
    this.empresaNome,
    this.mensagem,
    this.xmldistribuicao,
    //this.datahoraaut,
  });

  @override
  State<NfeDetails> createState() => _NfeDetailsState();
}

class _NfeDetailsState extends State<NfeDetails> {
  bool isLoading = true;

  String urlBasic = '';

  final pdf = pw.Document();
  String? pdfFilePath;

  NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'pt_BR', symbol: '');

  NumberFormat currencyFormatDefault =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  final cpfMaskFormatter = MaskTextInputFormatter(mask: '###.###.###-##');
  final telMaskFormatter = MaskTextInputFormatter(mask: '(##) #####-####');
  final cnpjMaskFormatter = MaskTextInputFormatter(mask: '##.###.###/####-##');
  final chvFormatter = MaskTextInputFormatter(
      mask: '#### #### #### #### #### #### #### #### #### #### ####');

  final cepFormatter = MaskTextInputFormatter(
      mask: '#####-###', filter: {"#": RegExp(r'[0-9]')});

  List<NfeItems> nfeItems = [];
  List<PaymentNFe> paymentNfe = [];

  String protocolo = '';
  dynamic dataProtocolo;
  String qrCode = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  void extrairDadosXml(String xmlString) {
    final document = XmlDocument.parse(xmlString);

    final nProt = document.findAllElements('nProt').firstOrNull?.text ?? '';
    final dhRecbto =
        document.findAllElements('dhRecbto').firstOrNull?.text ?? '';
    final qrCodeXML =
        document.findAllElements('qrCode').firstOrNull?.text ?? '';

    setState(() {
      protocolo = nProt;
      dataProtocolo = DateTime.parse(dhRecbto).toLocal();
      qrCode = qrCodeXML;
    });

    print('Protocolo: $nProt');
    print('Data de Emissão: $dhRecbto');
    print('Data de Emissão: ${DateTime.parse(dhRecbto).toLocal()}');
    print('QR Code: $qrCode');
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
        child: WillPopScope(
            child: Scaffold(
              body: ListView(
                children: [
                  Navbar(text: 'Detalhes da Nota', children: [
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NavbarButton(
                            volta: 'volta', Icons: Icons.arrow_back_ios_new),
                        IconButton(
                          onPressed: () {
                            if (widget.codigoretorno == '100') {
                              generateAndOpenPdf();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  padding: EdgeInsets.all(
                                      Style.SaveUrlMessagePadding(context)),
                                  content: Text(
                                    'A nota ainda não foi autorizada',
                                    style: TextStyle(
                                      fontSize:
                                          Style.SaveUrlMessageSize(context),
                                      color: Style.tertiaryColor,
                                    ),
                                  ),
                                  backgroundColor: Style.errorColor,
                                ),
                              );
                            }
                          },
                          icon: Icon(Icons.picture_as_pdf_rounded),
                          color: Style.tertiaryColor,
                        ),
                      ],
                    ))
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
                                      chvFormatter.maskText(widget.chv_nfe),
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
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
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
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
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
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              1,
                                                              64,
                                                              106)))),
                                          child: Text(
                                            'Código',
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
                                          width: Style.width_180(context),
                                          height: Style.height_50(context),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  right: BorderSide(
                                                      width: 2,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              1,
                                                              64,
                                                              106)))),
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
                                          width: Style.height_30(context),
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  right: BorderSide(
                                                      width: 2,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              1,
                                                              64,
                                                              106)))),
                                          child: Text(
                                            'Qtde.',
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
                                            'Vl. Unit.',
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
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .tertiary))),
                                              child: Text(
                                                (nfeItems[index].codigo)
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize:
                                                        Style.height_8(context),
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
                                              width: Style.width_180(context),
                                              height: Style.height_50(context),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      right: BorderSide(
                                                          width: 2,
                                                          color: Theme.of(context)
                                                                  .colorScheme
                                                                  .tertiary))),
                                              child: Text(
                                                (nfeItems[index].nome)
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize:
                                                        Style.height_8(context),
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
                                              width: Style.height_30(context),
                                              height: Style.height_50(context),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      right: BorderSide(
                                                          width: 2,
                                                          color: Theme.of(context)
                                                                  .colorScheme
                                                                  .tertiary))),
                                              child: Text(
                                                (nfeItems[index]
                                                        .quantidade_comercial)
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize:
                                                        Style.height_8(context),
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
                                              height: Style.height_50(context),
                                              decoration: BoxDecoration(),
                                              child: Text(
                                                currencyFormat
                                                    .format(nfeItems[index]
                                                        .valor_unit_comercial)
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize:
                                                        Style.height_8(context),
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                  Text(
                                    'Vl. Total do IPI: ',
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                  Text(
                                    'Vl. Frete: ',
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                  Text(
                                    'Outras Despesas: ',
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                  Text(
                                    'Vl. Seguro: ',
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                  Text(
                                    'Descontos: ',
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                  Text(
                                    'BC. IMCS: ',
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                  Text(
                                    'Vl. ICMS: ',
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                  Text(
                                    'Vl. FCP: ',
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                  Text(
                                    'Vl. II: ',
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                  Text(
                                    'BC. ICMS ST: ',
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                  Text(
                                    'Vl. ICMS ST: ',
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                  Text(
                                    'Vl. FCP ST: ',
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                  Text(
                                    'Vl. COFINS: ',
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                  Text(
                                    'Vl. PIS: ',
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                  Text(
                                    'Vl. PIS ST: ',
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    currencyFormat
                                        .format(widget.vl_merc)
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    currencyFormat
                                        .format(widget.vl_ipi)
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    currencyFormat
                                        .format(widget.vl_frete)
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    currencyFormat
                                        .format(widget.vl_out_da)
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    currencyFormat
                                        .format(widget.vl_seg)
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    currencyFormat
                                        .format(widget.vl_desc)
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    currencyFormat
                                        .format(widget.vl_bc_icms)
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    currencyFormat
                                        .format(widget.vl_icms)
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    currencyFormat
                                        .format(widget.vl_icmsfecp)
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    currencyFormat
                                        .format(widget.vl_ii)
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    currencyFormat
                                        .format(widget.vl_bc_icms_st)
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    currencyFormat
                                        .format(widget.vl_icms_st)
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    currencyFormat
                                        .format(widget.vl_icmsfecp_st)
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    currencyFormat
                                        .format(widget.vl_cofins)
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    currencyFormat
                                        .format(widget.vl_pis)
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    currencyFormat
                                        .format(widget.vl_pis_st)
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: Style.height_10(context),
                                      color:
                                          Theme.of(context).colorScheme.primary,
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
                          // color: Theme.of(context).colorScheme.primary,
                          borderRadius:
                              BorderRadius.circular(Style.height_10(context))),
                      child: Column(
                        children: [
                          Text(
                            'Valor Total',
                            style: TextStyle(
                              fontSize: Style.height_10(context),
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          Text(
                            currencyFormatDefault
                                .format(widget.vl_doc)
                                .toString(),
                            style: TextStyle(
                              fontSize: Style.height_15(context),
                              color: Theme.of(context).colorScheme.primary,
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
            onWillPop: () async {
              // Navigator.of(context).pushReplacement(MaterialPageRoute(
              //   builder: (context) => NfeList(selectDate: widget.selectDate, flagDay: widget.flagDay, flagPeriodic: widget.flagPeriodic, empresa_id: widget.empresa_id, empresa_nome: widget.empresa_nome, codTipoNfe: widget.codTipoNfe),
              // ));
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

  Future<void> loadData() async {
    await Future.wait([
      _loadSavedUrlBasic(),
    ]);

    extrairDadosXml(widget.xmldistribuicao);

    if (urlBasic.isNotEmpty) {
      await Future.wait([fetchDataNFeItems()]);
      await Future.wait([fetchDataPaymentNFe()]);
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

  Future<void> fetchDataPaymentNFe({bool? ascending}) async {
    List<PaymentNFe>? fetchedData =
        await DataServicePaymentNFe.fetchDataPaymentNFe(
            context, urlBasic, widget.documentonfe_id);

    if (fetchedData != null) {
      setState(() {
        paymentNfe = fetchedData;
        // loadingPieChart = false;
        isLoading = false;
      });
    }
  }

  Future<void> generateAndOpenPdf() async {
    final TimesNewRoman =
        pw.Font.ttf(await rootBundle.load('assets/fonts/times.ttf'));
    // final NotoSansMono = pw.Font.ttf(
    //     await rootBundle.load('assets/fonts/NotoSansMono-Regular.ttf'));
    // final SpaceMono = pw.Font.ttf(
    //     await rootBundle.load('assets/fonts/SpaceMono-Regular.ttf'));
    final pdf = pw.Document();

    if (widget.cod_mod == '55') {
      pdf.addPage(
        pw.MultiPage(
            pageFormat: PdfPageFormat.a4,
            margin: pw.EdgeInsets.all(10),
            header: (pw.Context context) => pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      if (context.pageNumber == 1) ...[
                        pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            children: [
                              pw.Column(children: [
                                pw.Row(children: [
                                  pw.Container(
                                    width: 491,
                                    height: 32,
                                    padding: pw.EdgeInsets.all(5),
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all()),
                                    child: pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.center,
                                      children: [
                                        pw.Text(
                                            "RECEBEMOS DE ${widget.em_razaosocial} OS PRODUTOS / SERVIÇOS CONSTANTES DA NOTA FISCAL INDICADO AO LADO",
                                            style: pw.TextStyle(
                                                fontSize: 6,
                                                font: TimesNewRoman),
                                            textAlign: pw.TextAlign.center),
                                        pw.Text(
                                            "EMISSÃO: ${DateFormat('dd/MM/yyyy').format(widget.dt_e_s)}  -  DEST. / REM.: ${widget.dest_razaosocial}  -  VALOR TOTAL: ${currencyFormatDefault.format(widget.vl_doc)}",
                                            style: pw.TextStyle(
                                                fontSize: 6,
                                                font: TimesNewRoman),
                                            textAlign: pw.TextAlign.center),
                                      ],
                                    ),
                                  ),
                                ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    mainAxisSize: pw.MainAxisSize.max,
                                    children: [
                                      pw.Container(
                                        width: 171,
                                        height: 37,
                                        padding: pw.EdgeInsets.all(5),
                                        decoration: pw.BoxDecoration(
                                            border: pw.Border.all()),
                                        child: pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text("DATA DE RECEBIMENTO",
                                                style: pw.TextStyle(
                                                    fontSize: 4,
                                                    font: TimesNewRoman)),
                                          ],
                                        ),
                                      ),
                                      pw.Container(
                                        width: 319,
                                        height: 37,
                                        padding: pw.EdgeInsets.all(5),
                                        decoration: pw.BoxDecoration(
                                            border: pw.Border.all()),
                                        child: pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Text(
                                                "IDENTIFICAÇÃO E ASSINATURA DO RECEBEDOR",
                                                style: pw.TextStyle(
                                                    fontSize: 4,
                                                    font: TimesNewRoman)),
                                          ],
                                        ),
                                      ),
                                    ]),
                              ]),
                              pw.Column(children: [
                                pw.Container(
                                  width: 84,
                                  height: 68,
                                  padding: pw.EdgeInsets.all(5),
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  child: pw.Center(
                                    child: pw.Column(
                                      mainAxisAlignment:
                                          pw.MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.center,
                                      children: [
                                        pw.Text("NF-e",
                                            style: pw.TextStyle(
                                                font: TimesNewRoman),
                                            textAlign: pw.TextAlign.center),
                                        pw.Text(
                                            "Nº ${widget.num_doc.toString().padLeft(5, '000.')}",
                                            style: pw.TextStyle(
                                                font: TimesNewRoman,
                                                fontWeight: pw.FontWeight.bold),
                                            textAlign: pw.TextAlign.center),
                                        pw.Text(
                                            "SÉRIE ${widget.serie.toString().padLeft(3, '0')}",
                                            style: pw.TextStyle(
                                                font: TimesNewRoman),
                                            textAlign: pw.TextAlign.center),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ]),
                        pw.Divider(),
                      ],
                      pw.Row(children: [
                        pw.Column(children: [
                          pw.Container(
                            width: 215,
                            height: 90,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              //crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Row(children: [
                                  pw.Text("IDENTIFICAÇAO DO EMITENTE",
                                      style: pw.TextStyle(
                                          fontSize: 6, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 15),
                                pw.Center(
                                  child: pw.Text('${widget.em_razaosocial}',
                                      style: pw.TextStyle(
                                          font: TimesNewRoman,
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 8),
                                      textAlign: pw.TextAlign.center,
                                      softWrap: true,
                                      overflow: pw.TextOverflow.clip),
                                ),
                                pw.SizedBox(height: 5),
                                pw.Text(
                                    "${widget.em_end}, ${widget.em_num} - ${widget.em_bairro} -  ${'CEP: ' + cepFormatter.maskText(widget.em_cep)} - ${widget.em_mun} - ${widget.em_uf} '${'TEL.:' + telMaskFormatter.maskText(widget.em_fone)}",
                                    style: pw.TextStyle(
                                        fontSize: 7, font: TimesNewRoman),
                                    softWrap: true,
                                    overflow: pw.TextOverflow.clip,
                                    textAlign: pw.TextAlign.left),
                              ],
                            ),
                          ),
                        ]),
                        pw.Column(children: [
                          pw.Container(
                            width: 140,
                            height: 90,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              //crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Center(
                                  child: pw.Text("DANFE",
                                      style: pw.TextStyle(
                                          font: TimesNewRoman,
                                          fontSize: 10,
                                          fontWeight: pw.FontWeight.bold)),
                                ),
                                pw.SizedBox(height: 2),
                                pw.Text(
                                    "DOCUMENTO AUXILIAR DA NOTA FISCAL ELETRÔNICA",
                                    style: pw.TextStyle(
                                        font: TimesNewRoman,
                                        fontSize: 7,
                                        fontWeight: pw.FontWeight.bold),
                                    textAlign: pw.TextAlign.center),
                                pw.SizedBox(height: 5),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceAround,
                                    children: [
                                      pw.Column(children: [
                                        pw.Row(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            children: [
                                              pw.Text('0 - ENTRADA',
                                                  style: pw.TextStyle(
                                                      fontSize: 6,
                                                      font: TimesNewRoman),
                                                  textAlign: pw.TextAlign.left)
                                            ]),
                                        pw.Row(
                                            mainAxisAlignment:
                                                pw.MainAxisAlignment.start,
                                            children: [
                                              pw.Text('1 - SAÍDA',
                                                  style: pw.TextStyle(
                                                      fontSize: 6,
                                                      font: TimesNewRoman),
                                                  textAlign: pw.TextAlign.left)
                                            ]),
                                      ]),
                                      pw.Column(children: [
                                        pw.Container(
                                            width: 15,
                                            height: 15,
                                            padding: pw.EdgeInsets.all(2),
                                            decoration: pw.BoxDecoration(
                                                border:
                                                    pw.Border.all(width: 1)),
                                            child: pw.Center(
                                                child: pw.Text(
                                                    '${widget.finalidade}',
                                                    style: pw.TextStyle(
                                                        fontSize: 9,
                                                        font: TimesNewRoman),
                                                    textAlign:
                                                        pw.TextAlign.center)))
                                      ]),
                                    ]),
                                pw.SizedBox(height: 5),
                                pw.Text(
                                    "Nº ${widget.num_doc.toString().padLeft(5, '000.')}    fl. ${context.pageNumber} /${context.pagesCount}",
                                    style: pw.TextStyle(
                                        font: TimesNewRoman,
                                        fontSize: 8,
                                        fontWeight: pw.FontWeight.bold),
                                    textAlign: pw.TextAlign.center),
                                pw.Text(
                                    "SÉRIE ${widget.serie.toString().padLeft(3, '0')}",
                                    style: pw.TextStyle(
                                        fontSize: 8, font: TimesNewRoman),
                                    textAlign: pw.TextAlign.center),
                              ],
                            ),
                          ),
                        ]),
                        pw.Column(children: [
                          pw.Row(children: [
                            pw.Container(
                              width: 220,
                              height: 30,
                              padding: pw.EdgeInsets.all(5),
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Column(
                                //crossAxisAlignment: pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Center(
                                    child: pw.BarcodeWidget(
                                      barcode: pw.Barcode.code128(),
                                      drawText: false,
                                      data: chvFormatter.maskText(widget
                                          .chv_nfe), // Substituir pelo link real da SEFAZ
                                      width: 200,
                                      height: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          pw.Row(children: [
                            pw.Container(
                              width: 220,
                              height: 30,
                              padding: pw.EdgeInsets.all(5),
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Column(
                                //crossAxisAlignment: pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Row(children: [
                                    pw.Text("CHAVE DE ACESSO",
                                        style: pw.TextStyle(
                                            fontSize: 4, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.left),
                                  ]),
                                  pw.SizedBox(height: 4),
                                  pw.Center(
                                    child: pw.Text(
                                        '${chvFormatter.maskText(widget.chv_nfe)}',
                                        style: pw.TextStyle(
                                            fontSize: 7, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.center,
                                        softWrap: true,
                                        overflow: pw.TextOverflow.clip),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          pw.Row(children: [
                            pw.Container(
                              width: 220,
                              height: 30,
                              padding: pw.EdgeInsets.all(5),
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Column(
                                //crossAxisAlignment: pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Text(
                                      'Consulta de autenticidade no portal nacional da NF-e www.nfe.fazenda.gov.br/portal ou no site da Sefaz Autorizadora',
                                      style: pw.TextStyle(
                                          fontSize: 7, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.center,
                                      softWrap: true,
                                      overflow: pw.TextOverflow.clip)
                                ],
                              ),
                            ),
                          ]),
                        ]),
                      ]),
                      pw.Row(children: [
                        pw.Column(children: [
                          pw.Container(
                            width: 355,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              //crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Row(children: [
                                  pw.Text("NATUREZA DE OPERAÇÃO",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(children: [
                                  pw.Text('${widget.desc_nat_op}',
                                      style: pw.TextStyle(
                                          fontSize: 8, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left,
                                      softWrap: true,
                                      overflow: pw.TextOverflow.clip),
                                ])
                              ],
                            ),
                          ),
                        ]),
                        pw.Column(children: [
                          pw.Container(
                            width: 220,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              //crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Row(children: [
                                  pw.Text("PROTOCOLO DE AUTORIZAÇÃO DE USO",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(children: [
                                  pw.Text('${protocolo}',
                                      style: pw.TextStyle(
                                          fontSize: 8, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left,
                                      softWrap: true,
                                      overflow: pw.TextOverflow.clip),
                                  pw.SizedBox(width: 4),
                                  pw.Text(
                                      '${dataProtocolo != null ? DateFormat('dd/MM/yyyy hh:mm:ss').format(dataProtocolo) : ''}',
                                      style: pw.TextStyle(
                                          fontSize: 8, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left,
                                      softWrap: true,
                                      overflow: pw.TextOverflow.clip),
                                ])
                              ],
                            ),
                          ),
                        ])
                      ]),
                      pw.Row(children: [
                        pw.Column(children: [
                          pw.Container(
                            width: 191,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              //crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Row(children: [
                                  pw.Text("iNSCRIÇÃO ESTADUAL",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(children: [
                                  pw.Text('${widget.em_ie}',
                                      style: pw.TextStyle(
                                          fontSize: 8, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left,
                                      softWrap: true,
                                      overflow: pw.TextOverflow.clip),
                                ])
                              ],
                            ),
                          ),
                        ]),
                        pw.Column(children: [
                          pw.Container(
                            width: 191,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              //crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Row(children: [
                                  pw.Text("INSCRIÇÃO ESTADUAL DO SUBST. TRIB.",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                              ],
                            ),
                          ),
                        ]),
                        pw.Column(children: [
                          pw.Container(
                            width: 193,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              //crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Row(children: [
                                  pw.Text("CNPJ/CPF",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(children: [
                                  pw.Text(
                                      widget.em_cnpj.isEmpty
                                          ? cpfMaskFormatter
                                              .maskText(widget.em_cpf)
                                          : cnpjMaskFormatter
                                              .maskText(widget.em_cnpj),
                                      style: pw.TextStyle(
                                          fontSize: 8, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left,
                                      softWrap: true,
                                      overflow: pw.TextOverflow.clip),
                                ])
                              ],
                            ),
                          ),
                        ]),
                      ]),
                      pw.SizedBox(height: 5),
                      if (context.pageNumber == 1) ...[
                        pw.Text('DESTINATÁRIO / REMETENTE',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 9,
                                font: TimesNewRoman)),
                        pw.Row(children: [
                          pw.Column(children: [
                            pw.Container(
                              width: 375,
                              height: 30,
                              padding: pw.EdgeInsets.all(5),
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Column(
                                //crossAxisAlignment: pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Row(children: [
                                    pw.Text("NOME/RAZÃO SOCIAL",
                                        style: pw.TextStyle(
                                            fontSize: 4, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.left),
                                  ]),
                                  pw.SizedBox(height: 4),
                                  pw.Row(children: [
                                    pw.Text('${widget.dest_razaosocial}',
                                        style: pw.TextStyle(
                                            fontSize: 8, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.left,
                                        softWrap: true,
                                        overflow: pw.TextOverflow.clip),
                                  ])
                                ],
                              ),
                            ),
                          ]),
                          pw.Column(children: [
                            pw.Container(
                              width: 100,
                              height: 30,
                              padding: pw.EdgeInsets.all(5),
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Column(
                                //crossAxisAlignment: pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Row(children: [
                                    pw.Text("CNPJ/CPF",
                                        style: pw.TextStyle(
                                            fontSize: 4, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.left),
                                  ]),
                                  pw.SizedBox(height: 4),
                                  pw.Row(children: [
                                    pw.Text(
                                        widget.dest_cnpj.isEmpty
                                            ? cpfMaskFormatter
                                                .maskText(widget.dest_cpf)
                                            : cnpjMaskFormatter
                                                .maskText(widget.dest_cnpj),
                                        style: pw.TextStyle(
                                            fontSize: 8, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.left,
                                        softWrap: true,
                                        overflow: pw.TextOverflow.clip),
                                  ])
                                ],
                              ),
                            ),
                          ]),
                          pw.Column(children: [
                            pw.Container(
                              width: 100,
                              height: 30,
                              padding: pw.EdgeInsets.all(5),
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Column(
                                //crossAxisAlignment: pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Row(children: [
                                    pw.Text("DATA DE EMISSÃO",
                                        style: pw.TextStyle(
                                            fontSize: 4, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.left),
                                  ]),
                                  pw.SizedBox(height: 4),
                                  pw.Row(children: [
                                    pw.Text(
                                        '${DateFormat('dd/MM/yyyy').format(widget.dt_e_s)}',
                                        style: pw.TextStyle(
                                            fontSize: 8, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.left,
                                        softWrap: true,
                                        overflow: pw.TextOverflow.clip),
                                  ])
                                ],
                              ),
                            ),
                          ]),
                        ]),
                        pw.Row(children: [
                          pw.Column(children: [
                            pw.Container(
                              width: 265,
                              height: 30,
                              padding: pw.EdgeInsets.all(5),
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Column(
                                //crossAxisAlignment: pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Row(children: [
                                    pw.Text("ENDEREÇO",
                                        style: pw.TextStyle(
                                            fontSize: 4, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.left),
                                  ]),
                                  pw.SizedBox(height: 4),
                                  pw.Row(children: [
                                    pw.Text(
                                        '${widget.dest_end}, ${widget.dest_num}',
                                        style: pw.TextStyle(
                                            fontSize: 8, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.left,
                                        softWrap: true,
                                        overflow: pw.TextOverflow.clip),
                                  ])
                                ],
                              ),
                            ),
                          ]),
                          pw.Column(children: [
                            pw.Container(
                              width: 150,
                              height: 30,
                              padding: pw.EdgeInsets.all(5),
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Column(
                                //crossAxisAlignment: pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Row(children: [
                                    pw.Text("BAIRRO/DISTRITO",
                                        style: pw.TextStyle(
                                            fontSize: 4, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.left),
                                  ]),
                                  pw.SizedBox(height: 4),
                                  pw.Row(children: [
                                    pw.Text('${widget.dest_bairro}',
                                        style: pw.TextStyle(
                                            fontSize: 8, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.left,
                                        softWrap: true,
                                        overflow: pw.TextOverflow.clip),
                                  ])
                                ],
                              ),
                            ),
                          ]),
                          pw.Column(children: [
                            pw.Container(
                              width: 60,
                              height: 30,
                              padding: pw.EdgeInsets.all(5),
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Column(
                                //crossAxisAlignment: pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Row(children: [
                                    pw.Text("CEP",
                                        style: pw.TextStyle(
                                            fontSize: 4, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.left),
                                  ]),
                                  pw.SizedBox(height: 4),
                                  pw.Row(children: [
                                    pw.Text(
                                        '${cepFormatter.maskText(widget.dest_cep)}',
                                        style: pw.TextStyle(
                                            fontSize: 8, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.left,
                                        softWrap: true,
                                        overflow: pw.TextOverflow.clip),
                                  ])
                                ],
                              ),
                            ),
                          ]),
                          pw.Column(children: [
                            pw.Container(
                              width: 100,
                              height: 30,
                              padding: pw.EdgeInsets.all(5),
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Column(
                                //crossAxisAlignment: pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Row(children: [
                                    pw.Text("DATA SAÍDA/ENTRADA",
                                        style: pw.TextStyle(
                                            fontSize: 4, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.left),
                                  ]),
                                  pw.SizedBox(height: 4),
                                  pw.Row(children: [
                                    pw.Text(
                                        '${DateFormat('dd/MM/yyyy').format(widget.dt_e_s)}',
                                        style: pw.TextStyle(
                                            fontSize: 8, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.left,
                                        softWrap: true,
                                        overflow: pw.TextOverflow.clip),
                                  ])
                                ],
                              ),
                            ),
                          ]),
                        ]),
                        pw.Row(children: [
                          pw.Column(children: [
                            pw.Container(
                              width: 195,
                              height: 30,
                              padding: pw.EdgeInsets.all(5),
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Column(
                                //crossAxisAlignment: pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Row(children: [
                                    pw.Text("MUNICÍPIO",
                                        style: pw.TextStyle(
                                            fontSize: 4, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.left),
                                  ]),
                                  pw.SizedBox(height: 4),
                                  pw.Row(children: [
                                    pw.Text('${widget.dest_mun}',
                                        style: pw.TextStyle(
                                            fontSize: 8, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.left,
                                        softWrap: true,
                                        overflow: pw.TextOverflow.clip),
                                  ])
                                ],
                              ),
                            ),
                          ]),
                          pw.Column(children: [
                            pw.Container(
                              width: 150,
                              height: 30,
                              padding: pw.EdgeInsets.all(5),
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Column(
                                //crossAxisAlignment: pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Row(children: [
                                    pw.Text("FONE/FAX",
                                        style: pw.TextStyle(
                                            fontSize: 4, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.left),
                                  ]),
                                  pw.SizedBox(height: 4),
                                  pw.Row(children: [
                                    pw.Text('${widget.dest_fone}',
                                        style: pw.TextStyle(
                                            fontSize: 8, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.left,
                                        softWrap: true,
                                        overflow: pw.TextOverflow.clip),
                                  ])
                                ],
                              ),
                            ),
                          ]),
                          pw.Column(children: [
                            pw.Container(
                              width: 30,
                              height: 30,
                              padding: pw.EdgeInsets.all(5),
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Column(
                                //crossAxisAlignment: pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Row(children: [
                                    pw.Text("UF",
                                        style: pw.TextStyle(
                                            fontSize: 4, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.left),
                                  ]),
                                  pw.SizedBox(height: 4),
                                  pw.Row(children: [
                                    pw.Text('${widget.dest_uf}',
                                        style: pw.TextStyle(
                                            fontSize: 8, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.left,
                                        softWrap: true,
                                        overflow: pw.TextOverflow.clip),
                                  ])
                                ],
                              ),
                            ),
                          ]),
                          pw.Column(children: [
                            pw.Container(
                              width: 100,
                              height: 30,
                              padding: pw.EdgeInsets.all(5),
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Column(
                                //crossAxisAlignment: pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Row(children: [
                                    pw.Text("INSCRIÇÃO ESTADUAL",
                                        style: pw.TextStyle(
                                            fontSize: 4, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.left),
                                  ]),
                                  pw.SizedBox(height: 4),
                                  pw.Row(children: [
                                    pw.Text('${widget.dest_ie}',
                                        style: pw.TextStyle(
                                            fontSize: 8, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.left,
                                        softWrap: true,
                                        overflow: pw.TextOverflow.clip),
                                  ])
                                ],
                              ),
                            ),
                          ]),
                          pw.Column(children: [
                            pw.Container(
                              width: 100,
                              height: 30,
                              padding: pw.EdgeInsets.all(5),
                              decoration:
                                  pw.BoxDecoration(border: pw.Border.all()),
                              child: pw.Column(
                                //crossAxisAlignment: pw.CrossAxisAlignment.center,
                                children: [
                                  pw.Row(children: [
                                    pw.Text("HORA DA SAÍDA",
                                        style: pw.TextStyle(
                                            fontSize: 4, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.left),
                                  ]),
                                  pw.SizedBox(height: 4),
                                  pw.Row(children: [
                                    pw.Text(
                                        '${DateFormat('HH:mm:ss').format(widget.dt_e_s)}',
                                        style: pw.TextStyle(
                                            fontSize: 8, font: TimesNewRoman),
                                        textAlign: pw.TextAlign.left,
                                        softWrap: true,
                                        overflow: pw.TextOverflow.clip),
                                  ])
                                ],
                              ),
                            ),
                          ]),
                        ])
                      ],
                      if (context.pageNumber == 1) ...[
                        pw.SizedBox(height: 5),
                        pw.Text('CÁLCULO DO IMPOSTO',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 9,
                                font: TimesNewRoman)),
                        pw.Row(children: [
                          pw.Container(
                            width: 103.75,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              //crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Row(children: [
                                  pw.Text("BASE DE CÁLCULO DO ICMS",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.end,
                                    children: [
                                      pw.Text(
                                          '${currencyFormat.format(widget.vl_bc_icms)}',
                                          style: pw.TextStyle(
                                              fontSize: 8, font: TimesNewRoman),
                                          textAlign: pw.TextAlign.left,
                                          softWrap: true,
                                          overflow: pw.TextOverflow.clip),
                                    ])
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 103.75,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              //crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Row(children: [
                                  pw.Text("VALOR DO ICMS",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.end,
                                    children: [
                                      pw.Text(
                                          '${currencyFormat.format(widget.vl_icms)}',
                                          style: pw.TextStyle(
                                              fontSize: 8, font: TimesNewRoman),
                                          textAlign: pw.TextAlign.left,
                                          softWrap: true,
                                          overflow: pw.TextOverflow.clip),
                                    ])
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 103.75,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              //crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Row(children: [
                                  pw.Text("BASE CÁLC. ICMS SUBST",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.end,
                                    children: [
                                      pw.Text(
                                          '${currencyFormat.format(widget.vl_bc_icms_st)}',
                                          style: pw.TextStyle(
                                              fontSize: 8, font: TimesNewRoman),
                                          textAlign: pw.TextAlign.left,
                                          softWrap: true,
                                          overflow: pw.TextOverflow.clip),
                                    ])
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 103.75,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              //crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Row(children: [
                                  pw.Text("VALOR DO ICMS SUBST.",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.end,
                                    children: [
                                      pw.Text(
                                          '${currencyFormat.format(widget.vl_icms_st)}',
                                          style: pw.TextStyle(
                                              fontSize: 8, font: TimesNewRoman),
                                          textAlign: pw.TextAlign.left,
                                          softWrap: true,
                                          overflow: pw.TextOverflow.clip),
                                    ])
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 160,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              //crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Row(children: [
                                  pw.Text("VALOR TOTAL DOS PRODUTOS",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.end,
                                    children: [
                                      pw.Text(
                                          '${currencyFormat.format(widget.vl_merc)}',
                                          style: pw.TextStyle(
                                              fontSize: 8, font: TimesNewRoman),
                                          textAlign: pw.TextAlign.left,
                                          softWrap: true,
                                          overflow: pw.TextOverflow.clip),
                                    ])
                              ],
                            ),
                          ),
                        ]),
                        pw.Row(children: [
                          pw.Container(
                            width: 83,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              //crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Row(children: [
                                  pw.Text("VALOR DO FRETE",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.end,
                                    children: [
                                      pw.Text(
                                          '${currencyFormat.format(widget.vl_frete)}',
                                          style: pw.TextStyle(
                                              fontSize: 8, font: TimesNewRoman),
                                          textAlign: pw.TextAlign.left,
                                          softWrap: true,
                                          overflow: pw.TextOverflow.clip),
                                    ])
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 83,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              //crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Row(children: [
                                  pw.Text("VALOR DO SEGURO",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.end,
                                    children: [
                                      pw.Text(
                                          '${currencyFormat.format(widget.vl_seg)}',
                                          style: pw.TextStyle(
                                              fontSize: 8, font: TimesNewRoman),
                                          textAlign: pw.TextAlign.left,
                                          softWrap: true,
                                          overflow: pw.TextOverflow.clip),
                                    ])
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 83,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              //crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Row(children: [
                                  pw.Text("DESCONTO",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.end,
                                    children: [
                                      pw.Text(
                                          '${currencyFormat.format(widget.vl_desc)}',
                                          style: pw.TextStyle(
                                              fontSize: 8, font: TimesNewRoman),
                                          textAlign: pw.TextAlign.left,
                                          softWrap: true,
                                          overflow: pw.TextOverflow.clip),
                                    ])
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 83,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              //crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Row(children: [
                                  pw.Text("OUTRAS DESP. ACESS.",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.end,
                                    children: [
                                      pw.Text(
                                          '${currencyFormat.format(widget.vl_out_da)}',
                                          style: pw.TextStyle(
                                              fontSize: 8, font: TimesNewRoman),
                                          textAlign: pw.TextAlign.left,
                                          softWrap: true,
                                          overflow: pw.TextOverflow.clip),
                                    ])
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 83,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              //crossAxisAlignment: pw.CrossAxisAlignment.center,
                              children: [
                                pw.Row(children: [
                                  pw.Text("VALOR DO IPI",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.end,
                                    children: [
                                      pw.Text(
                                          '${currencyFormat.format(widget.vl_ipi)}',
                                          style: pw.TextStyle(
                                              fontSize: 8, font: TimesNewRoman),
                                          textAlign: pw.TextAlign.left,
                                          softWrap: true,
                                          overflow: pw.TextOverflow.clip),
                                    ])
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 160,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(),
                                color: PdfColor.fromInt(0xffdcdcdc)),
                            child: pw.Column(
                              children: [
                                pw.Row(children: [
                                  pw.Text("VALOR TOTAL DA NOTA",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(
                                    mainAxisAlignment: pw.MainAxisAlignment.end,
                                    children: [
                                      pw.Text(
                                          '${currencyFormat.format(widget.vl_doc)}',
                                          style: pw.TextStyle(
                                              fontSize: 8, font: TimesNewRoman),
                                          textAlign: pw.TextAlign.left,
                                          softWrap: true,
                                          overflow: pw.TextOverflow.clip),
                                    ])
                              ],
                            ),
                          ),
                        ]),
                      ],
                      if (context.pageNumber == 1) ...[
                        pw.SizedBox(height: 5),
                        pw.Text('TRANSPORTADOR / VOLUMES TRANSPORTADOS',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 9,
                                font: TimesNewRoman)),
                        pw.Row(children: [
                          pw.Container(
                            width: 180,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              children: [
                                pw.Row(children: [
                                  pw.Text("RAZÃO SOCIAL",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(children: [
                                  pw.Text(widget.trans_razaosocial,
                                      style: pw.TextStyle(
                                          fontSize: 8, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left,
                                      softWrap: true,
                                      overflow: pw.TextOverflow.clip),
                                ])
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 88.66,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              children: [
                                pw.Row(children: [
                                  pw.Text("FRETE POR CONTA",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(children: [
                                  pw.Text(
                                      widget.ind_frete == 0
                                          ? '${widget.ind_frete} - REMETENTE'
                                          : '${widget.ind_frete} - CONSUMIDOR',
                                      style: pw.TextStyle(
                                          fontSize: 8, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left,
                                      softWrap: true,
                                      overflow: pw.TextOverflow.clip),
                                ])
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 88.66,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              children: [
                                pw.Row(children: [
                                  pw.Text("CÓDIGO ANTT",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(children: [
                                  pw.Text('${widget.codigorastreio}',
                                      style: pw.TextStyle(
                                          fontSize: 8, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left,
                                      softWrap: true,
                                      overflow: pw.TextOverflow.clip),
                                ])
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 88.66,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              children: [
                                pw.Row(children: [
                                  pw.Text("PLACA DO VEÍCULO",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(children: [
                                  pw.Text(widget.trans_placa,
                                      style: pw.TextStyle(
                                          fontSize: 8, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left,
                                      softWrap: true,
                                      overflow: pw.TextOverflow.clip),
                                ])
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 30,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              children: [
                                pw.Row(children: [
                                  pw.Text("UF",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(children: [
                                  pw.Text(widget.trans_placa_uf,
                                      style: pw.TextStyle(
                                          fontSize: 8, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left,
                                      softWrap: true,
                                      overflow: pw.TextOverflow.clip),
                                ])
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 99,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              children: [
                                pw.Row(children: [
                                  pw.Text("CNPJ/CPF",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(children: [
                                  pw.Text(
                                      widget.trans_cnpj.isNotEmpty
                                          ? cnpjMaskFormatter
                                              .maskText(widget.trans_cnpj)
                                          : cpfMaskFormatter
                                              .maskText(widget.trans_cpf),
                                      style: pw.TextStyle(
                                          fontSize: 8, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left,
                                      softWrap: true,
                                      overflow: pw.TextOverflow.clip),
                                ])
                              ],
                            ),
                          ),
                        ]),
                        pw.Row(children: [
                          pw.Container(
                            width: 333,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              children: [
                                pw.Row(children: [
                                  pw.Text("ENDEREÇO",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(children: [
                                  pw.Text(widget.trans_end,
                                      style: pw.TextStyle(
                                          fontSize: 8, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left,
                                      softWrap: true,
                                      overflow: pw.TextOverflow.clip),
                                ])
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 113,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              children: [
                                pw.Row(children: [
                                  pw.Text("MUNICÍPIO",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(children: [
                                  pw.Text(widget.trans_mun,
                                      style: pw.TextStyle(
                                          fontSize: 8, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left,
                                      softWrap: true,
                                      overflow: pw.TextOverflow.clip),
                                ])
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 30,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              children: [
                                pw.Row(children: [
                                  pw.Text("UF",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(children: [
                                  pw.Text(widget.trans_uf,
                                      style: pw.TextStyle(
                                          fontSize: 8, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left,
                                      softWrap: true,
                                      overflow: pw.TextOverflow.clip),
                                ])
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 99,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              children: [
                                pw.Row(children: [
                                  pw.Text("INSCRIÇÃO ESTADUAL",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(children: [
                                  pw.Text(widget.trans_ie,
                                      style: pw.TextStyle(
                                          fontSize: 8, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left,
                                      softWrap: true,
                                      overflow: pw.TextOverflow.clip),
                                ])
                              ],
                            ),
                          ),
                        ]),
                        pw.Row(children: [
                          pw.Container(
                            width: 80,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              children: [
                                pw.Row(children: [
                                  pw.Text("QUANTIDADE",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(children: [
                                  pw.Text(widget.quant_volume.toString(),
                                      style: pw.TextStyle(
                                          fontSize: 8, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left,
                                      softWrap: true,
                                      overflow: pw.TextOverflow.clip),
                                ])
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 99,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              children: [
                                pw.Row(children: [
                                  pw.Text("ESPÉCIE",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(children: [
                                  pw.Text(widget.especie,
                                      style: pw.TextStyle(
                                          fontSize: 8, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left,
                                      softWrap: true,
                                      overflow: pw.TextOverflow.clip),
                                ])
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 99,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              children: [
                                pw.Row(children: [
                                  pw.Text("MARCA",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(children: [
                                  pw.Text(widget.marca,
                                      style: pw.TextStyle(
                                          fontSize: 8, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left,
                                      softWrap: true,
                                      overflow: pw.TextOverflow.clip),
                                ])
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 99,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              children: [
                                pw.Row(children: [
                                  pw.Text("NUMERAÇÃO",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(children: [
                                  pw.Text('',
                                      style: pw.TextStyle(
                                          fontSize: 8, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left,
                                      softWrap: true,
                                      overflow: pw.TextOverflow.clip),
                                ])
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 99,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              children: [
                                pw.Row(children: [
                                  pw.Text("PESO BRUTO",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(children: [
                                  pw.Text(widget.peso_bruto.toString(),
                                      style: pw.TextStyle(
                                          fontSize: 8, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left,
                                      softWrap: true,
                                      overflow: pw.TextOverflow.clip),
                                ])
                              ],
                            ),
                          ),
                          pw.Container(
                            width: 99,
                            height: 30,
                            padding: pw.EdgeInsets.all(5),
                            decoration:
                                pw.BoxDecoration(border: pw.Border.all()),
                            child: pw.Column(
                              children: [
                                pw.Row(children: [
                                  pw.Text("PESO LÍQUIDO",
                                      style: pw.TextStyle(
                                          fontSize: 4, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left),
                                ]),
                                pw.SizedBox(height: 4),
                                pw.Row(children: [
                                  pw.Text(widget.peso_liq.toString(),
                                      style: pw.TextStyle(
                                          fontSize: 8, font: TimesNewRoman),
                                      textAlign: pw.TextAlign.left,
                                      softWrap: true,
                                      overflow: pw.TextOverflow.clip),
                                ])
                              ],
                            ),
                          ),
                        ]),
                      ],
                      pw.SizedBox(height: 5),
                      if (context.pageNumber == 1) ...[
                        pw.Text('DADOS DO PRODUTO / SERVIÇOS',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 9,
                                font: TimesNewRoman)),
                      ] else
                        pw.Text('CONTINUAÇÃO DOS DADOS DO PRODUTO / SERVIÇOS',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 9,
                                font: TimesNewRoman)),
                    ]),
            build: (pw.Context context) {
              return [
                pw.TableHelper.fromTextArray(
                    headers: [
                      "CÓDIGO",
                      "DESCRIÇÃO",
                      "NCM/SH",
                      "CST",
                      "CFOP",
                      "UNID.",
                      "QTD.",
                      "Vl. UNIT",
                      "Vl. TOTAL",
                      "DESC.",
                      "BC. ICMS",
                      "Vl. ICMS",
                      "Vl. IPI",
                      "ALIQ. ICMS",
                      "ALIQ. IPI",
                    ],
                    headerDecoration: pw.BoxDecoration(
                      color: PdfColor.fromInt(0xffdcdcdc),
                    ),
                    headerAlignment: pw.Alignment.center,
                    headerStyle: pw.TextStyle(fontSize: 7, font: TimesNewRoman),
                    data: nfeItems.map((item) {
                      return [
                        item.codigo ??
                            "", // Substitui null por string vazia se necessário
                        item.nome ?? "",
                        item.ncm ?? "",
                        item.cst_icms ?? "",
                        item.cfop ?? "",
                        item.unid_comercial ?? "",
                        item.quantidade_comercial?.toString() ?? "",
                        item.valor_unit_comercial?.toStringAsFixed(2) ?? "",
                        (item.quantidade_comercial! * item.valor_unit_comercial)
                                .toStringAsFixed(2) ??
                            "",
                        item.vl_desc?.toStringAsFixed(2) ?? "",
                        item.vl_bc_icms?.toStringAsFixed(2) ?? "",
                        item.vl_icms?.toStringAsFixed(2) ?? "",
                        item.vl_ipi?.toStringAsFixed(2) ?? "0.00",
                        item.aliq_icms?.toStringAsFixed(2) ?? "",
                        item.aliq_ipi?.toStringAsFixed(2) ?? "",
                      ];
                    }).toList(),
                    cellStyle: pw.TextStyle(fontSize: 6, font: TimesNewRoman),
                    cellAlignment: pw.Alignment.center),
              ];
            },
            //pw.Spacer(),
            footer: (pw.Context context) {
              if (context.pageNumber != 1) return pw.SizedBox();
              return pw.Align(
                alignment: pw.Alignment.bottomCenter,
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Row(children: [
                      pw.Text('DADOS ADICIONAIS',
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 9,
                              font: TimesNewRoman)),
                    ]),
                    pw.Row(children: [
                      pw.Container(
                        width: 365,
                        height: 100,
                        padding: pw.EdgeInsets.all(5),
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Column(
                          children: [
                            pw.Row(children: [
                              pw.Text("INFROMAÇÕES COMPLEMENTARES",
                                  style: pw.TextStyle(
                                      fontSize: 4, font: TimesNewRoman),
                                  textAlign: pw.TextAlign.left),
                            ]),
                            pw.SizedBox(height: 4),
                            pw.Row(children: [
                              pw.Container(
                                width: 361,
                                child: pw.Text('${widget.mensagem}',
                                    style: pw.TextStyle(
                                        fontSize: 10, font: TimesNewRoman),
                                    textAlign: pw.TextAlign.left,
                                    softWrap: true,
                                    overflow: pw.TextOverflow.clip),
                              )
                            ])
                          ],
                        ),
                      ),
                      pw.Container(
                        width: 210,
                        height: 100,
                        padding: pw.EdgeInsets.all(5),
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Column(
                          children: [
                            pw.Row(children: [
                              pw.Text("RESERVADO AO FÍSICO",
                                  style: pw.TextStyle(
                                      fontSize: 4, font: TimesNewRoman),
                                  textAlign: pw.TextAlign.left),
                            ]),
                            pw.SizedBox(height: 4),
                          ],
                        ),
                      ),
                    ]),
                    pw.SizedBox(height: 5),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        children: [
                          pw.Text('Ideia Tecnologia',
                              style: pw.TextStyle(
                                  //fontWeight: pw.FontWeight.bold,
                                  font: TimesNewRoman,
                                  fontItalic: pw.Font.timesBoldItalic(),
                                  fontSize: 5))
                        ])
                  ],
                ),
              );
            }

            // Informações dos Produtos

            // Espaço flexível para empurrar os elementos para o final
            ),
      );
      ;
    } else if (widget.cod_mod == '65') {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.roll80, // Define a largura do cupom
          build: (pw.Context context) {
            return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  // Cabeçalho da NFC-e
                  //pw.Text("BANDEIRANTES COMÉRCIO DE RAÇÕES LTDA", style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
                  pw.Center(
                    child: pw.Column(children: [
                      pw.Text(
                          "CNPJ: ${cnpjMaskFormatter.maskText(widget.em_cnpj)} ${widget.em_razaosocial}",
                          style: pw.TextStyle(fontSize: 8),
                          textAlign: pw.TextAlign.center),
                      pw.Text(
                          "${widget.em_end}, ${widget.em_num} - ${widget.em_bairro} - ${widget.em_mun} - ${widget.em_uf}, ${cepFormatter.maskText(widget.em_cep)} ${' - Fone: ${widget.em_fone} - I.E.: ${widget.em_ie}'}",
                          style: pw.TextStyle(fontSize: 8),
                          textAlign: pw.TextAlign.center),
                      // pw.Text("Rio de Janeiro - RJ, 22793-022",
                      //     style: pw.TextStyle(fontSize: 8)),
                      pw.SizedBox(height: 5),
                      pw.Text(
                          "DOCUMENTO AUXILIAR DA NOTA FISCAL DE CONSUMIDOR ELETRÔNICA",
                          style: pw.TextStyle(
                            fontSize: 6,
                            fontWeight: pw.FontWeight.bold,
                          ),
                          textAlign: pw.TextAlign.center),
                      pw.SizedBox(height: 5),
                    ]),
                  ),

                  // Indicação de Homologação
                  // pw.Container(
                  //   color: PdfColors.grey300,
                  //   padding: pw.EdgeInsets.all(1),
                  //   child: pw.Center(
                  //     child: pw.Text("EMITIDA EM AMBIENTE DE HOMOLOGAÇÃO SEM VALOR FISCAL",
                  //     style: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold,), textAlign: pw.TextAlign.center),
                  //   )
                  // ),

                  //pw.Divider(),

                  pw.Container(
                      child: pw.Column(children: [
                    pw.Row(
                        mainAxisSize: pw.MainAxisSize.max,
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Text("#",
                              style: pw.TextStyle(
                                  fontSize: 8, fontWeight: pw.FontWeight.bold)),
                          pw.Text("Cód.",
                              style: pw.TextStyle(
                                  fontSize: 8, fontWeight: pw.FontWeight.bold)),
                          pw.Text("Descrição",
                              style: pw.TextStyle(
                                  fontSize: 8, fontWeight: pw.FontWeight.bold)),
                          pw.Text("Qtd.",
                              style: pw.TextStyle(
                                  fontSize: 8, fontWeight: pw.FontWeight.bold)),
                          pw.Text("Un",
                              style: pw.TextStyle(
                                  fontSize: 8, fontWeight: pw.FontWeight.bold)),
                          pw.Text("Vl Unit",
                              style: pw.TextStyle(
                                  fontSize: 8, fontWeight: pw.FontWeight.bold)),
                          pw.Text("Vl Total",
                              style: pw.TextStyle(
                                  fontSize: 8, fontWeight: pw.FontWeight.bold)),
                        ]),
                  ])),
                  pw.Container(
                    child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        children: [
                          pw.Expanded(
                              child: pw.ListView.builder(
                                  spacing: 5,
                                  itemCount: nfeItems.length,
                                  itemBuilder: (context, index) {
                                    return pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Text(
                                              "${nfeItems[index].numero_item.toString().padLeft(3, '0')}",
                                              style: pw.TextStyle(fontSize: 6)),
                                          // pw.SizedBox(width: 2),
                                          pw.Text("${nfeItems[index].codigo}",
                                              style: pw.TextStyle(fontSize: 6)),
                                          // pw.SizedBox(width: 2),
                                          pw.Container(
                                            width: 50,
                                            child: pw.Text(
                                                "${nfeItems[index].nome}",
                                                style:
                                                    pw.TextStyle(fontSize: 6),
                                                softWrap: true,
                                                overflow: pw.TextOverflow.clip),
                                          ),
                                          pw.Container(
                                            width: 15,
                                            child: pw.Text(
                                                "${nfeItems[index].quantidade_comercial}",
                                                style:
                                                    pw.TextStyle(fontSize: 6)),
                                          ),
                                          pw.Container(
                                            width: 15,
                                            child: pw.Text(
                                                "${nfeItems[index].unid_comercial}",
                                                style:
                                                    pw.TextStyle(fontSize: 6)),
                                          ),
                                          pw.Container(
                                            width: 25,
                                            child: pw.Text(
                                                "${currencyFormat.format(nfeItems[index].valor_unit_comercial)}",
                                                style:
                                                    pw.TextStyle(fontSize: 6)),
                                          ),
                                          // pw.SizedBox(width: 2),
                                          pw.Container(
                                            width: 25,
                                            child: pw.Text(
                                                currencyFormat
                                                    .format(nfeItems[index]
                                                            .quantidade_comercial! *
                                                        nfeItems[index]
                                                            .valor_unit_comercial)
                                                    .toString(),
                                                style:
                                                    pw.TextStyle(fontSize: 6)),
                                          ),
                                        ]);
                                  })),
                        ]),
                  ),
                  pw.SizedBox(height: 5),

                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text("QTD TOTAL DE ITENS",
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text("VALOR TOTAL R\$",
                                  style: pw.TextStyle(
                                      fontSize: 10,
                                      fontWeight: pw.FontWeight.bold)),
                            ]),
                        pw.Column(children: [
                          pw.Column(
                              mainAxisAlignment: pw.MainAxisAlignment.end,
                              crossAxisAlignment: pw.CrossAxisAlignment.end,
                              children: [
                                pw.ListView.builder(
                                    itemCount: 1,
                                    itemBuilder: (context, index) {
                                      final totalQuantidade = nfeItems.fold(
                                          0,
                                          (sum, item) =>
                                              sum +
                                              item.quantidade_comercial!
                                                  .toInt());
                                      return pw.Text("${totalQuantidade}",
                                          style: pw.TextStyle(
                                              fontSize: 10,
                                              fontWeight: pw.FontWeight.bold));
                                    }),
                                pw.Text(
                                    '${currencyFormat.format(widget.vl_doc)}',
                                    style: pw.TextStyle(
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold)),
                              ]),
                        ]),
                      ]),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text("FORMA DE PAGAMENTO",
                                  style: pw.TextStyle(fontSize: 8)),
                              pw.ListView.builder(
                                itemCount: paymentNfe.length,
                                itemBuilder: (context, index) {
                                  return pw.Row(children: [
                                    pw.Column(children: [
                                      pw.Text(
                                          '${paymentNfe[index].nomecondicaopagamento}',
                                          style: pw.TextStyle(fontSize: 7)),
                                    ]),
                                  ]);
                                },
                              )
                            ]),
                        pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.end,
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            children: [
                              pw.Text("Valor Pago",
                                  style: pw.TextStyle(fontSize: 8)),
                              pw.ListView.builder(
                                itemCount: paymentNfe.length,
                                itemBuilder: (context, index) {
                                  return pw.Row(children: [
                                    pw.Column(children: [
                                      pw.Text(
                                          '${currencyFormat.format(paymentNfe[index].valorpagamento)}',
                                          style: pw.TextStyle(fontSize: 7)),
                                    ]),
                                  ]);
                                },
                              )
                            ]),
                      ]),

                  pw.SizedBox(height: 5),

                  pw.Center(
                      child: pw.Column(children: [
                    pw.Text('Consulte pela Chave de Acesso em',
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 8),
                        textAlign: pw.TextAlign.center),
                    pw.Text('www.fazenda.rj.gov.br/nfce/consulta',
                        style: pw.TextStyle(fontSize: 10),
                        textAlign: pw.TextAlign.center),
                    pw.Text('${chvFormatter.maskText(widget.chv_nfe)}',
                        style: pw.TextStyle(fontSize: 9),
                        textAlign: pw.TextAlign.center)
                  ])),

                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Center(
                          child: pw.BarcodeWidget(
                            barcode: pw.Barcode.qrCode(),
                            data: '${qrCode}',
                            //"https://consultadfe.fazenda.rj.gov.br/consultaNFCe/QRCode?p=${widget.chv_nfe}|2|1|3|66113B460E8D5468D517CD8047969263EE107CC3", // Substituir pelo link real da SEFAZ
                            width: 80,
                            height: 80,
                          ),
                        ),
                        pw.Container(
                            width: 70,
                            child: widget.dest_cpf.isNotEmpty
                                ? pw.Text(
                                    'CONSUMIDOR CPF: ${cpfMaskFormatter.maskText(widget.dest_cpf)} ${widget.dest_razaosocial} ${widget.dest_razaosocial} ${widget.dest_end} ${widget.dest_num} ${widget.dest_bairro} ${widget.dest_mun} NFC-e nº ${widget.num_doc.toString().padLeft(9, '0')} Série ${widget.serie.toString().padLeft(3, '0')} ${DateFormat('dd/MM/yyyy hh:mm:ss').format(widget.dt_e_s)} Protocolo de Autorização: ${protocolo} Data de Autorização: ${dataProtocolo != null ? DateFormat('dd/MM/yyyy HH:mm:ss').format(dataProtocolo) : ''}',
                                    style: pw.TextStyle(fontSize: 7),
                                    textAlign: pw.TextAlign.center,
                                    softWrap: true)
                                : pw.Text(
                                    'CONSUMIDOR NÃO IDENTIFICADO NFC-e nº ${widget.num_doc.toString().padLeft(9, '0')} Série ${widget.serie.toString().padLeft(3, '0')} ${DateFormat('dd/MM/yyyy hh:mm:ss').format(widget.dt_e_s)} Protocolo de Autorização: ${protocolo} Data de Autorização: ${dataProtocolo != null ? DateFormat('dd/MM/yyyy HH:mm:ss').format(dataProtocolo) : ''}',
                                    style: pw.TextStyle(fontSize: 7),
                                    textAlign: pw.TextAlign.center,
                                    softWrap: true))
                      ]),
                  pw.SizedBox(height: 10),

                  // Informações Fiscais
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Container(
                            width: 180,
                            child: pw.Center(
                                child: pw.Text('${widget.mensagem}',
                                    style: pw.TextStyle(fontSize: 8),
                                    textAlign: pw.TextAlign.center,
                                    softWrap: true,
                                    overflow: pw.TextOverflow.clip)))
                      ]),
                  pw.SizedBox(height: 5),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Text('Ideia Tecnologia',
                            style: pw.TextStyle(
                                //fontWeight: pw.FontWeight.bold,
                                fontItalic: pw.Font.timesItalic(),
                                fontSize: 5))
                      ])
                ]);
          },
        ),
      );
    }

    // Obter o diretório para salvar o PDF
    final outputDir = await getApplicationDocumentsDirectory();
    final file = File('${outputDir.path}/${widget.chv_nfe}.pdf');
    await file.writeAsBytes(await pdf.save());

    setState(() {
      pdfFilePath = file.path;
    });

    // Abrir o PDF automaticamente após criar
    openPdfViewer();
  }

  // Função para abrir o visualizador de PDF
  void openPdfViewer() {
    if (pdfFilePath != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfViewerScreen(
            filePath: pdfFilePath!,
            chvnfe: widget.chv_nfe,
          ),
        ),
      );
    }
  }
}

// Tela para visualizar o PDF
class PdfViewerScreen extends StatelessWidget {
  final String filePath;
  final String chvnfe;

  const PdfViewerScreen({required this.filePath, this.chvnfe = ''});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Style.tertiaryColor,
        title: Text('Visualizador de PDF'),
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: Style.tertiaryColor, fontSize: Style.height_15(context)),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () async {
              final file = File(filePath);
              final bytes = await file.readAsBytes();
              await Printing.sharePdf(bytes: bytes, filename: '${chvnfe}.pdf');
            },
          ),
        ],
      ),
      backgroundColor: Style.quarantineColor,
      body: Padding(
        padding: EdgeInsets.only(
          left: Style.height_12(context),
          right: Style.height_12(context),
          //top: Style.height_12(context),
        ),
        child: PDFView(
          filePath: filePath,
        ),
      ),
    ));
  }
}
