import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:project/Front/components/style.dart';

//Código onde serão acessados os dados de vendas do dia.

class PaymentValues {
  String? condicaopagamento_id;
  String? nomecondicaopagamento;
  dynamic? valor;
  String? flagexcluido;

  PaymentValues({
    required this.condicaopagamento_id,
    required this.nomecondicaopagamento,
    required this.valor,
    required this.flagexcluido,
  });

  factory PaymentValues.fromJson(Map<String, dynamic> json) {
    return PaymentValues(
      condicaopagamento_id: (json['condicaopagamento_id'] ?? '').toString(),
      nomecondicaopagamento: (json['nomecondicaopagamento'] ?? '').toString(),
      valor: json['valor'] is int
          ? (json['valor'] as int).toDouble()
          : json['valor'] is double
              ? json['valor'] as double
              : 0.0,
      flagexcluido: (json['nome'] ?? 0).toString(),
    );
  }
}

class DataServicePaymentValues {
  static Future<List<PaymentValues>?> fetchDataPaymentValues(
      BuildContext context,
      String urlBasic,
      String cond_pgto,
      String ano,
      String mes,
      String dia,
      int flagDay,
      int flagPeriodic,
      VoidCallback? onProductAdded) async {
    List<PaymentValues>? payments;

    String dayFormatter = dia.padLeft(2, '0');
    String monthFormatter = mes.padLeft(2, '0');
    String dateNowFormatter = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(DateTime.now().toString()));

    if (flagDay == 1) {
      try {
        String dayFormatter = dia.padLeft(2, '0');
        String monthFormatter = mes.padLeft(2, '0');

        String rawQueryDay =
            '''movimentosaidapagamento%20mp%20LEFT%20JOIN%20movimentosaida%20m%20ON%20m.movimentosaida_id%20=%20mp.movimentosaida_id%20WHERE%20m.data%20=%20'$ano-$monthFormatter-$dayFormatter'%20AND%20('$cond_pgto'%20=%20''%20OR%20mp.nomecondicaopagamento%20=%20'$cond_pgto')%20AND%20mp.movimentosaidapagamento_id%20IS%20NOT%20NULL/''';
        String queryDay =
            "movimentosaidapagamento mp LEFT JOIN movimentosaida m ON m.movimentosaida_id = mp.movimentosaida_id WHERE m.data = '$ano-$monthFormatter-$dayFormatter' AND ('$cond_pgto' = '' OR mp.nomecondicaopagamento = '$cond_pgto') AND mp.movimentosaidapagamento_id IS NOT NULL/";

        var encodedQuery = Uri.encodeComponent(rawQueryDay);

        var urlPost = Uri.parse('$urlBasic/ideia/core/getdata/$rawQueryDay');

        print('URL Payments Day: $urlPost');

        var response = await http.get(
          urlPost,
          headers: {
            'Accept': 'text/html',
          },
        );

        print(' StatusCode PaymentValues${response.statusCode}');

        if (response.statusCode == 200) {
          var jsonData = json.decode(response.body);

          if (jsonData.containsKey('data') && jsonData['data'] is Map) {
            // Busca a primeira chave dentro de 'data', pois ela é dinâmica
            var dynamicKey = jsonData['data'].keys.first;
            print('Chave dinâmica encontrada: $dynamicKey');

            // Verifica se o valor associado à chave é uma lista
            var dataList = jsonData['data'][dynamicKey];
            if (dataList != null && dataList is List) {
              payments =
                  dataList.map((e) => PaymentValues.fromJson(e)).toList();

              print('A chave dinâmica contém uma lista válida.');
            } else {
              print('A chave dinâmica não contém uma lista válida.');
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                padding: EdgeInsets.all(Style.SaveUrlMessagePadding(context)),
                content: Text(
                  'Não houveram vendas com este método de pagamento',
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
        print('Erro durante a requisição PaymentsValues: $e');
      }
      return payments;
    } else if (flagPeriodic == 1) {
      try {
        String dayFormatter = dia.padLeft(2, '0');
        String monthFormatter = mes.padLeft(2, '0');
        String dateNowFormatter = DateFormat('yyyy-MM-dd')
            .format(DateTime.parse(DateTime.now().toString()));

        String rawQueryPeriodic =
            '''movimentosaidapagamento%20mp%20LEFT%20JOIN%20movimentosaida%20m%20ON%20m.movimentosaida_id%20=%20mp.movimentosaida_id%20WHERE%20m.data%20>=%20'$ano-$monthFormatter-$dayFormatter'%20AND%20m.data%20<=%20'$dateNowFormatter'%20AND%20('$cond_pgto'%20=%20''%20OR%20mp.nomecondicaopagamento%20=%20'$cond_pgto')%20AND%20mp.movimentosaidapagamento_id%20IS%20NOT%20NULL/''';
        String queryPeriodic =
            "movimentosaidapagamento mp LEFT JOIN movimentosaida m ON m.movimentosaida_id = mp.movimentosaida_id WHERE m.data >= '$ano-$monthFormatter-$dayFormatter' AND m.data <= '$dateNowFormatter' AND ('$cond_pgto' = '' OR mp.nomecondicaopagamento = '$cond_pgto') AND mp.movimentosaidapagamento_id IS NOT NULL/";

        var encodedQuery = Uri.encodeComponent(rawQueryPeriodic);

        var urlPost =
            Uri.parse('$urlBasic/ideia/core/getdata/$rawQueryPeriodic');

        print('URL Payments Periodic: $urlPost');

        var response = await http.get(
          urlPost,
          headers: {
            'Accept': 'text/html',
          },
        );

        print(' StatusCode PaymentValues${response.statusCode}');

        if (response.statusCode == 200) {
          var jsonData = json.decode(response.body);

          if (jsonData.containsKey('data') && jsonData['data'] is Map) {
            // Busca a primeira chave dentro de 'data', pois ela é dinâmica
            var dynamicKey = jsonData['data'].keys.first;
            print('Chave dinâmica encontrada: $dynamicKey');

            // Verifica se o valor associado à chave é uma lista
            var dataList = jsonData['data'][dynamicKey];
            if (dataList != null && dataList is List) {
              payments =
                  dataList.map((e) => PaymentValues.fromJson(e)).toList();

              print('A chave dinâmica contém uma lista válida.');
            } else {
              print('A chave dinâmica não contém uma lista válida.');
            }
          } else {
            if (onProductAdded != null) {
              onProductAdded!();
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                padding: EdgeInsets.all(Style.SaveUrlMessagePadding(context)),
                content: Text(
                  'Não houveram vendas com este método de pagamento',
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
        print('Erro durante a requisição PaymentsValues: $e');
      }
      return payments;
    } else {
      try {
        //Query principal
        String rawQueryToday =
            '''movimentosaidapagamento%20mp%20LEFT%20JOIN%20movimentosaida%20m%20ON%20m.movimentosaida_id%20=%20mp.movimentosaida_id%20WHERE%20m.data%20=%20CURRENT_DATE()%20AND%20('$cond_pgto'%20=%20''%20OR%20mp.nomecondicaopagamento%20=%20'$cond_pgto')%20AND%20mp.movimentosaidapagamento_id%20IS%20NOT%20NULL/''';
        String queryToday =
            "movimentosaidapagamento mp LEFT JOIN movimentosaida m ON m.movimentosaida_id = mp.movimentosaida_id WHERE m.data = CURRENT_DATE() AND ('$cond_pgto' = '' OR mp.nomecondicaopagamento = '$cond_pgto') AND mp.movimentosaidapagamento_id IS NOT NULL/";

        var encodedQuery = Uri.encodeComponent(rawQueryToday);

        var urlPost = Uri.parse('$urlBasic/ideia/core/getdata/$rawQueryToday');

        print('URL Payments Today: $urlPost');

        var response = await http.get(
          urlPost,
          headers: {
            'Accept': 'text/html',
          },
        );

        print(' StatusCode PaymentValues${response.statusCode}');

        if (response.statusCode == 200) {
          var jsonData = json.decode(response.body);

          if (jsonData.containsKey('data') && jsonData['data'] is Map) {
            // Busca a primeira chave dentro de 'data', pois ela é dinâmica
            var dynamicKey = jsonData['data'].keys.first;
            print('Chave dinâmica encontrada: $dynamicKey');

            // Verifica se o valor associado à chave é uma lista
            var dataList = jsonData['data'][dynamicKey];
            if (dataList != null && dataList is List) {
              payments =
                  dataList.map((e) => PaymentValues.fromJson(e)).toList();

              print('A chave dinâmica contém uma lista válida.');
            } else {
              print('A chave dinâmica não contém uma lista válida.');
            }
          } else {
            if (onProductAdded != null) {
              onProductAdded!();
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                padding: EdgeInsets.all(Style.SaveUrlMessagePadding(context)),
                content: Text(
                  'Não houveram vendas com este método de pagamento',
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
        print('Erro durante a requisição PaymentsValues: $e');
      }
      return payments;
    }
  }
}
