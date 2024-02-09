import 'dart:convert';
import 'package:http/http.dart' as http;

class MonitorVendasEmpresaSemana {
  late double valorSemana;

  MonitorVendasEmpresaSemana(
      {required this.valorSemana,});

  factory MonitorVendasEmpresaSemana.fromJson(Map<String, dynamic> json) {
    return MonitorVendasEmpresaSemana(
      valorSemana: json['valortotal'],
    );
  }
}

class DataServiceSemana {
  static Future<List<MonitorVendasEmpresaSemana>?> fetchDataSemana(
      String token, String url) async {
    List<MonitorVendasEmpresaSemana>? empresasSemana;

    try {
      var urlSemana = Uri.parse('$url/monitorvendasempresas/semana');

      var responseSemana = await http.post(
        urlSemana,
        headers: {
          'auth-token': token,
        },
      );

      if (responseSemana.statusCode == 200) {
        var jsonData = json.decode(responseSemana.body);

        if (jsonData.containsKey('data') &&
            jsonData['data'].containsKey('monitorvendasempresas') &&
            jsonData['data']['monitorvendasempresas'].isNotEmpty) {
          empresasSemana = (jsonData['data']['monitorvendasempresas'] as List)
              .map((e) => MonitorVendasEmpresaSemana.fromJson(e))
              .toList();
        } else {
          print('Dados ausentes no JSON.');
        }
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
    }
    return empresasSemana;
  }
}
