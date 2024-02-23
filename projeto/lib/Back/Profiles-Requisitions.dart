import 'dart:convert';
import 'package:http/http.dart' as http;

class Usuarios {
  late double valorOntem;
  late int ticketOntem;

  Usuarios({required this.valorOntem, required this.ticketOntem});

  factory Usuarios.fromJson(Map<String, dynamic> json) {
    return Usuarios(
      valorOntem: json['valortotal'],
      ticketOntem: json['ticket'],
    );
  }
}

class DataServiceUsuarios {
  static Future<List<Usuarios>?> fetchDataUsuarios(
      String token, String url) async {
    List<Usuarios>? usuarios;

    try {
      var urlUsuarios = Uri.parse('$url/actions');

      var responseUsuario = await http.post(
        urlUsuarios,
        headers: {
          'auth-token': token,
        },
      );

      if (responseUsuario.statusCode == 200) {
        var jsonData = json.decode(responseUsuario.body);

        // if (jsonData.containsKey('data') &&
        //     jsonData['data'].containsKey('monitorvendasempresas') &&
        //     jsonData['data']['monitorvendasempresas'].isNotEmpty) {
        //   usuarios = (jsonData['data']['monitorvendasempresas'] as List)
        //       .map((e) => usuarios.fromJson(e))
        //       .toList();
        // } else {
        //   print('Dados ausentes no JSON.');
        // }
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
    }
    return usuarios;
  }
}
