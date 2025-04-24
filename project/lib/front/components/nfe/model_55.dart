// import 'dart:typed_data';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'package:intl/intl.dart';
// import 'package:pdf/pdf.dart';
// import 'package:printing/printing.dart';
// import 'package:project/Front/components/global/elements/navbar_button.dart';
// import 'package:project/Front/components/global/structure/navbar.dart';
// import 'package:project/Front/components/style.dart';
// import 'package:project/Front/pages/nfe_list.dart';
// import 'package:project/back/nfe_info_functions/nfe_items.dart';
// import 'package:project/back/nfe_info_functions/payment_nfe.dart';
// import 'package:project/back/teste.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

// class Model55 extends StatefulWidget {
//   const Model55({super.key});

//   @override
//   State<Model55> createState() => _Model55State();
// }

// class _Model55State extends State<Model55> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

// Future<void> generateAndOpenPdf() async {
//     final TimesNewRoman = pw.Font.ttf(
//         await rootBundle.load('assets/fonts/times.ttf'));
//     // final NotoSansMono = pw.Font.ttf(
//     //     await rootBundle.load('assets/fonts/NotoSansMono-Regular.ttf'));
//     // final SpaceMono = pw.Font.ttf(
//     //     await rootBundle.load('assets/fonts/SpaceMono-Regular.ttf'));
//     final pdf = pw.Document();
//       pdf.addPage(
//         pw.MultiPage(
//             pageFormat: PdfPageFormat.a4,
//             margin: pw.EdgeInsets.all(10),
//             header: (pw.Context context) => pw.Column(
//                     crossAxisAlignment: pw.CrossAxisAlignment.start,
//                     children: [
//                       if (context.pageNumber == 1) ...[
//                         pw.Row(
//                             mainAxisAlignment: pw.MainAxisAlignment.start,
//                             children: [
//                               pw.Column(children: [
//                                 pw.Row(children: [
//                                   pw.Container(
//                                     width: 482,
//                                     padding: pw.EdgeInsets.all(5),
//                                     decoration: pw.BoxDecoration(
//                                         border: pw.Border.all()),
//                                     child: pw.Column(
//                                       crossAxisAlignment:
//                                           pw.CrossAxisAlignment.center,
//                                       children: [
//                                         pw.Text(
//                                             "RECEBEMOS DE ${widget.em_razaosocial} OS PRODUTOS / SERVIÇOS CONSTANTES DA NOTA FISCAL INDICADO AO LADO",
//                                             style: pw.TextStyle(
//                                               fontSize: 6,
//                                               font: TimesNewRoman
//                                             ),
//                                             textAlign: pw.TextAlign.center),
//                                         pw.Text(
//                                             "EMISSÃO: ${DateFormat('dd/MM/yyyy').format(widget.dt_e_s)}  -  DEST. / REM.: ${widget.dest_razaosocial}  -  VALOR TOTAL: ${currencyFormatDefault.format(widget.vl_doc)}",
//                                             style: pw.TextStyle(fontSize: 6, font: TimesNewRoman),
//                                             textAlign: pw.TextAlign.center),
//                                       ],
//                                     ),
//                                   ),
//                                 ]),
//                                 pw.Row(
//                                     mainAxisAlignment:
//                                         pw.MainAxisAlignment.start,
//                                     mainAxisSize: pw.MainAxisSize.max,
//                                     children: [
//                                       pw.Container(
//                                         width: 172,
//                                         height: 37,
//                                         padding: pw.EdgeInsets.all(5),
//                                         decoration: pw.BoxDecoration(
//                                             border: pw.Border.all()),
//                                         child: pw.Column(
//                                           crossAxisAlignment:
//                                               pw.CrossAxisAlignment.start,
//                                           children: [
//                                             pw.Text("DATA DE RECEBIMENTO",
//                                                 style:
//                                                     pw.TextStyle(fontSize: 4, font: TimesNewRoman)),
//                                           ],
//                                         ),
//                                       ),
//                                       pw.Container(
//                                         width: 310,
//                                         height: 37,
//                                         padding: pw.EdgeInsets.all(5),
//                                         decoration: pw.BoxDecoration(
//                                             border: pw.Border.all()),
//                                         child: pw.Column(
//                                           crossAxisAlignment:
//                                               pw.CrossAxisAlignment.start,
//                                           children: [
//                                             pw.Text(
//                                                 "IDENTIFICAÇÃO E ASSINATURA DO RECEBEDOR",
//                                                 style:
//                                                     pw.TextStyle(fontSize: 4, font: TimesNewRoman)),
//                                           ],
//                                         ),
//                                       ),
//                                     ]),
//                               ]),
//                               pw.Column(children: [
//                                 pw.Container(
//                                   height: 68,
//                                   padding: pw.EdgeInsets.all(5),
//                                   decoration:
//                                       pw.BoxDecoration(border: pw.Border.all()),
//                                   child: pw.Center(
//                                     child: pw.Column(
//                                       mainAxisAlignment:
//                                           pw.MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           pw.CrossAxisAlignment.center,
//                                       children: [
//                                         pw.Text("NF-e",
//                                         style: pw.TextStyle(
//                                           font: TimesNewRoman
//                                         ),
//                                             textAlign: pw.TextAlign.center),
//                                         pw.Text(
//                                             "Nº ${widget.num_doc.toString().padLeft(5, '000.')}",
//                                             style: pw.TextStyle(
//                                               font: TimesNewRoman,
//                                                 fontWeight: pw.FontWeight.bold),
//                                             textAlign: pw.TextAlign.center),
//                                         pw.Text(
//                                             "SÉRIE ${widget.serie.toString().padLeft(3, '0')}",
//                                             style: pw.TextStyle(
//                                               font: TimesNewRoman
//                                             ),
//                                             textAlign: pw.TextAlign.center),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ]),
//                             ]),
//                         pw.Divider(),
//                       ],
//                       pw.Row(children: [
//                         pw.Column(children: [
//                           pw.Container(
//                             width: 215,
//                             height: 90,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("IDENTIFICAÇAO DO EMITENTE",
//                                       style: pw.TextStyle(fontSize: 6, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 15),
//                                 pw.Center(
//                                   child: pw.Text('${widget.em_razaosocial}',
//                                       style: pw.TextStyle(
//                                         font: TimesNewRoman,
//                                           fontWeight: pw.FontWeight.bold,
//                                           fontSize: 8),
//                                       textAlign: pw.TextAlign.center,
//                                       softWrap: true,
//                                       overflow: pw.TextOverflow.clip),
//                                 ),
//                                 pw.SizedBox(height: 5),
//                                 pw.Text(
//                                     "${widget.em_end}, ${widget.em_num} - ${widget.em_bairro} -  ${'CEP: ' + cepFormatter.maskText(widget.em_cep)} - ${widget.em_mun} - ${widget.em_uf} '${'TEL.:'+ telMaskFormatter.maskText(widget.em_fone)}",
//                                     style: pw.TextStyle(fontSize: 7, font: TimesNewRoman),
//                                     softWrap: true,
//                                     overflow: pw.TextOverflow.clip,
//                                     textAlign: pw.TextAlign.left),
//                               ],
//                             ),
//                           ),
//                         ]),
//                         pw.Column(children: [
//                           pw.Container(
//                             width: 140,
//                             height: 90,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                               children: [
//                                 pw.Center(
//                                   child: pw.Text("DANFE",
//                                       style: pw.TextStyle(
//                                         font: TimesNewRoman,
//                                           fontSize: 10,
//                                           fontWeight: pw.FontWeight.bold)),
//                                 ),
//                                 pw.SizedBox(height: 2),
//                                 pw.Text(
//                                     "DOCUMENTO AUXILIAR DA NOTA FISCAL ELETRÔNICA",
//                                     style: pw.TextStyle(
//                                       font: TimesNewRoman,
//                                         fontSize: 7,
//                                         fontWeight: pw.FontWeight.bold),
//                                     textAlign: pw.TextAlign.center),
//                                 pw.SizedBox(height: 5),
//                                 pw.Row(
//                                     mainAxisAlignment:
//                                         pw.MainAxisAlignment.spaceAround,
//                                     children: [
//                                       pw.Column(children: [
//                                         pw.Row(
//                                             mainAxisAlignment:
//                                                 pw.MainAxisAlignment.start,
//                                             children: [
//                                               pw.Text('0 - ENTRADA',
//                                                   style:
//                                                       pw.TextStyle(fontSize: 6, font: TimesNewRoman),
//                                                   textAlign: pw.TextAlign.left)
//                                             ]),
//                                         pw.Row(
//                                             mainAxisAlignment:
//                                                 pw.MainAxisAlignment.start,
//                                             children: [
//                                               pw.Text('1 - SAÍDA',
//                                                   style:
//                                                       pw.TextStyle(fontSize: 6, font: TimesNewRoman),
//                                                   textAlign: pw.TextAlign.left)
//                                             ]),
//                                       ]),
//                                       pw.Column(children: [
//                                         pw.Container(
//                                             width: 15,
//                                             height: 15,
//                                             padding: pw.EdgeInsets.all(2),
//                                             decoration: pw.BoxDecoration(
//                                                 border:
//                                                     pw.Border.all(width: 1)),
//                                             child: pw.Center(
//                                                 child: pw.Text(
//                                                     '${widget.finalidade}',
//                                                     style: pw.TextStyle(
//                                                         fontSize: 9, font: TimesNewRoman),
//                                                     textAlign:
//                                                         pw.TextAlign.center)))
//                                       ]),
//                                     ]),
//                                 pw.SizedBox(height: 5),
//                                 pw.Text(
//                                     "Nº ${widget.num_doc.toString().padLeft(5, '000.')}    fl. ${context.pageNumber} /${context.pagesCount}",
//                                     style: pw.TextStyle(
//                                       font: TimesNewRoman,
//                                         fontSize: 8,
//                                         fontWeight: pw.FontWeight.bold),
//                                     textAlign: pw.TextAlign.center),
//                                 pw.Text(
//                                     "SÉRIE ${widget.serie.toString().padLeft(3, '0')}",
//                                     style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                     textAlign: pw.TextAlign.center),
//                               ],
//                             ),
//                           ),
//                         ]),
//                         pw.Column(children: [
//                           pw.Row(children: [
//                             pw.Container(
//                               width: 220,
//                               height: 30,
//                               padding: pw.EdgeInsets.all(5),
//                               decoration:
//                                   pw.BoxDecoration(border: pw.Border.all()),
//                               child: pw.Column(
//                                 //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                                 children: [
//                                   pw.Center(
//                                     child: pw.BarcodeWidget(
//                                       barcode: pw.Barcode.code128(),
//                                       drawText: false,
//                                       data: chvFormatter.maskText(widget
//                                           .chv_nfe), // Substituir pelo link real da SEFAZ
//                                       width: 200,
//                                       height: 20,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ]),
//                           pw.Row(children: [
//                             pw.Container(
//                               width: 220,
//                               height: 30,
//                               padding: pw.EdgeInsets.all(5),
//                               decoration:
//                                   pw.BoxDecoration(border: pw.Border.all()),
//                               child: pw.Column(
//                                 //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                                 children: [
//                                   pw.Row(children: [
//                                     pw.Text("CHAVE DE ACESSO",
//                                         style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.left),
//                                   ]),
//                                   pw.SizedBox(height: 4),
//                                   pw.Center(
//                                     child: pw.Text(
//                                         '${chvFormatter.maskText(widget.chv_nfe)}',
//                                         style: pw.TextStyle(fontSize: 7, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.center,
//                                         softWrap: true,
//                                         overflow: pw.TextOverflow.clip),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ]),
//                           pw.Row(children: [
//                             pw.Container(
//                               width: 220,
//                               height: 30,
//                               padding: pw.EdgeInsets.all(5),
//                               decoration:
//                                   pw.BoxDecoration(border: pw.Border.all()),
//                               child: pw.Column(
//                                 //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                                 children: [
//                                   pw.Text(
//                                       'Consulta de autenticidade no portal nacional da NF-e www.nfe.fazenda.gov.br/portal ou no site da Sefaz Autorizadora',
//                                       style: pw.TextStyle(fontSize: 7, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.center,
//                                       softWrap: true,
//                                       overflow: pw.TextOverflow.clip)
//                                 ],
//                               ),
//                             ),
//                           ]),
//                         ]),
//                       ]),
//                       pw.Row(children: [
//                         pw.Column(children: [
//                           pw.Container(
//                             width: 355,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("NATUREZA DE OPERAÇÃO",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(children: [
//                                   pw.Text('${widget.desc_nat_op}',
//                                       style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left,
//                                       softWrap: true,
//                                       overflow: pw.TextOverflow.clip),
//                                 ])
//                               ],
//                             ),
//                           ),
//                         ]),
//                         pw.Column(children: [
//                           pw.Container(
//                             width: 220,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("PROTOCOLO DE AUTORIZAÇÃO DE USO",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                               ],
//                             ),
//                           ),
//                         ])
//                       ]),
//                       pw.Row(children: [
//                         pw.Column(children: [
//                           pw.Container(
//                             width: 191,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("iNSCRIÇÃO ESTADUAL",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(children: [
//                                   pw.Text('${widget.em_ie}',
//                                       style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left,
//                                       softWrap: true,
//                                       overflow: pw.TextOverflow.clip),
//                                 ])
//                               ],
//                             ),
//                           ),
//                         ]),
//                         pw.Column(children: [
//                           pw.Container(
//                             width: 191,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("INSCRIÇÃO ESTADUAL DO SUBST. TRIB.",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                               ],
//                             ),
//                           ),
//                         ]),
//                         pw.Column(children: [
//                           pw.Container(
//                             width: 193,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("CNPJ/CPF",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(children: [
//                                   pw.Text(
//                                       widget.em_cnpj.isEmpty
//                                           ? cpfMaskFormatter
//                                               .maskText(widget.em_cpf)
//                                           : cnpjMaskFormatter
//                                               .maskText(widget.em_cnpj),
//                                       style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left,
//                                       softWrap: true,
//                                       overflow: pw.TextOverflow.clip),
//                                 ])
//                               ],
//                             ),
//                           ),
//                         ]),
//                       ]),
//                       pw.SizedBox(height: 5),
//                       if (context.pageNumber == 1) ...[
//                         pw.Text('DESTINATÁRIO / REMETENTE',
//                             style: pw.TextStyle(
//                                 fontWeight: pw.FontWeight.bold, fontSize: 9, font: TimesNewRoman)),
//                         pw.Row(children: [
//                           pw.Column(children: [
//                             pw.Container(
//                               width: 375,
//                               height: 30,
//                               padding: pw.EdgeInsets.all(5),
//                               decoration:
//                                   pw.BoxDecoration(border: pw.Border.all()),
//                               child: pw.Column(
//                                 //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                                 children: [
//                                   pw.Row(children: [
//                                     pw.Text("NOME/RAZÃO SOCIAL",
//                                         style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.left),
//                                   ]),
//                                   pw.SizedBox(height: 4),
//                                   pw.Row(children: [
//                                     pw.Text('${widget.dest_razaosocial}',
//                                         style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.left,
//                                         softWrap: true,
//                                         overflow: pw.TextOverflow.clip),
//                                   ])
//                                 ],
//                               ),
//                             ),
//                           ]),
//                           pw.Column(children: [
//                             pw.Container(
//                               width: 100,
//                               height: 30,
//                               padding: pw.EdgeInsets.all(5),
//                               decoration:
//                                   pw.BoxDecoration(border: pw.Border.all()),
//                               child: pw.Column(
//                                 //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                                 children: [
//                                   pw.Row(children: [
//                                     pw.Text("CNPJ/CPF",
//                                         style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.left),
//                                   ]),
//                                   pw.SizedBox(height: 4),
//                                   pw.Row(children: [
//                                     pw.Text(
//                                         widget.dest_cnpj.isEmpty
//                                             ? cpfMaskFormatter
//                                                 .maskText(widget.dest_cpf)
//                                             : cnpjMaskFormatter
//                                                 .maskText(widget.dest_cnpj),
//                                         style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.left,
//                                         softWrap: true,
//                                         overflow: pw.TextOverflow.clip),
//                                   ])
//                                 ],
//                               ),
//                             ),
//                           ]),
//                           pw.Column(children: [
//                             pw.Container(
//                               width: 100,
//                               height: 30,
//                               padding: pw.EdgeInsets.all(5),
//                               decoration:
//                                   pw.BoxDecoration(border: pw.Border.all()),
//                               child: pw.Column(
//                                 //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                                 children: [
//                                   pw.Row(children: [
//                                     pw.Text("DATA DE EMISSÃO",
//                                         style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.left),
//                                   ]),
//                                   pw.SizedBox(height: 4),
//                                   pw.Row(children: [
//                                     pw.Text(
//                                         '${DateFormat('dd/MM/yyyy').format(widget.dt_e_s)}',
//                                         style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.left,
//                                         softWrap: true,
//                                         overflow: pw.TextOverflow.clip),
//                                   ])
//                                 ],
//                               ),
//                             ),
//                           ]),
//                         ]),
//                         pw.Row(children: [
//                           pw.Column(children: [
//                             pw.Container(
//                               width: 265,
//                               height: 30,
//                               padding: pw.EdgeInsets.all(5),
//                               decoration:
//                                   pw.BoxDecoration(border: pw.Border.all()),
//                               child: pw.Column(
//                                 //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                                 children: [
//                                   pw.Row(children: [
//                                     pw.Text("ENDEREÇO",
//                                         style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.left),
//                                   ]),
//                                   pw.SizedBox(height: 4),
//                                   pw.Row(children: [
//                                     pw.Text(
//                                         '${widget.dest_end}, ${widget.dest_num}',
//                                         style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.left,
//                                         softWrap: true,
//                                         overflow: pw.TextOverflow.clip),
//                                   ])
//                                 ],
//                               ),
//                             ),
//                           ]),
//                           pw.Column(children: [
//                             pw.Container(
//                               width: 150,
//                               height: 30,
//                               padding: pw.EdgeInsets.all(5),
//                               decoration:
//                                   pw.BoxDecoration(border: pw.Border.all()),
//                               child: pw.Column(
//                                 //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                                 children: [
//                                   pw.Row(children: [
//                                     pw.Text("BAIRRO/DISTRITO",
//                                         style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.left),
//                                   ]),
//                                   pw.SizedBox(height: 4),
//                                   pw.Row(children: [
//                                     pw.Text('${widget.dest_bairro}',
//                                         style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.left,
//                                         softWrap: true,
//                                         overflow: pw.TextOverflow.clip),
//                                   ])
//                                 ],
//                               ),
//                             ),
//                           ]),
//                           pw.Column(children: [
//                             pw.Container(
//                               width: 60,
//                               height: 30,
//                               padding: pw.EdgeInsets.all(5),
//                               decoration:
//                                   pw.BoxDecoration(border: pw.Border.all()),
//                               child: pw.Column(
//                                 //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                                 children: [
//                                   pw.Row(children: [
//                                     pw.Text("CEP",
//                                         style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.left),
//                                   ]),
//                                   pw.SizedBox(height: 4),
//                                   pw.Row(children: [
//                                     pw.Text(
//                                         '${cepFormatter.maskText(widget.dest_cep)}',
//                                         style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.left,
//                                         softWrap: true,
//                                         overflow: pw.TextOverflow.clip),
//                                   ])
//                                 ],
//                               ),
//                             ),
//                           ]),
//                           pw.Column(children: [
//                             pw.Container(
//                               width: 100,
//                               height: 30,
//                               padding: pw.EdgeInsets.all(5),
//                               decoration:
//                                   pw.BoxDecoration(border: pw.Border.all()),
//                               child: pw.Column(
//                                 //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                                 children: [
//                                   pw.Row(children: [
//                                     pw.Text("DATA SAÍDA/ENTRADA",
//                                         style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.left),
//                                   ]),
//                                   pw.SizedBox(height: 4),
//                                   pw.Row(children: [
//                                     pw.Text(
//                                         '${DateFormat('dd/MM/yyyy').format(widget.dt_e_s)}',
//                                         style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.left,
//                                         softWrap: true,
//                                         overflow: pw.TextOverflow.clip),
//                                   ])
//                                 ],
//                               ),
//                             ),
//                           ]),
//                         ]),
//                         pw.Row(children: [
//                           pw.Column(children: [
//                             pw.Container(
//                               width: 195,
//                               height: 30,
//                               padding: pw.EdgeInsets.all(5),
//                               decoration:
//                                   pw.BoxDecoration(border: pw.Border.all()),
//                               child: pw.Column(
//                                 //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                                 children: [
//                                   pw.Row(children: [
//                                     pw.Text("MUNICÍPIO",
//                                         style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.left),
//                                   ]),
//                                   pw.SizedBox(height: 4),
//                                   pw.Row(children: [
//                                     pw.Text('${widget.dest_mun}',
//                                         style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.left,
//                                         softWrap: true,
//                                         overflow: pw.TextOverflow.clip),
//                                   ])
//                                 ],
//                               ),
//                             ),
//                           ]),
//                           pw.Column(children: [
//                             pw.Container(
//                               width: 150,
//                               height: 30,
//                               padding: pw.EdgeInsets.all(5),
//                               decoration:
//                                   pw.BoxDecoration(border: pw.Border.all()),
//                               child: pw.Column(
//                                 //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                                 children: [
//                                   pw.Row(children: [
//                                     pw.Text("FONE/FAX",
//                                         style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.left),
//                                   ]),
//                                   pw.SizedBox(height: 4),
//                                   pw.Row(children: [
//                                     pw.Text('${widget.dest_fone}',
//                                         style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.left,
//                                         softWrap: true,
//                                         overflow: pw.TextOverflow.clip),
//                                   ])
//                                 ],
//                               ),
//                             ),
//                           ]),
//                           pw.Column(children: [
//                             pw.Container(
//                               width: 30,
//                               height: 30,
//                               padding: pw.EdgeInsets.all(5),
//                               decoration:
//                                   pw.BoxDecoration(border: pw.Border.all()),
//                               child: pw.Column(
//                                 //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                                 children: [
//                                   pw.Row(children: [
//                                     pw.Text("UF",
//                                         style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.left),
//                                   ]),
//                                   pw.SizedBox(height: 4),
//                                   pw.Row(children: [
//                                     pw.Text('${widget.dest_uf}',
//                                         style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.left,
//                                         softWrap: true,
//                                         overflow: pw.TextOverflow.clip),
//                                   ])
//                                 ],
//                               ),
//                             ),
//                           ]),
//                           pw.Column(children: [
//                             pw.Container(
//                               width: 100,
//                               height: 30,
//                               padding: pw.EdgeInsets.all(5),
//                               decoration:
//                                   pw.BoxDecoration(border: pw.Border.all()),
//                               child: pw.Column(
//                                 //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                                 children: [
//                                   pw.Row(children: [
//                                     pw.Text("INSCRIÇÃO ESTADUAL",
//                                         style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.left),
//                                   ]),
//                                   pw.SizedBox(height: 4),
//                                   pw.Row(children: [
//                                     pw.Text('${widget.dest_ie}',
//                                         style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.left,
//                                         softWrap: true,
//                                         overflow: pw.TextOverflow.clip),
//                                   ])
//                                 ],
//                               ),
//                             ),
//                           ]),
//                           pw.Column(children: [
//                             pw.Container(
//                               width: 100,
//                               height: 30,
//                               padding: pw.EdgeInsets.all(5),
//                               decoration:
//                                   pw.BoxDecoration(border: pw.Border.all()),
//                               child: pw.Column(
//                                 //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                                 children: [
//                                   pw.Row(children: [
//                                     pw.Text("HORA DA SAÍDA",
//                                         style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.left),
//                                   ]),
//                                   pw.SizedBox(height: 4),
//                                   pw.Row(children: [
//                                     pw.Text(
//                                         '${DateFormat('HH:mm:ss').format(widget.dt_e_s)}',
//                                         style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                         textAlign: pw.TextAlign.left,
//                                         softWrap: true,
//                                         overflow: pw.TextOverflow.clip),
//                                   ])
//                                 ],
//                               ),
//                             ),
//                           ]),
//                         ])
//                       ],
//                       if (context.pageNumber == 1) ...[
//                         pw.SizedBox(height: 5),
//                         pw.Text('CÁLCULO DO IMPOSTO',
//                             style: pw.TextStyle(
//                                 fontWeight: pw.FontWeight.bold, fontSize: 9, font: TimesNewRoman)),
//                         pw.Row(children: [
//                           pw.Container(
//                             width: 103.75,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("BASE DE CÁLCULO DO ICMS",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(
//                                     mainAxisAlignment: pw.MainAxisAlignment.end,
//                                     children: [
//                                       pw.Text(
//                                           '${currencyFormat.format(widget.vl_bc_icms)}',
//                                           style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                           textAlign: pw.TextAlign.left,
//                                           softWrap: true,
//                                           overflow: pw.TextOverflow.clip),
//                                     ])
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             width: 103.75,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("VALOR DO ICMS",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(
//                                     mainAxisAlignment: pw.MainAxisAlignment.end,
//                                     children: [
//                                       pw.Text(
//                                           '${currencyFormat.format(widget.vl_icms)}',
//                                           style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                           textAlign: pw.TextAlign.left,
//                                           softWrap: true,
//                                           overflow: pw.TextOverflow.clip),
//                                     ])
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             width: 103.75,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("BASE CÁLC. ICMS SUBST",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(
//                                     mainAxisAlignment: pw.MainAxisAlignment.end,
//                                     children: [
//                                       pw.Text(
//                                           '${currencyFormat.format(widget.vl_bc_icms_st)}',
//                                           style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                           textAlign: pw.TextAlign.left,
//                                           softWrap: true,
//                                           overflow: pw.TextOverflow.clip),
//                                     ])
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             width: 103.75,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("VALOR DO ICMS SUBST.",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(
//                                     mainAxisAlignment: pw.MainAxisAlignment.end,
//                                     children: [
//                                       pw.Text(
//                                           '${currencyFormat.format(widget.vl_icms_st)}',
//                                           style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                           textAlign: pw.TextAlign.left,
//                                           softWrap: true,
//                                           overflow: pw.TextOverflow.clip),
//                                     ])
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             width: 160,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("VALOR TOTAL DOS PRODUTOS",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(
//                                     mainAxisAlignment: pw.MainAxisAlignment.end,
//                                     children: [
//                                       pw.Text(
//                                           '${currencyFormat.format(widget.vl_merc)}',
//                                           style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                           textAlign: pw.TextAlign.left,
//                                           softWrap: true,
//                                           overflow: pw.TextOverflow.clip),
//                                     ])
//                               ],
//                             ),
//                           ),
//                         ]),
//                         pw.Row(children: [
//                           pw.Container(
//                             width: 83,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("VALOR DO FRETE",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(
//                                     mainAxisAlignment: pw.MainAxisAlignment.end,
//                                     children: [
//                                       pw.Text(
//                                           '${currencyFormat.format(widget.vl_frete)}',
//                                           style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                           textAlign: pw.TextAlign.left,
//                                           softWrap: true,
//                                           overflow: pw.TextOverflow.clip),
//                                     ])
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             width: 83,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("VALOR DO SEGURO",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(
//                                     mainAxisAlignment: pw.MainAxisAlignment.end,
//                                     children: [
//                                       pw.Text(
//                                           '${currencyFormat.format(widget.vl_seg)}',
//                                           style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                           textAlign: pw.TextAlign.left,
//                                           softWrap: true,
//                                           overflow: pw.TextOverflow.clip),
//                                     ])
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             width: 83,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("DESCONTO",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(
//                                     mainAxisAlignment: pw.MainAxisAlignment.end,
//                                     children: [
//                                       pw.Text(
//                                           '${currencyFormat.format(widget.vl_desc)}',
//                                           style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                           textAlign: pw.TextAlign.left,
//                                           softWrap: true,
//                                           overflow: pw.TextOverflow.clip),
//                                     ])
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             width: 83,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("OUTRAS DESP. ACESS.",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(
//                                     mainAxisAlignment: pw.MainAxisAlignment.end,
//                                     children: [
//                                       pw.Text(
//                                           '${currencyFormat.format(widget.vl_out_da)}',
//                                           style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                           textAlign: pw.TextAlign.left,
//                                           softWrap: true,
//                                           overflow: pw.TextOverflow.clip),
//                                     ])
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             width: 83,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               //crossAxisAlignment: pw.CrossAxisAlignment.center,
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("VALOR DO IPI",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(
//                                     mainAxisAlignment: pw.MainAxisAlignment.end,
//                                     children: [
//                                       pw.Text(
//                                           '${currencyFormat.format(widget.vl_ipi)}',
//                                           style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                           textAlign: pw.TextAlign.left,
//                                           softWrap: true,
//                                           overflow: pw.TextOverflow.clip),
//                                     ])
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             width: 160,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration: pw.BoxDecoration(
//                                 border: pw.Border.all(),
//                                 color: PdfColor.fromInt(0xffdcdcdc)),
//                             child: pw.Column(
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("VALOR TOTAL DA NOTA",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(
//                                     mainAxisAlignment: pw.MainAxisAlignment.end,
//                                     children: [
//                                       pw.Text(
//                                           '${currencyFormat.format(widget.vl_doc)}',
//                                           style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                           textAlign: pw.TextAlign.left,
//                                           softWrap: true,
//                                           overflow: pw.TextOverflow.clip),
//                                     ])
//                               ],
//                             ),
//                           ),
//                         ]),
//                       ],
//                       if (context.pageNumber == 1) ...[
//                         pw.SizedBox(height: 5),
//                         pw.Text('TRANSPORTADOR / VOLUMES TRANSPORTADOS',
//                             style: pw.TextStyle(
//                                 fontWeight: pw.FontWeight.bold, fontSize: 9, font: TimesNewRoman)),
//                         pw.Row(children: [
//                           pw.Container(
//                             width: 180,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("RAZÃO SOCIAL",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(children: [
//                                   pw.Text(
//                                     widget.trans_razaosocial,
//                                       style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left,
//                                       softWrap: true,
//                                       overflow: pw.TextOverflow.clip),
//                                 ])
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             width: 88.66,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("FRETE POR CONTA",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(children: [
//                                   pw.Text(
//                                     widget.ind_frete == 0 ? '${widget.ind_frete} - REMETENTE' : '${widget.ind_frete} - CONSUMIDOR',
//                                       style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left,
//                                       softWrap: true,
//                                       overflow: pw.TextOverflow.clip),
//                                 ])
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             width: 88.66,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("CÓDIGO ANTT",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(children: [
//                                   pw.Text('${widget.codigorastreio}',
//                                       style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left,
//                                       softWrap: true,
//                                       overflow: pw.TextOverflow.clip),
//                                 ])
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             width: 88.66,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("PLACA DO VEÍCULO",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(children: [
//                                   pw.Text(
//                                     widget.trans_placa,
//                                       style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left,
//                                       softWrap: true,
//                                       overflow: pw.TextOverflow.clip),
//                                 ])
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             width: 30,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("UF",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(children: [
//                                   pw.Text(
//                                     widget.trans_placa_uf,
//                                       style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left,
//                                       softWrap: true,
//                                       overflow: pw.TextOverflow.clip),
//                                 ])
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             width: 99,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("CNPJ/CPF",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(children: [
//                                   pw.Text(
//                                     widget.trans_cnpj.isNotEmpty ? cnpjMaskFormatter.maskText(widget.trans_cnpj)
//                                       : cpfMaskFormatter.maskText(widget.trans_cpf),
//                                       style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left,
//                                       softWrap: true,
//                                       overflow: pw.TextOverflow.clip),
//                                 ])
//                               ],
//                             ),
//                           ),
//                         ]),
//                         pw.Row(children: [
//                           pw.Container(
//                             width: 333,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("ENDEREÇO",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(children: [
//                                   pw.Text(
//                                     widget.trans_end,
//                                       style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left,
//                                       softWrap: true,
//                                       overflow: pw.TextOverflow.clip),
//                                 ])
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             width: 113,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("MUNICÍPIO",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(children: [
//                                   pw.Text(
//                                     widget.trans_mun,
//                                       style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left,
//                                       softWrap: true,
//                                       overflow: pw.TextOverflow.clip),
//                                 ])
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             width: 30,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("UF",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(children: [
//                                   pw.Text(
//                                     widget.trans_uf,
//                                       style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left,
//                                       softWrap: true,
//                                       overflow: pw.TextOverflow.clip),
//                                 ])
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             width: 99,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("INSCRIÇÃO ESTADUAL",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(children: [
//                                   pw.Text(
//                                     widget.trans_ie,
//                                       style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left,
//                                       softWrap: true,
//                                       overflow: pw.TextOverflow.clip),
//                                 ])
//                               ],
//                             ),
//                           ),
//                         ]),
//                         pw.Row(children: [
//                           pw.Container(
//                             width: 80,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("QUANTIDADE",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(children: [
//                                   pw.Text(
//                                     widget.quant_volume.toString(),
//                                       style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left,
//                                       softWrap: true,
//                                       overflow: pw.TextOverflow.clip),
//                                 ])
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             width: 99,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("ESPÉCIE",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(children: [
//                                   pw.Text(
//                                     widget.especie,
//                                       style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left,
//                                       softWrap: true,
//                                       overflow: pw.TextOverflow.clip),
//                                 ])
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             width: 99,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("MARCA",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(children: [
//                                   pw.Text(
//                                     widget.marca,
//                                       style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left,
//                                       softWrap: true,
//                                       overflow: pw.TextOverflow.clip),
//                                 ])
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             width: 99,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("NUMERAÇÃO",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(children: [
//                                   pw.Text('',
//                                       style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left,
//                                       softWrap: true,
//                                       overflow: pw.TextOverflow.clip),
//                                 ])
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             width: 99,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("PESO BRUTO",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(children: [
//                                   pw.Text(
//                                     widget.peso_bruto.toString(),
//                                       style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left,
//                                       softWrap: true,
//                                       overflow: pw.TextOverflow.clip),
//                                 ])
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             width: 99,
//                             height: 30,
//                             padding: pw.EdgeInsets.all(5),
//                             decoration:
//                                 pw.BoxDecoration(border: pw.Border.all()),
//                             child: pw.Column(
//                               children: [
//                                 pw.Row(children: [
//                                   pw.Text("PESO LÍQUIDO",
//                                       style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left),
//                                 ]),
//                                 pw.SizedBox(height: 4),
//                                 pw.Row(children: [
//                                   pw.Text(
//                                     widget.peso_liq.toString(),
//                                       style: pw.TextStyle(fontSize: 8, font: TimesNewRoman),
//                                       textAlign: pw.TextAlign.left,
//                                       softWrap: true,
//                                       overflow: pw.TextOverflow.clip),
//                                 ])
//                               ],
//                             ),
//                           ),
//                         ]),
//                       ],
//                       pw.SizedBox(height: 5),
//                       if (context.pageNumber == 1) ...[
//                         pw.Text('DADOS DO PRODUTO / SERVIÇOS',
//                             style: pw.TextStyle(
//                                 fontWeight: pw.FontWeight.bold, fontSize: 9, font: TimesNewRoman)),
//                       ] else
//                         pw.Text('CONTINUAÇÃO DOS DADOS DO PRODUTO / SERVIÇOS',
//                             style: pw.TextStyle(
//                                 fontWeight: pw.FontWeight.bold, fontSize: 9, font: TimesNewRoman)),
//                     ]),
//             build: (pw.Context context) {
//               return [
//                 pw.TableHelper.fromTextArray(
//                     headers: [
//                       "CÓDIGO",
//                       "DESCRIÇÃO",
//                       "NCM/SH",
//                       "CST",
//                       "CFOP",
//                       "UNID.",
//                       "QTD.",
//                       "Vl. UNIT",
//                       "Vl. TOTAL",
//                       "DESC.",
//                       "BC. ICMS",
//                       "Vl. ICMS",
//                       "Vl. IPI",
//                       "ALIQ. ICMS",
//                       "ALIQ. IPI",
//                     ],
//                     headerDecoration: pw.BoxDecoration(
//                       color: PdfColor.fromInt(0xffdcdcdc),
//                     ),
//                     headerAlignment: pw.Alignment.center,
//                     headerStyle: pw.TextStyle(fontSize: 7, font: TimesNewRoman),
//                     data: nfeItems.map((item) {
//                       return [
//                         item.codigo ??
//                             "", // Substitui null por string vazia se necessário
//                         item.nome ?? "",
//                         item.ncm ?? "",
//                         item.cst_icms ?? "",
//                         item.cfop ?? "",
//                         item.unid_comercial ?? "",
//                         item.quantidade_comercial?.toString() ?? "",
//                         item.valor_unit_comercial?.toStringAsFixed(2) ?? "",
//                         (item.quantidade_comercial! * item.valor_unit_comercial)
//                                 ?.toStringAsFixed(2) ??
//                             "",
//                         item.vl_desc?.toStringAsFixed(2) ?? "",
//                         item.vl_bc_icms?.toStringAsFixed(2) ?? "",
//                         item.vl_icms?.toStringAsFixed(2) ?? "",
//                         item.vl_ipi?.toStringAsFixed(2) ?? "0.00",
//                         item.aliq_icms?.toStringAsFixed(2) ?? "",
//                         item.aliq_ipi?.toStringAsFixed(2) ?? "",
//                       ];
//                     }).toList(),
//                     cellStyle: pw.TextStyle(fontSize: 6, font: TimesNewRoman),
//                     cellAlignment: pw.Alignment.center),
//               ];
//             },
//             //pw.Spacer(),
//             footer: (pw.Context context) {
//               if (context.pageNumber != 1) return pw.SizedBox();
//               return pw.Align(
//                 alignment: pw.Alignment.bottomCenter,
//                 child: pw.Column(
//                   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                   children: [
//                     pw.Row(children: [
//                       pw.Text('DADOS ADICIONAIS',
//                           style: pw.TextStyle(
//                               fontWeight: pw.FontWeight.bold, fontSize: 9, font: TimesNewRoman)),
//                     ]),
//                     pw.Row(children: [
//                       pw.Container(
//                         width: 365,
//                         height: 100,
//                         padding: pw.EdgeInsets.all(5),
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Column(
//                           children: [
//                             pw.Row(children: [
//                               pw.Text("INFROMAÇÕES COMPLEMENTARES",
//                                   style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                   textAlign: pw.TextAlign.left),
//                             ]),
//                             pw.SizedBox(height: 4),
//                             pw.Row(children: [
//                               pw.Container(
//                                 width: 361,
//                                 child: pw.Text('${widget.mensagem}',
//                                     style: pw.TextStyle(fontSize: 10, font: TimesNewRoman),
//                                     textAlign: pw.TextAlign.left,
//                                     softWrap: true,
//                                     overflow: pw.TextOverflow.clip),
//                               )
//                             ])
//                           ],
//                         ),
//                       ),
//                       pw.Container(
//                         width: 210,
//                         height: 100,
//                         padding: pw.EdgeInsets.all(5),
//                         decoration: pw.BoxDecoration(border: pw.Border.all()),
//                         child: pw.Column(
//                           children: [
//                             pw.Row(children: [
//                               pw.Text("RESERVADO AO FÍSICO",
//                                   style: pw.TextStyle(fontSize: 4, font: TimesNewRoman),
//                                   textAlign: pw.TextAlign.left),
//                             ]),
//                             pw.SizedBox(height: 4),
//                           ],
//                         ),
//                       ),
//                     ]),
//                     pw.SizedBox(
//                       height: 5
//                     ),
//                     pw.Row(
//                       mainAxisAlignment: pw.MainAxisAlignment.end,
//                       children: [
//                         pw.Text('Ideia Tecnologia',
//                             style: pw.TextStyle(
//                                 //fontWeight: pw.FontWeight.bold,
//                                 font: TimesNewRoman,
//                                 fontItalic: pw.Font.timesBoldItalic(),
//                                 fontSize: 5))
//                       ])
//                   ],
//                 ),
//               );
//             }

//             // Informações dos Produtos

//             // Espaço flexível para empurrar os elementos para o final
//             ),
//       );
      

//     // Obter o diretório para salvar o PDF
//     final outputDir = await getApplicationDocumentsDirectory();
//     final file = File('${outputDir.path}/${widget.chv_nfe}.pdf');
//     await file.writeAsBytes(await pdf.save());

//     setState(() {
//       pdfFilePath = file.path;
//     });

//     // Abrir o PDF automaticamente após criar
//     openPdfViewer();
//   }