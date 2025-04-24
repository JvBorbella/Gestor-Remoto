import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/front/components/style.dart';
//Código onde são acessados os dados das soicitações remotas.

class CreditConsult {
  //Definindo o tipo das variáveis que serão acessadas.
  late double valor;

  CreditConsult({
    required this.valor,
  });

  factory CreditConsult.fromJson(Map<String, dynamic> json) {
    return CreditConsult(
      //Atribuindo os dados do json a essas variáveis.
      valor: (json['valor'] ?? 0).toDouble(),
    );
  }
}

//Classe responsável por acessar o json e resgatar os campos.
class DataServiceCreditConsult {
  static Future<Map<String, double?>> fetchDataCreditConsult(
      BuildContext context,
      String token,
      String urlBasic,
      String empresa_id,
      String cpf) async {
    //Nesse caso, os dados não serão em lista, pois não haverá mais de um dado para um campo, logo, tive que definir cada campo separadamente.\
    double? valor;

    try {
      //Definindo a url da requisição.
      var urlPost = Uri.parse(
          '$urlBasic/ideia/core/getcreditopessoa/D4A8E2D0-35B4-49D9-8CDF-E8691E11C070/10511297700');

      //Variável que irá receber a resposta da requisição.
      var response = await http.get(
        urlPost,
        headers: {
          'Accept':
              'text/html', //Passando o token na header para a requisição ser aceita.
        },
      );
      print(urlPost);

      if (response.statusCode == 200) {
        //Caso a conexão seja aceita, a variável jsonData acessará o json e resgatará os dados.
        var jsonData = json.decode(response.body);

        if (jsonData.containsKey('data') &&
            jsonData['data'].containsKey('credito')) {
          //Caso o campo seja encontrado dentro do json, os dados serão atribuidos a essas variáveis.
          valor = jsonData['valor'];
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              padding: EdgeInsets.all(Style.SaveUrlMessagePadding(context)),
              content: Text(
                '${valor ?? 'Não há créditos para este cliente'}',
                style: TextStyle(
                  fontSize: Style.SaveUrlMessageSize(context),
                  color: Style.tertiaryColor,
                ),
              ),
              backgroundColor: Style.sucefullColor,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              padding: EdgeInsets.all(Style.SaveUrlMessagePadding(context)),
              content: Text(
                'Não foram encontrados créditos para este cliente',
                style: TextStyle(
                  fontSize: Style.SaveUrlMessageSize(context),
                  color: Style.tertiaryColor,
                ),
              ),
              backgroundColor: Style.errorColor,
            ),
          );
        }
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
    }

    // Retorna um mapa contendo os valores
    return {
      'valor': valor,
    };
  }
}
