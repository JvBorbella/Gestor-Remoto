import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MonitorVendasEmpresaHoje {
  late String empresaNome;
  late double valorHoje;
  late double valorOntem;

  MonitorVendasEmpresaHoje(
      {required this.empresaNome,
      required this.valorHoje,
      required this.valorOntem});

  factory MonitorVendasEmpresaHoje.fromJson(Map<String, dynamic> json) {
    return MonitorVendasEmpresaHoje(
      empresaNome: json['empresa_nome'],
      valorHoje: json['valortotal'],
      valorOntem: json['valortotal'],
    );
  }
}

class DataService {
  static Future<List<MonitorVendasEmpresaHoje>?> fetchData(
      String token, String url) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<MonitorVendasEmpresaHoje>? empresasHoje, empresasOntem;

    try {
      var urlHoje = Uri.parse('$url/monitorvendasempresas/hoje');
      var urlOntem = Uri.parse('$url/monitorvendasempresas/ontem');

      var responseHoje = await http.post(
        urlHoje,
        headers: {
          'auth-token': token,
        },
      );

      var responseOntem = await http.post(
        urlOntem,
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
        }
        else if (responseOntem.statusCode == 200) {
          var jsonData = json.decode(responseOntem.body);

          if (jsonData.containsKey('data') &&
              jsonData['data'].containsKey('monitorvendasempresas') &&
              jsonData['data']['monitorvendasempresas'].isNotEmpty) {
            empresasOntem = (jsonData['data']['monitorvendasempresas'] as List)
                .map((e) => MonitorVendasEmpresaHoje.fromJson(e))
                .toList();
          } else {
            print('Dados ausentes no JSON.');
          }
        }
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
    }

    return empresasHoje;
  }
}
