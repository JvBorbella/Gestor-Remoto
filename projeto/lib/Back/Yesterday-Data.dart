import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MonitorVendasEmpresaOntem {
  late double valorOntem;

  MonitorVendasEmpresaOntem({required this.valorOntem});

  factory MonitorVendasEmpresaOntem.fromJson(Map<String, dynamic> json) {
    return MonitorVendasEmpresaOntem(
      valorOntem: json['valortotal'],
    );
  }
}

class DataServiceOntem {
  static Future<MonitorVendasEmpresaOntem?> fetchDataOntem(String token, String url) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      var urlOntem = Uri.parse('$url/monitorvendasempresas/ontem');

      var responseOntem = await http.post(
        urlOntem,
        headers: {
          'auth-token': token,
        },
      );

      if (responseOntem.statusCode == 200) {
        var jsonData = json.decode(responseOntem.body);

        if (jsonData.containsKey('data') &&
            jsonData['data'].containsKey('monitorvendasempresas') &&
            jsonData['data']['monitorvendasempresas'].isNotEmpty) {
          // Criando uma instância da classe MonitorVendasEmpresa com base nos dados JSON
          return MonitorVendasEmpresaOntem.fromJson(
              jsonData['data']['monitorvendasempresas'][0]);
        } else {
          print('Dados ausentes no JSON.');
        }

        print('Response body: ${responseOntem.body}');
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
    }
    return null;
  }
}

