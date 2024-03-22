import 'dart:convert';
import 'package:http/http.dart' as http;

//Código da função que retornará os valores totais de vendas e as quantidades de pedidos de liberação remota.

class MonitorVendas {
  //Definindo o tipo das variáveis que serão acessadas.
  late double vendadia;
  late double vendadiaanterior;
  late double vendasemana;
  late double vendames;
  late int solicitacoesremotas;

  MonitorVendas({
    required this.vendadia,
    required this.solicitacoesremotas,
    required this.vendadiaanterior,
    required this.vendasemana,
    required this.vendames,
  });

  factory MonitorVendas.fromJson(Map<String, dynamic> json) {
    return MonitorVendas(
      //Atribuindo os dados do json a essas variáveis.
      vendadia: json['vendadia'],
      vendadiaanterior: json['vendadiaanteriror'],
      vendasemana: json['vendasemana'],
      vendames: json['vendames'],
      solicitacoesremotas: json['solicitacoesremotas'],
    );
  }
}

//Classe responsável por acessar o json e resgatar os campos.
class DataServiceMonitorVendas {
  static Future<Map<String, double?>> fetchDataMonitorVendas(
      String token, String url) async {
    //Nesse caso, os dados não serão em lista, pois não haverá mais de um dado para um campo, logo, tive que definir cada campo separadamente.\
    double? vendadia;
    double? vendadiaanterior;
    double? vendasemana;
    double? vendames;

    try {
      //Definindo a url da requisição.
      var urlPost = Uri.parse('$url/monitorvendas');

      //Variável que irá receber a resposta da requisição.
      var response = await http.post(
        urlPost,
        headers: {
          'auth-token': token, //Passando o token na header para a requisição ser aceita.
        },
      );

      if (response.statusCode == 200) { //Caso a conexão seja aceita, a variável jsonData acessará o json e resgatará os dados.
        var jsonData = json.decode(response.body);

        if (jsonData.containsKey('vendadia')) { //Caso o campo seja encontrado dentro do json, os dados serão atribuidos a essas variáveis.
          vendadia = double.parse(jsonData['vendadia'].toString());
          vendadiaanterior =
              double.parse(jsonData['vendadiaanterior'].toString());
          vendasemana = double.parse(jsonData['vendasemana'].toString());
          vendames = double.parse(jsonData['vendames'].toString());
        } else {}
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
    }

    // Retorna um mapa contendo os valores
    return {
      'vendadia': vendadia,
      'vendadiaanterior': vendadiaanterior,
      'vendasemana': vendasemana,
      'vendames': vendames,
    };
  }

  //Função para retornar apenas a quantidade de solicitações remotas.
  static Future<int?> fetchDataRequests(String token, String url) async {
    int? solicitacoesremotas;

    try {
      var urlPost = Uri.parse('$url/monitorvendas');

      var response = await http.post(
        urlPost,
        headers: {
          'auth-token': token,
        },
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        if (jsonData.containsKey('solicitacoesremotas')) {
          solicitacoesremotas =
              int.parse(jsonData['solicitacoesremotas'].toString());
        } else {}
      }
    } catch (e) {
      print('Erro durante a requisição: $e');
    }
    return solicitacoesremotas;
  }
}
