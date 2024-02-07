import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MonitorVendasValorHoje {
  late double vendadia;

  MonitorVendasValorHoje({required this.vendadia});

  factory MonitorVendasValorHoje.fromJson(Map<String, dynamic> json) {
    return MonitorVendasValorHoje(
      vendadia: json['vendadia'],
    );
  }
}

class DataServiceValorHoje {
  static Future<double?> fetchDataValorHoje(String token, String url) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    double? vendadia;

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
        } else {
          print('Campo vendadia ausente no JSON.');
        }

        print('Response body: ${responseValorHoje.body}');
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
    }
    return vendadia;
  }
}


