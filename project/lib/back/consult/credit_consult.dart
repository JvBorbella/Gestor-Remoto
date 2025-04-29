import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:project/Front/components/style.dart';

class CreditConsult {
  //--- Produto ---
  String? descricao;
  String? numerodocumento;
  String? nome;
  dynamic datadocumento;
  dynamic datavencimento;
  dynamic valor;

  CreditConsult({
    required this.descricao,
    required this.numerodocumento,
    required this.nome,
    required this.datadocumento,
    required this.datavencimento,
    required this.valor,
  });

  factory CreditConsult.fromJson(Map<String, dynamic> json) {
    return CreditConsult(
      descricao: (json['descricao'] ?? '').toString(),
      numerodocumento: (json['numerodocumento'] ?? '').toString(),
      nome: (json['nome'] ?? '').toString(),
      datadocumento: json['datadocumento'] != null
          ? DateTime.parse(json['datadocumento'])
          : null,
      datavencimento: json['datavencimento'] != null
          ? DateTime.parse(json['datavencimento'])
          : null,
      valor: json['valor'] is int
          ? (json['valor'] as int).toDouble()
          : json['valor'] is double
              ? json['valor'] as double
              : 0.0,
    );
  }
}

class DataServiceCreditConsult {
  static Future<List<CreditConsult>?> fetchDataCreditConsult(
    context,
    String urlBasic,
    String empresa_id,
    String cpfController,
  ) async {
    List<CreditConsult>? creditConsult;

    String getUnmaskedText(String maskedText) {
      // Remove todos os caracteres não numéricos
      return maskedText.replaceAll(RegExp(r'\D'), '');
    }

    var cpfDefault = getUnmaskedText(cpfController);

    try {
      print(DateFormat('yyyy-MM-dd').format(DateTime.now()));
      String rawQueryDay =
          '''titulopagar%20t%20LEFT%20JOIN%20pessoa%20p%20ON%20t.pessoa_id%20=%20p.pessoa_id%20WHERE%20${cpfDefault.length > 11 ? "p.cnpj%20=%20'$cpfDefault'" : "p.cpf%20=%20'$cpfDefault'"}%20AND%20t.flagquitado%20<>%201%20AND%20t.flagvalecredito%20=%201%20AND%20COALESCE(t.flagexcluido,%200)%20=%200%20AND%20t.datavencimento%20>=%20'${DateFormat('yyyy-MM-dd').format(DateTime.now())}'%20AND%20t.flagcancelado%20<>%201%20AND%20COALESCE(t.flagautorizado,%200)%20=%200/''';

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
            creditConsult =
                dataList.map((e) => CreditConsult.fromJson(e)).toList();

            creditConsult.sort((a, b) {
              return a.datadocumento.compareTo(b.datadocumento);
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
                'Créditos não encontrados',
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
    return creditConsult;
  }
}
