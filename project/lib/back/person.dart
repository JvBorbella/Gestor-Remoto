import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:project/front/components/style.dart';
//Código onde são acessados os dados das soicitações remotas.

class Person {
  //Definindo o tipo das variáveis que serão acessadas.
  late String nome;

  Person({
    required this.nome,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      //Atribuindo os dados do json a essas variáveis.
      nome: (json['nome'] ?? '').toString(),
    );
  }
}

//Classe responsável por acessar o json e resgatar os campos.
class DataServicePerson {
  static Future<Map<String, String?>> fetchDataPerson(
    String token,
    String urlBasic,
    String pessoaid,
  ) async {
    //Nesse caso, os dados não serão em lista, pois não haverá mais de um dado para um campo, logo, tive que definir cada campo separadamente.\
    String? nome;

    try {
      //Definindo a url da requisição.
      var urlPost = Uri.parse('$urlBasic/ideia/core/pessoa/$pessoaid');

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
            jsonData['data'].containsKey('pessoa')) {
          //Caso o campo seja encontrado dentro do json, os dados serão atribuidos a essas variáveis.
          nome = jsonData['nome'] ?? '';
        } else {
          print('Dados do cliente não encontrados');
        }
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
    }

    // Retorna um mapa contendo os valores
    return {
      'nome': nome ?? '',
    };
  }
}
