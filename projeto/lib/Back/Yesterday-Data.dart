import 'dart:convert';
import 'package:http/http.dart' as http;

class MonitorVendasEmpresaOntem {
  late double valorOntem;
  late int ticketOntem;

  MonitorVendasEmpresaOntem({required this.valorOntem, required this.ticketOntem});

  factory MonitorVendasEmpresaOntem.fromJson(Map<String, dynamic> json) {
    return MonitorVendasEmpresaOntem(
      valorOntem: json['valortotal'],
      ticketOntem: json['ticket'],
    );
  }
}

class DataServiceOntem {
  static Future<List<MonitorVendasEmpresaOntem>?> fetchDataOntem(
      String token, String url) async {
    List<MonitorVendasEmpresaOntem>? empresasOntem;

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
          empresasOntem = (jsonData['data']['monitorvendasempresas'] as List)
              .map((e) => MonitorVendasEmpresaOntem.fromJson(e))
              .toList();
        } else {
          print('Dados ausentes no JSON.');
        }
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
    }
    return empresasOntem;
  }
}
