import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/Front/components/style.dart';

//Código onde serão acessados os dados de vendas do dia.

class Nfe {
  String? documentonfe_id;
  String? empresa_id;
  String? num_doc;
  String? chv_nfe;
  String? serie;
  DateTime? dt_doc;
  DateTime? dt_e_s;
  dynamic vl_doc;
  dynamic vl_desc;
  dynamic vl_merc;
  dynamic vl_frete;
  dynamic vl_bc_icms;
  dynamic vl_icms;
  dynamic vl_bc_icms_st;
  dynamic vl_icms_st;
  dynamic vl_ipi;
  dynamic vl_cofins;
  dynamic vl_pis_st;
  dynamic vl_pis;
  dynamic vl_cofins_st;
  dynamic vl_ii;
  dynamic vl_out_da;
  dynamic vl_seg;
  dynamic vl_icmsfecp;
  dynamic vl_icmsfecp_st;
  String? desc_nat_op;
  String? cod_mod;
  String? em_razaosocial;
  String? dest_razaosocial;
  String? codigoretorno;
  String? descricaoretorno;
  String? finalidade;

  Nfe({
    required this.documentonfe_id,
    required this.empresa_id,
    required this.num_doc,
    required this.chv_nfe,
    required this.serie,
    required this.dt_doc,
    required this.dt_e_s,
    required this.vl_doc,
    required this.vl_desc,
    required this.vl_merc,
    required this.vl_frete,
    required this.vl_bc_icms,
    required this.vl_icms,
    required this.vl_bc_icms_st,
    required this.vl_icms_st,
    required this.vl_ipi,
    required this.vl_cofins,
    required this.vl_pis_st,
    required this.vl_pis,
    required this.vl_cofins_st,
    required this.vl_ii,
    required this.vl_out_da,
    required this.vl_seg,
    required this.vl_icmsfecp,
    required this.vl_icmsfecp_st,
    required this.desc_nat_op,
    required this.cod_mod,
    required this.em_razaosocial,
    required this.dest_razaosocial,
    required this.codigoretorno,
    required this.descricaoretorno,
    required this.finalidade,
  });

  factory Nfe.fromJson(Map<String, dynamic> json) {
    return Nfe(
      documentonfe_id: (json['documentonfe_id'] ?? '').toString(),
      empresa_id: (json['empresa_id'] ?? '').toString(),
      num_doc: (json['num_doc'] ?? '').toString(),
      chv_nfe: (json['chv_nfe'] ?? '').toString(),
      serie: (json['serie'] ?? '').toString(),
      dt_doc: json['dt_doc'] != null ? DateTime.parse(json['dt_doc']) : null,
      dt_e_s: json['dt_e_s'] != null ? DateTime.parse(json['dt_e_s']) : null,
      vl_doc: json['vl_doc'] is int
          ? (json['vl_doc'] as int).toDouble()
          : json['vl_doc'] is double
              ? json['vl_doc'] as double
              : 0.0,
      vl_desc: json['vl_desc'] is int
          ? (json['vl_desc'] as int).toDouble()
          : json['vl_doc'] is double
              ? json['vl_desc'] as double
              : 0.0,
      vl_merc: json['vl_merc'] is int
          ? (json['vl_merc'] as int).toDouble()
          : json['vl_merc'] is double
              ? json['vl_merc'] as double
              : 0.0,
      vl_frete: json['vl_frete'] is int
          ? (json['vl_frete'] as int).toDouble()
          : json['vl_frete'] is double
              ? json['vl_frete'] as double
              : 0.0,
      vl_bc_icms: json['vl_bc_icms'] is int
          ? (json['vl_bc_icms'] as int).toDouble()
          : json['vl_bc_icms'] is double
              ? json['vl_bc_icms'] as double
              : 0.0,
      vl_icms: json['vl_icms'] is int
          ? (json['vl_icms'] as int).toDouble()
          : json['vl_icms'] is double
              ? json['vl_icms'] as double
              : 0.0,
      vl_bc_icms_st: json['vl_bc_icms_st'] is int
          ? (json['vl_bc_icms_st'] as int).toDouble()
          : json['vl_bc_icms_st'] is double
              ? json['vl_bc_icms_st'] as double
              : 0.0,
      vl_icms_st: json['vl_icms_st'] is int
          ? (json['vl_icms_st'] as int).toDouble()
          : json['vl_icms_st'] is double
              ? json['vl_icms_st'] as double
              : 0.0,
      vl_ipi: json['vl_ipi'] is int
          ? (json['vl_ipi'] as int).toDouble()
          : json['vl_ipi'] is double
              ? json['vl_ipi'] as double
              : 0.0,
      vl_cofins: json['vl_cofins'] is int
          ? (json['vl_cofins'] as int).toDouble()
          : json['vl_cofins'] is double
              ? json['vl_cofins'] as double
              : 0.0,
      vl_pis_st: json['vl_pis_st'] is int
          ? (json['vl_pis_st'] as int).toDouble()
          : json['vl_pis_st'] is double
              ? json['vl_pis_st'] as double
              : 0.0,
      vl_pis: json['vl_pis'] is int
          ? (json['vl_pis'] as int).toDouble()
          : json['vl_pis'] is double
              ? json['vl_pis'] as double
              : 0.0,
      vl_cofins_st: json['vl_cofins_st'] is int
          ? (json['vl_cofins_st'] as int).toDouble()
          : json['vl_cofins_st'] is double
              ? json['vl_cofins_st'] as double
              : 0.0,
      vl_ii: json['vl_ii'] is int
          ? (json['vl_ii'] as int).toDouble()
          : json['vl_ii'] is double
              ? json['vl_ii'] as double
              : 0.0,
      vl_out_da: json['vl_out_da'] is int
          ? (json['vl_out_da'] as int).toDouble()
          : json['vl_out_da'] is double
              ? json['vl_out_da'] as double
              : 0.0,
      vl_seg: json['vl_seg'] is int
          ? (json['vl_seg'] as int).toDouble()
          : json['vl_seg'] is double
              ? json['vl_seg'] as double
              : 0.0,
      vl_icmsfecp: json['vl_icmsfecp'] is int
          ? (json['vl_icmsfecp'] as int).toDouble()
          : json['vl_icmsfecp'] is double
              ? json['vl_icmsfecp'] as double
              : 0.0,
      vl_icmsfecp_st: json['vl_icmsfecp_st'] is int
          ? (json['vl_icmsfecp_st'] as int).toDouble()
          : json['vl_icmsfecp_st'] is double
              ? json['vl_icmsfecp_st'] as double
              : 0.0,
      desc_nat_op: (json['desc_nat_op'] ?? '').toString(),
      cod_mod: (json['cod_mod'] ?? '').toString(),
      em_razaosocial: (json['em_razaosocial'] ?? '').toString(),
      dest_razaosocial: (json['dest_razaosocial'] ?? '').toString(),
      codigoretorno: (json['codigoretorno'] ?? '').toString(),
      descricaoretorno: (json['descricaoretorno'] ?? '').toString(),
      finalidade: (json['finalidade'] ?? '').toString(),
    );
  }
}

class DataServiceNfe {
  static Future<List<Nfe>?> fetchDataNfe(
      BuildContext context,
      String urlBasic,
      String empresa_id,
      String data,
      VoidCallback? onProductAdded,
      String searchController,
      String codTipoNfe) async {
    List<Nfe>? nfe;

    try {
        String rawQueryDay = '''documentonfe%20d%20WHERE%20d.dt_doc%20$data%20AND%20('$empresa_id'%20=%20''%20OR%20d.empresa_id%20=%20'$empresa_id')%20AND%20d.num_doc%20LIKE%20'$searchController%25'/''';

        var urlPost = Uri.parse('$urlBasic/ideia/core/getdata/$rawQueryDay');

        var response = await http.get(
          urlPost,
          headers: {
            'Accept': 'text/html',
          },
        );

        if (response.statusCode == 200) {
          var jsonData = json.decode(response.body);

          if (jsonData.containsKey('data') && jsonData['data'] is Map) {
            // Busca a primeira chave dentro de 'data', pois ela é dinâmica
            var dynamicKey = jsonData['data'].keys.first;

            // Verifica se o valor associado à chave é uma lista
            var dataList = jsonData['data'][dynamicKey];
            if (dataList != null && dataList is List) {
              nfe = dataList.map((e) => Nfe.fromJson(e)).toList();

              if (codTipoNfe != '' && codTipoNfe != 'open') {
                nfe = nfe
                    .where((nfe) => nfe.codigoretorno == '$codTipoNfe')
                    .toList();
              } else if (codTipoNfe == 'open') {
                nfe = nfe
                    .where((nfe) =>
                        nfe.codigoretorno != '100' &&
                        nfe.codigoretorno != '101' &&
                        nfe.codigoretorno != '110')
                    .toList();
              } else {
                nfe = dataList.map((e) => Nfe.fromJson(e)).toList();
              }
            } else {
              print('A chave dinâmica não contém uma lista válida.');
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                padding: EdgeInsets.all(Style.SaveUrlMessagePadding(context)),
                content: Text(
                  'Não há documentos fiscais neste período',
                  style: TextStyle(
                    fontSize: Style.SaveUrlMessageSize(context),
                    color: Style.tertiaryColor,
                  ),
                ),
                backgroundColor: Style.errorColor,
              ),
            );
            print('Estrutura "data" ausente ou inválida no JSON.');
          }
        } else {
          print('Erro HTTP: ${response.statusCode}');
        }
      } catch (e) {
        print('Erro durante a requisição nfeValues: $e');
      }
      return nfe;
  }
}
