import 'dart:convert';
import 'package:http/http.dart' as http;

class MonitorVendasEmpresaMes {
  double valorMes;

  MonitorVendasEmpresaMes(
      {required this.valorMes,});

  factory MonitorVendasEmpresaMes.fromJson(Map<String, dynamic> json) {
    return MonitorVendasEmpresaMes(
      valorMes: json['valortotal'],
    );
  }
}

class DataServiceMes {
  static Future<List<MonitorVendasEmpresaMes>?> fetchDataMes(
      String token, String url) async {
    List<MonitorVendasEmpresaMes>? empresasMes;

    try {
      var urlMes = Uri.parse('$url/monitorvendasempresas/mes');

      var responseMes = await http.post(
        urlMes,
        headers: {
          'auth-token': token,
        },
      );

      if (responseMes.statusCode == 200) {
        var jsonData = json.decode(responseMes.body);

        if (jsonData.containsKey('data') &&
            jsonData['data'].containsKey('monitorvendasempresas') &&
            jsonData['data']['monitorvendasempresas'].isNotEmpty) {
          empresasMes = (jsonData['data']['monitorvendasempresas'] as List)
              .map((e) => MonitorVendasEmpresaMes.fromJson(e))
              .toList();
        } else {
          print('Dados ausentes no JSON.');
        }
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
    }
    return empresasMes;
  }
}
