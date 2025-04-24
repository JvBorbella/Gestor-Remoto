import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/Front/components/style.dart';

class NfeItems {
  String? codigo;
  String? nome;
  int? quantidade_comercial;
  dynamic valor_unit_comercial;

  NfeItems({
    required this.codigo,
    required this.nome,
    required this.quantidade_comercial,
    required this.valor_unit_comercial,
  });

  factory NfeItems.fromJson(Map<String, dynamic> json) {
    return NfeItems(
      codigo: (json['codigo'] ?? '').toString(),
      nome: (json['nome'] ?? '').toString(),
      quantidade_comercial: (json['quantidade_comercial'] ?? 0).toInt(),
      valor_unit_comercial: json['valor_unit_comercial'] is int
          ? (json['valor_unit_comercial'] as int).toDouble()
          : json['valor_unit_comercial'] is double
              ? json['valor_unit_comercial'] as double
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
