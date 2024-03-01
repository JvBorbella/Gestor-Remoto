import 'dart:convert';
import 'package:http/http.dart' as http;

class Usuarios {
  late String empresaNome;
  late String usuarioLogin;
  late String imagem;
  late String liberacaoremotaId;
  late String mensagem;

  Usuarios({
    required this.empresaNome,
    required this.usuarioLogin,
    required this.imagem,
    required this.liberacaoremotaId,
    required this.mensagem,
  });

  factory Usuarios.fromJson(Map<String, dynamic> json) {
    return Usuarios(
      empresaNome: json['empresa_nome'],
      usuarioLogin: json['usuario_login'],
      imagem: json['imagem'],
      liberacaoremotaId: json['liberacaoremota_id'],
      mensagem: json['mensagem'],
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

        if (jsonData.containsKey('data') &&
            jsonData['data'].containsKey('liberacaoremota') &&
            jsonData['data']['liberacaoremota'].isNotEmpty) {
          usuarios = (jsonData['data']['liberacaoremota'] as List)
              .map((e) => Usuarios.fromJson(e))
              .toList();
        } else {
          print('Dados ausentes no JSON.');
        }
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
    }
    return usuarios;
  }
}
