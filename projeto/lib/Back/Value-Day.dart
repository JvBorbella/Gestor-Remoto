import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
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
}


