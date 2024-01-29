import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static Future<String> fetchData(String url) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var empresa = jsonDecode(response.body)['data']['empresa_codigo'];
        return response.body;
      } else {
        throw Exception('Erro na requisição: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro: $e');
    }
  }
}
