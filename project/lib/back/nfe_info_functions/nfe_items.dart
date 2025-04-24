import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/Front/components/style.dart';

class NfeItems {
  String? codigo;
  String? nome;
  String? unid_comercial;
  String? ncm;
  String? cst_icms;
  String? cfop;
  int? quantidade_comercial;
  int? numero_item;
  dynamic valor_unit_comercial;
  dynamic vl_desc;
  dynamic vl_bc_icms;
  dynamic vl_icms;
  dynamic vl_ipi;
  dynamic aliq_icms;
  dynamic aliq_ipi;

  NfeItems({
    required this.codigo,
    required this.nome,
    required this.unid_comercial,
    required this.ncm,
    required this.cst_icms,
    required this.cfop,
    required this.quantidade_comercial,
    required this.numero_item,
    required this.valor_unit_comercial,
    required this.vl_desc,
    required this.vl_bc_icms,
    required this.vl_icms,
    required this.aliq_icms,
    required this.aliq_ipi,
  });

  factory NfeItems.fromJson(Map<String, dynamic> json) {
    return NfeItems(
      codigo: (json['codigo'] ?? '').toString(),
      nome: (json['nome'] ?? '').toString(),
      unid_comercial: (json['unid_comercial'] ?? '').toString(),
      ncm: (json['ncm'] ?? '').toString(),
      cst_icms: (json['cst_icms'] ?? '').toString(),
      cfop: (json['cfop'] ?? '').toString(),
      quantidade_comercial: (json['quantidade_comercial'] ?? 0).toInt(),
      numero_item: (json['numero_item'] ?? 0).toInt(),
      valor_unit_comercial: json['valor_unit_comercial'] is int
          ? (json['valor_unit_comercial'] as int).toDouble()
          : json['valor_unit_comercial'] is double
              ? json['valor_unit_comercial'] as double
              : 0.0,
      vl_desc: json['vl_desc'] is int
          ? (json['vl_desc'] as int).toDouble()
          : json['vl_desc'] is double
              ? json['vl_desc'] as double
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
      aliq_icms: json['aliq_icms'] is int
          ? (json['aliq_icms'] as int).toDouble()
          : json['aliq_icms'] is double
              ? json['aliq_icms'] as double
              : 0.0,
      aliq_ipi: json['aliq_ipi'] is int
          ? (json['aliq_ipi'] as int).toDouble()
          : json['aliq_ipi'] is double
              ? json['aliq_ipi'] as double
              : 0.0,
    );
  }
}

class DataServiceNfeItem {
  static Future<List<NfeItems>?> fetchDataNfeItem(
    context,
    String urlBasic,
    String documentonfe_id,
  ) async {
    List<NfeItems>? nfeItems;

    try {
      String rawQueryDay = '''documentonfeitem%20di%20WHERE%20di.documentonfe_id%20=%20'$documentonfe_id'/''';

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
            nfeItems = dataList.map((e) => NfeItems.fromJson(e)).toList();

            nfeItems.sort((a, b) {
            return a.numero_item!.compareTo(b.numero_item!);
          });
          } else {
            print('A chave dinâmica não contém uma lista válida.');
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              padding: EdgeInsets.all(Style.SaveUrlMessagePadding(context)),
              content: Text(
                'Não há produtos nesta Nota',
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
    return nfeItems;
  }
}
