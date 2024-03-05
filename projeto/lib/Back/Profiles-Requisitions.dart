import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto/Front/components/Style.dart';

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
      // var urlUsuarios = Uri.parse('$url/action/D96B6131-C72B-421B-8C6F-5CA094495AED');

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

class AcceptRequisition {
  static Future<void> acceptrequisition(
    BuildContext context,
    String url,
    String token,
    String liberacaoremotaId
  ) async {

    try {
      var accept = Uri.parse('$url/confirmaction/$liberacaoremotaId');

      var responseAccept = await http.post(
        accept,
        headers: {
          'auth-token': token,
        },
      );

      if (responseAccept.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Solicitação aceita',
            style: TextStyle(
              fontSize: 13,
              color: Style.tertiaryColor,
            ),
          ),
          backgroundColor: Style.sucefullColor,
        ),
      );
      } else {
        print('Erro durante o post $e');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Não foi possível aceitar essa solicitação',
            style: TextStyle(
              fontSize: 13,
              color: Style.tertiaryColor,
            ),
          ),
          backgroundColor: Style.errorColor,
        ),
      );
      print('Erro durante a solicitação HTTP: $e');
    }
  }
}

class RejectRequisition {
  static Future<void> rejectrequisition(
    BuildContext context,
    String url,
    String token,
    String liberacaoremotaId,
  ) async {

    try {
      var reject = Uri.parse('$url/cancelaction/$liberacaoremotaId');

      var responseReject = await http.post(
        reject,
        headers: {
          'auth-token': token,
        },
      );

      if (responseReject.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Solicitação remota excluída',
            style: TextStyle(
              fontSize: 13,
              color: Style.tertiaryColor,
            ),
          ),
          backgroundColor: Style.warningColor,
        ),
      );
      } else {
        print('Erro durante o post $e');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Ocorreu um erro ao excluir essa solicitação',
            style: TextStyle(
              fontSize: 13,
              color: Style.tertiaryColor,
            ),
          ),
          backgroundColor: Style.errorColor,
        ),
      );
      print('Erro durante a solicitação HTTP: $e');
    }
  }
}

