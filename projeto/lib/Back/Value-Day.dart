import 'dart:convert';
import 'package:http/http.dart' as http;

class MonitorVendasValorHoje {
  late double vendadia;
  late int solicitacoesremotas;

  MonitorVendasValorHoje({required this.vendadia, required this.solicitacoesremotas});

  factory MonitorVendasValorHoje.fromJson(Map<String, dynamic> json) {
    return MonitorVendasValorHoje(
      vendadia: json['vendadia'],
      solicitacoesremotas: json['solicitacoesremotas'],
    );
  }
}

class DataServiceValorHoje {
  static Future<double?> fetchDataValorHoje(String token, String url) async {
    double? vendadia;
    int? solicitacoesremotas;

    try {
      var urlValorHoje = Uri.parse('$url/monitorvendas');

      var responseValorHoje = await http.post(
        urlValorHoje,
        headers: {
          'auth-token': token,
        },
      );

      if (responseValorHoje.statusCode == 200) {
        var jsonData = json.decode(responseValorHoje.body);

        if (jsonData.containsKey('vendadia')) {
          vendadia = double.parse(jsonData['vendadia'].toString());
          solicitacoesremotas = int.parse(jsonData['solicitacoesremotas'].toString());
          print(solicitacoesremotas);
        } else {
        }
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
    }
    return vendadia;
  }

   static Future<int?> fetchDataRequisicoes(String token, String url) async {
    int? solicitacoesremotas;

    try {
      var urlRequisicoes = Uri.parse('$url/monitorvendas');

      var responseRequisicoes = await http.post(
        urlRequisicoes,
        headers: {
          'auth-token': token,
        },
      );

      if (responseRequisicoes.statusCode == 200) {
        var jsonData = json.decode(responseRequisicoes.body);

        if (jsonData.containsKey('solicitacoesremotas')) {
          solicitacoesremotas = int.parse(jsonData['solicitacoesremotas'].toString());
          print(solicitacoesremotas);
        } else {
        }
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
    }
    return solicitacoesremotas;
  }
}


