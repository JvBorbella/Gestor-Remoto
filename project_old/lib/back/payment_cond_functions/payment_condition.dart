import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaymentCondition {
  String? condicaopagamento_id;
  String? nome;
  String? flagexcluido;

  PaymentCondition({
    required this.condicaopagamento_id,
    required this.nome,
    required this.flagexcluido,
  });

  factory PaymentCondition.fromJson(Map<String, dynamic> json) {
    return PaymentCondition(
      condicaopagamento_id: (json['condicaopagamento_id'] ?? '').toString(),
      nome: (json['nome'] ?? '').toString(),
      flagexcluido: (json['nome'] ?? 0).toString(),
    );
  }
}

class DataServicePaymentsCondition {
  static Future<List<PaymentCondition>?> fetchDataPaymentsCondition(
    BuildContext context,
    String urlBasic,
  ) async {
    List<PaymentCondition>? paymentsCondition;

    try {
      var urlPost =
          Uri.parse('$urlBasic/ideia/core/getdata/condicaopagamento/');

      print(urlPost);

      var response = await http.get(
        urlPost,
        headers: {
          'Accept': 'text/html',
        },
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        print(response.statusCode);

        if (jsonData.containsKey('data') && jsonData['data'].isNotEmpty) {
          paymentsCondition = (jsonData['data']['condicaopagamento'] as List)
              .map((e) => PaymentCondition.fromJson(e))
              .toList();

          // paymentsCondition = paymentsCondition
          //     .where((payments) => payments.flagexcluido == '0')
          //     .toList();

          // print(response.body);
        } else {
          print('Dados ausentes no JSON. PaymentsCondition');
        }
      }
    } catch (e) {
      print('Erro durante a requisição PaymentsCondition: $e');
    }
    return paymentsCondition;
  }
}
