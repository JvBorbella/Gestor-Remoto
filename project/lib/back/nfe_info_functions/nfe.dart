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
  String? em_cnpj;
  String? em_cpf;
  String? em_ie;
  String? em_fone;
  String? em_end;
  String? em_num;
  String? em_bairro;
  String? em_mun;
  String? em_uf;
  String? em_cep;
  String? dest_razaosocial;
  String? dest_cnpj;
  String? dest_cpf;
  String? dest_end;
  String? dest_num;
  String? dest_cep;
  String? dest_bairro;
  String? dest_mun;
  String? dest_fone;
  String? dest_ie;
  String? dest_uf;
  String? trans_razaosocial;
  String? trans_cnpj;
  String? trans_cpf;
  String? trans_ie;
  String? trans_fone;
  String? trans_end;
  String? trans_num;
  String? trans_mun;
  String? trans_uf;
  String? trans_cep;
  String? trans_placa;
  String? trans_placa_uf;
  dynamic? quant_volume;
  dynamic? peso_liq;
  dynamic? peso_bruto;
  String? marca;
  String? especie;
  String? codigorastreio;
  dynamic? ind_frete;
  String? codigoretorno;
  String? descricaoretorno;
  String? finalidade;

  String? empresa_nome;
  String? empresa_codigo;
  String? mensagem;

  String? protocolo;
  dynamic? datahoraaut;

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
    required this.em_cnpj,
    required this.em_cpf,
    required this.em_ie,
    required this.em_fone,
    required this.em_end,
    required this.em_num,
    required this.em_bairro,
    required this.em_mun,
    required this.em_uf,
    required this.em_cep,
    required this.dest_razaosocial,
    required this.dest_cnpj,
    required this.dest_cpf,
    required this.dest_end,
    required this.dest_num,
    required this.dest_cep,
    required this.dest_bairro,
    required this.dest_mun,
    required this.dest_fone,
    required this.dest_ie,
    required this.dest_uf,
    required this.trans_razaosocial,
    required this.trans_cnpj,
    required this.trans_cpf,
    required this.trans_ie,
    required this.trans_fone,
    required this.trans_end,
    required this.trans_num,
    required this.trans_mun,
    required this.trans_uf,
    required this.trans_cep,
    required this.trans_placa,
    required this.trans_placa_uf,
    required this.quant_volume,
    required this.peso_liq,
    required this.peso_bruto,
    required this.marca,
    required this.especie,
    required this.codigorastreio,
    required this.ind_frete,
    required this.codigoretorno,
    required this.descricaoretorno,
    required this.finalidade,
    required this.empresa_nome,
    required this.empresa_codigo,
    required this.mensagem,
    required this.protocolo,
    required this.datahoraaut,
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
      em_cnpj: (json['em_cnpj'] ?? '').toString(),
      em_cpf: (json['em_cpf'] ?? '').toString(),
      em_ie: (json['em_ie'] ?? '').toString(),
      em_fone: (json['em_fone'] ?? '').toString(),
      em_end: (json['em_end'] ?? '').toString(),
      em_num: (json['em_num'] ?? '').toString(),
      em_bairro: (json['em_bairro'] ?? '').toString(),
      em_mun: (json['em_mun'] ?? '').toString(),
      em_uf: (json['em_uf'] ?? '').toString(),
      em_cep: (json['em_cep'] ?? '').toString(),
      dest_razaosocial: (json['dest_razaosocial'] ?? '').toString(),
      dest_cnpj: (json['dest_cnpj'] ?? '').toString(),
      dest_cpf: (json['dest_cpf'] ?? '').toString(),
      dest_end: (json['dest_end'] ?? '').toString(),
      dest_num: (json['dest_num'] ?? '').toString(),
      dest_cep: (json['dest_cep'] ?? '').toString(),
      dest_bairro: (json['dest_bairro'] ?? '').toString(),
      dest_mun: (json['dest_mun'] ?? '').toString(),
      dest_fone: (json['dest_fone'] ?? '').toString(),
      dest_ie: (json['dest_ie'] ?? '').toString(),
      dest_uf: (json['dest_uf'] ?? '').toString(),
      trans_razaosocial: (json['trans_razaosocial'] ?? '').toString(),
      trans_cnpj: (json['trans_cnpj'] ?? '').toString(),
      trans_cpf: (json['trans_cpf'] ?? '').toString(),
      trans_ie: (json['trans_ie'] ?? '').toString(),
      trans_fone: (json['trans_fone'] ?? '').toString(),
      trans_end: (json['trans_end'] ?? '').toString(),
      trans_num: (json['trans_num'] ?? '').toString(),
      // trans_bairro: (json['em_bairro'] ?? '').toString(),
      trans_mun: (json['trans_mun'] ?? '').toString(),
      trans_uf: (json['trans_uf'] ?? '').toString(),
      trans_cep: (json['trans_cep'] ?? '').toString(),
      trans_placa: (json['trans_placa'] ?? '').toString(),
      trans_placa_uf: (json['trans_placa_uf'] ?? '').toString(),
      quant_volume: json['quant_volume'] is int
          ? (json['quant_volume'] as int).toDouble()
          : json['quant_volume'] is double
              ? json['quant_volume'] as double
              : 0.0,
      peso_liq: (json['peso_liq'] ?? 0).toInt(),
      peso_bruto: (json['peso_bruto'] ?? 0).toInt(),
      marca: (json['marca'] ?? '').toString(),
      especie: (json['especie'] ?? '').toString(),
      codigorastreio: (json['codigorastreio'] ?? '').toString(),
      ind_frete: (json['ind_frete'] ?? 0).toInt(),
      codigoretorno: (json['codigoretorno'] ?? '').toString(),
      descricaoretorno: (json['descricaoretorno'] ?? '').toString(),
      finalidade: (json['finalidade'] ?? '').toString(),

      empresa_nome: (json['empresa_nome'] ?? '').toString(),
      empresa_codigo: (json['empresa_codigo'] ?? '').toString(),
      mensagem: (json['mensagem'] ?? '').toString(),

      protocolo: (json['protocolo'] ?? '').toString(),
      datahoraaut:
          json['datahora'] != null ? DateTime.parse(json['datahora']) : null,
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
      var cpfController = searchController.length == 11 ? searchController : '';
      var cnpjController = searchController.length == 14 ? searchController : '';
      var numController = searchController.length < 11 ? searchController : '';

      String rawQueryDay =
          '''documentonfe%20d%20LEFT%20JOIN%20empresa%20e%20ON%20d.empresa_id%20=%20e.empresa_id%20LEFT%20JOIN%20mensagemfiscal%20m%20ON%20e.mensagemfiscal_id%20=%20m.mensagemfiscal_id%20LEFT%20JOIN%20documentonfeenvio%20de%20ON%20d.documentonfe_id%20=%20de.documentonfe_id%20LEFT%20JOIN%20pessoa%20p%20ON%20d.pessoa_destinatario_id%20=%20p.pessoa_id%20WHERE%20d.dt_doc%20$data%20AND%20('$empresa_id'%20=%20''%20OR%20d.empresa_id%20=%20'$empresa_id')%20AND%20d.num_doc%20LIKE%20'$numController%25'%20AND%20('$cpfController'%20=%20''%20OR%20p.cpf%20=%20'$cpfController')%20AND%20('$cnpjController'%20=%20''%20OR%20p.cnpj%20=%20'$cnpjController')/''';

      var urlPost = Uri.parse('$urlBasic/ideia/core/getdata/$rawQueryDay');

      print(urlPost);

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
