import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/Front/components/style.dart';

//Código onde serão acessados os dados de vendas do dia.

class PaymentNFe {
  String? nomecondicaopagamento;
  dynamic valorpagamento;

  PaymentNFe({
    required this.nomecondicaopagamento,
    required this.valorpagamento,
  });

  factory PaymentNFe.fromJson(Map<String, dynamic> json) {
    return PaymentNFe(
      nomecondicaopagamento: (json['nomecondicaopagamento'] ?? '').toString(),
      valorpagamento: json['valorpagamento'] is int
          ? (json['valorpagamento'] as int).toDouble()
          : json['valorpagamento'] is double
              ? json['valorpagamento'] as double
              : 0.0,
    );
  }
}

class DataServicePaymentNFe {
  static Future<List<PaymentNFe>?> fetchDataPaymentNFe(
      BuildContext context, String urlBasic, String documetonfe_id) async {
    List<PaymentNFe>? paymentNFe;

    try {
      print('$documetonfe_id');
      String rawQueryDay =
          '''documentonfe%20d%20inner%20join%20documentonfemovimento%20dnm%20ON%20(%20d.documentonfe_id%20=%20dnm.documentonfe_id)%20INNER%20JOIN%20movimentosaidapagamento%20msp%20ON%20(msp.movimentosaida_id%20=%20dnm.movimentosaida_id)%20WHERE%20d.documentonfe_id%20=%20'$documetonfe_id'/''';

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
            paymentNFe = dataList.map((e) => PaymentNFe.fromJson(e)).toList();
            print(response.body);
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
        print('Erro HTTP Payment: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro durante a requisição PaymentNFeValues: $e');
    }
    return paymentNFe;
  }
}
