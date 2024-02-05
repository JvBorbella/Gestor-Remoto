import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DataService {
  static Future<String?> fetchData(String token, String url) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      var UrlHoje = Uri.parse('$url/monitorvendasempresas/hoje?');

      var responseHoje = await http.post(
        UrlHoje,
        headers: {
          'auth-token': token,
        },
      );

      if (responseHoje.statusCode == 200) {
        var jsonData = json.decode(responseHoje.body);

        if (jsonData.containsKey('data') &&
            jsonData['data'].containsKey('monitorvendasempresas') &&
            jsonData['data']['monitorvendasempresas'].isNotEmpty) {
          return jsonData['data']['monitorvendasempresas'][0]['empresa_nome'];
        } else {
          print('Dados ausentes no JSON.');
        }

        print('Response body: ${responseHoje.body}');
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
    }

    try {
      var UrlOntem = Uri.parse('$url/monitorvendasempresas/ontem?');

      var responseOntem = await http.post(
        UrlOntem,
        headers: {
          'auth-token': token,
        },
      );

      if (responseOntem.statusCode == 200) {
        var jsonData = json.decode(responseOntem.body);

        if (jsonData.containsKey('data') &&
            jsonData['data'].containsKey('monitorvendasempresas') &&
            jsonData['data']['monitorvendasempresas'].isNotEmpty) {
          return jsonData['data']['monitorvendasempresas'][0]['empresa_nome'];
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
