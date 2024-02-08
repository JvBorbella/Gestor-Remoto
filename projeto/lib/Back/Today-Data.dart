import 'dart:convert';
import 'package:http/http.dart' as http;

class MonitorVendasEmpresaHoje {
  late String empresaNome;
  late double valorHoje;

  MonitorVendasEmpresaHoje(
      {required this.empresaNome,
      required this.valorHoje});

  factory MonitorVendasEmpresaHoje.fromJson(Map<String, dynamic> json) {
    return MonitorVendasEmpresaHoje(
      empresaNome: json['empresa_nome'],
      valorHoje: json['valortotal'],
    );
  }
}

class DataService {
  static Future<List<MonitorVendasEmpresaHoje>?> fetchData(
      String token, String url) async {
    List<MonitorVendasEmpresaHoje>? empresasHoje;

    try {
      var urlHoje = Uri.parse('$url/monitorvendasempresas/hoje');

      var responseHoje = await http.post(
        urlHoje,
        headers: {
          'auth-token': token,
        },
      );

      if (responseHoje.statusCode == 200) {
        var jsonData = json.decode(responseHoje.body);

        if (jsonData.containsKey('data') &&
            jsonData['data'].containsKey('monitorvendasempresas') &&
            jsonData['data']['monitorvendasempresas'].isNotEmpty) {
          empresasHoje = (jsonData['data']['monitorvendasempresas'] as List)
              .map((e) => MonitorVendasEmpresaHoje.fromJson(e))
              .toList();
        } else {
            print('Dados ausentes no JSON.');
          }
        }
      }
     catch (e) {
      print('Erro durante a requisição: $e');
    }
    return empresasHoje;
  }
}