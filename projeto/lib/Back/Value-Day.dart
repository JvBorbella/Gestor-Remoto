import 'dart:convert';
import 'package:http/http.dart' as http;

class MonitorVendasValorHoje {
  late double vendadia;
  late double vendadiaanterior;
  late double vendasemana;
  late double vendames;
  late int solicitacoesremotas;

  MonitorVendasValorHoje({
    required this.vendadia,
    required this.solicitacoesremotas,
    required this.vendadiaanterior,
    required this.vendasemana,
    required this.vendames,
  });

  factory MonitorVendasValorHoje.fromJson(Map<String, dynamic> json) {
    return MonitorVendasValorHoje(
      vendadia: json['vendadia'],
      vendadiaanterior: json['vendadiaanteriror'],
      vendasemana: json['vendasemana'],
      vendames: json['vendames'],
      solicitacoesremotas: json['solicitacoesremotas'],
    );
  }
}

class DataServiceValorHoje {
  static Future<Map<String, double?>> fetchDataValorHoje(String token, String url) async {
    double? vendadia;
    double? vendadiaanterior;
    double? vendasemana;
    double? vendames;

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
          vendadiaanterior = double.parse(jsonData['vendadiaanterior'].toString());
          vendasemana = double.parse(jsonData['vendasemana'].toString());
          vendames = double.parse(jsonData['vendames'].toString());
        }else {}    
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
    }
    
    // Retorna um mapa contendo os valores
    return {
      'vendadia': vendadia,
      'vendadiaanterior': vendadiaanterior,
      'vendasemana': vendasemana,
      'vendames': vendames,
    };
  }

  static Future<int?> fetchDataRequisicoes(String token, String url) async {
    int? solicitacoesremotas;

    try {
      var urlRequisicoes = Uri.parse('$url/monitorvendas');
      // var urlRequisicoes = Uri.parse('$url/action/D96B6131-C72B-421B-8C6F-5CA094495AED');
      

      var responseRequisicoes = await http.post(
        urlRequisicoes,
        headers: {
          'auth-token': token,
        },
      );

      if (responseRequisicoes.statusCode == 200) {
        var jsonData = json.decode(responseRequisicoes.body);

        if (jsonData.containsKey('solicitacoesremotas')) {
          solicitacoesremotas =
              int.parse(jsonData['solicitacoesremotas'].toString());
        } else {}
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
    }
    return solicitacoesremotas;
  }
}
