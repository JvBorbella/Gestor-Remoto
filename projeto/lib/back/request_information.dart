import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projeto/Front/components/Style.dart';

//Código onde são acessados os dados das soicitações remotas.

class RequestInformation {
  //Definindo o tipo das variáveis que estão recebendo os dados
  late String empresaNome;
  late String usuarioLogin;
  late String imagem;
  late String liberacaoremotaId;
  late String mensagem;
  late String mensagemResposta;

  RequestInformation({
    required this.empresaNome,
    required this.usuarioLogin,
    required this.imagem,
    required this.liberacaoremotaId,
    required this.mensagem,
    required this.mensagemResposta,
  });

  //Método para acessar os campos presentes no json e atrivuí-los a cada variável dentro da class Usuarios.
  factory RequestInformation.fromJson(Map<String, dynamic> json) {
    return RequestInformation(
      //Atribuindo os campos do json às variáveis.
      empresaNome: json['empresa_nome'],
      usuarioLogin: json['usuario_login'],
      imagem: json['imagem'],
      liberacaoremotaId: json['liberacaoremota_id'],
      mensagem: json['mensagem'],
      mensagemResposta: json['mensagemresposta'],
    );
  }
}

//Classe onde será acessado o json
class DataService {
  //Função feita em lista para retornarem todos os registros para cada campo presente no json.
  static Future<List<RequestInformation>?> fetchData(
      String token, String url) async {
    List<RequestInformation>? requests;

    //Realizando a tentativa post para obter o json com os dados
    try {
      var urlPost =
          Uri.parse('$url/actions'); //Definindo a url que fará a requisição.

      //Variável que vai receber a resposta do servidor.
      var response = await http.post(
        urlPost, //Passando a url para a requisição.
        headers: {
          //Passando o token na header.
          'auth-token': token,
        },
      );

      if (response.statusCode == 200) {
        //Caso a conexão seja bem-sucedida, a variável jsonData acessará o json fornecido pelo servidor.
        var jsonData = json.decode(response.body);

        //Fazendo a verificação do caminho dentro do json para encontrar os campos.
        if (jsonData.containsKey('data') &&
            jsonData['data'].containsKey('liberacaoremota') &&
            jsonData['data']['liberacaoremota'].isNotEmpty) {
          //Atribuindo a lista com os dados para 'usuarios'.
          requests = (jsonData['data']['liberacaoremota'] as List)
              .map((e) => RequestInformation.fromJson(e))
              .toList();
        } else {
          //Caso não sejam encontrados os campos no json, será exibido essa mensagem no console.
          print('Dados ausentes no JSON.');
        }
      }
    } catch (e) {
      //Caso a tentativa de requisição não seja bem-sucedida, será exibido o tipo do erro no console.
      print('Erro durante a requisição: $e');
    }
    return requests;
  }
}

//Classe com a função para aceitar a solicitação.
class AcceptRequest {
  static Future<void> acceptrequest(
    BuildContext context,
    //Recebendo dados que serão necessários para realizar a função.
    String url,
    String token,
    String liberacaoremotaId,
    String _textController,
  ) async {
    //Tentativa de requisição post para efetuar a liberação.
    try {
      //Definindo a url que fará a requisição post, sendo atribuida a ela o id da solicitação que está sendo autorizada.
      var urlPost = Uri.parse('$url/confirmaction/$liberacaoremotaId');
      var mensagemresposta = jsonEncode(_textController);
      print('texto digitado: $mensagemresposta');

      var response = await http.post(
        //Variável que irá receber a resposta da requisição.
        urlPost,
        headers: {
          //Passando o token na header da requisição post.
          'auth-token': token,
        },
        body: mensagemresposta,
      );

      //Caso a requisição seja aceita, será exibida a seguinte mensagem.
      if (response.statusCode == 200) {
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
        //Caso não seja, será exibido o erro no console.
        print('Erro durante o post $e');
      }
    } catch (e) {
      //Se a tentativa de liberação não dê certo, será exibida essa mensagem.
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

//Classe com a função para excluir uma solicitação.
class RejectRequest {
  static Future<void> rejectrequest(
    BuildContext context,
    //Recebendo dados que serão necessários para realizar a função.
    String url,
    String token,
    String liberacaoremotaId,
    String _textController,
  ) async {
    //Tentativa de requisição post para efetuar a exclusão da solicitação.
    try {
      //Definindo a url que fará a requisição post, sendo atribuida a ela o id da solicitação que está sendo excluída.
      var urlPost = Uri.parse('$url/cancelaction/$liberacaoremotaId');
      var mensagemresposta = _textController;
      print('texto digitado: $mensagemresposta');

      var response = await http.post(
        //Variável que irá receber a resposta da requisição.
        urlPost,
        headers: {
          //Passando o token na header da requisição post.
          'auth-token': token,
        },
        body: mensagemresposta, // Envia a mensagem de resposta para o servidor
      );

      //Caso a requisição post seja aceita, será exibida a seguinte mensagem.
      if (response.statusCode == 200) {
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
        //Caso não seja, será exibido o erro no console.
        print('Erro durante o post $e');
      }
    } catch (e) {
      //Se a tentativa de exclusão não dê certo, será exibida essa mensagem.
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
