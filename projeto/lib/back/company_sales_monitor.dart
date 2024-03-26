import 'dart:convert';
import 'package:http/http.dart' as http;

//Código onde serão acessados os dados de vendas do dia.

class MonitorVendasEmpresa {
  //Definindo o tipo das variáveis que estão recebendo os dados
  late String empresaNome;
  // late String title;
  late double valortotal;
  late double ticket;
  late double cancelamentos;
  late double ticketmedio;
  late double margem;
  late double meta;
  late double valorcancelamentos;

  MonitorVendasEmpresa({
    required this.empresaNome,
    // required this.title,
    required this.valortotal,
    required this.ticket,
    required this.cancelamentos,
    required this.ticketmedio,
    required this.margem,
    required this.meta,
    required this.valorcancelamentos,
  });

  //Método para acessar os campos presentes no json e atrivuí-los a cada variável dentro da class MonitorVendasEmpresaHoje.
  factory MonitorVendasEmpresa.fromJson(Map<String, dynamic> json) {
    return MonitorVendasEmpresa(
      empresaNome: json['empresa_nome'],
      // title: json['title'],
      valortotal: (json['valortotal'] ?? 0).toDouble(), // Conversão para double
      ticket: (json['ticket'] ?? 0).toDouble(), // Conversão para double
      cancelamentos: (json['cancelamentos'] ?? 0).toDouble(), // Conversão para double
      ticketmedio: (json['ticket_medio'] ?? 0).toDouble(), // Conversão para double
      margem: (json['margem'] ?? 0).toDouble(), // Conversão para double
      meta: (json['meta'] ?? 0).toDouble(), // Conversão para double
      valorcancelamentos: (json['valorcancelamentos'] ?? 0).toDouble(), // Conversão para double
    );
  }
}

//Classe onde será feita a requisição e acessado o json para serem resgatados os dados a serem utilizados.
class DataServiceHoje {
  static Future<List<MonitorVendasEmpresa>?> fetchData(
      String token, String url) async {
    List<MonitorVendasEmpresa>?
        empresasHoje; //Dados serão retornados em lista, para retornarem todos os dados de cada campo.

    try {
      //Definindo a url que fará a requisição post.
      var urlPost = Uri.parse('$url/monitorvendasempresas/hoje');

      var response = await http.post(
        //Variável que irá receber a resposta da requisição.
        urlPost,
        headers: {
          //Passando o token na header para que seja aceita a requisição.
          'auth-token': token,
        },
      );

      if (response.statusCode == 200) {
        //Se a conexão for aceita, o json será acessado e resgatados os dados.
        var jsonData = json.decode(response.body);

        //Terá que ser informado o caminho do campo dentro do json para que seja encontrado.
        if (jsonData.containsKey('data') &&
            jsonData['data'].containsKey('monitorvendasempresas') &&
            jsonData['data']['monitorvendasempresas'].isNotEmpty) {
          empresasHoje = (jsonData['data']['monitorvendasempresas']
                  as List) //Os dados serão passados em lista para empresasHoje.
              .map((e) => MonitorVendasEmpresa.fromJson(e))
              .toList();
        } else {
          //Caso não sejam encontrados os campos no caminho fornecido, será exibida a mensagem no console:
          print('Dados ausentes no JSON.');
        }
      }
    } catch (e) {
      //Caso a tentativa de requisição não seja bem-sucedida, será exibido o erro no console.
      print('Erro durante a requisição ValorHoje: $e');
    }
    return empresasHoje;
  }
}

//Classe onde será acessado o json e resgatados os dados.
class DataServiceOntem {
  static Future<List<MonitorVendasEmpresa>?> fetchDataOntem(
      String token, String url) async {
    List<MonitorVendasEmpresa>?
        empresasOntem; //Os dados serão passados como lista para essa instância.

    try {
      //Url que fará a requisição.
      var urlPost = Uri.parse('$url/monitorvendasempresas/ontem');

      //Variável que receberá a resposta da requisição post.
      var response = await http.post(
        urlPost,
        headers: {
          'auth-token': token, //Passando o token na header da requisição.
        },
      );

//Caso retorne status 200, a variável jsonData acessará o json e atribuirá os dados à empresasOntem caso sejam encontrados pelo caminho fornecido.
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        if (jsonData.containsKey('data') &&
            jsonData['data'].containsKey('monitorvendasempresas') &&
            jsonData['data']['monitorvendasempresas'].isNotEmpty) {
          empresasOntem = (jsonData['data']['monitorvendasempresas'] as List)
              .map((e) => MonitorVendasEmpresa.fromJson(e))
              .toList();
        } else {
          print('Dados ausentes no JSON.');
        }
      }
    } catch (e) {
      print('Erro durante a requisição ValorOntem: $e');
    }
    return empresasOntem;
  }
}

//Classe onde será acessado o json e resgatados os dados.
class DataServiceSemana {
  static Future<List<MonitorVendasEmpresa>?> fetchDataSemana(
      String token, String url) async {
    //Os dados serão retornados em lista, pois podem haver mais de um dado para os campo.
    List<MonitorVendasEmpresa>? empresasSemana;

    try {
      //Url que fará a requisição.
      var urlPost = Uri.parse('$url/monitorvendasempresas/semana');

      //Variável que irá receber a receber a resposta da requisição.
      var response = await http.post(
        urlPost,
        headers: {
          'auth-token':
              token, //Passando o token na header para a requisição ser aceita.
        },
      );

      //Caso a resposta seja 200, a variável jsonData acessará o json e buscará os dados através do caminho informado.
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        if (jsonData.containsKey('data') &&
            jsonData['data'].containsKey('monitorvendasempresas') &&
            jsonData['data']['monitorvendasempresas'].isNotEmpty) {
          empresasSemana = (jsonData['data']['monitorvendasempresas'] as List)
              .map((e) => MonitorVendasEmpresa.fromJson(e))
              .toList(); // Caso sejam encontrados, serão passados como uma lista para a instância empresasSemana.
          //Caso não sejam encontrados, exibirá essa mensagem no console.
        } else {
          print('Dados ausentes no JSON.');
        }
      }
      //Se a tentativa de requisição não for aceita, o erro será exibido no console.
    } catch (e) {
      print('Erro durante a requisição ValorSemana: $e');
    }
    return empresasSemana;
  }
}

//Classe com a função para resgatar os dados no json.
class DataServiceMes {
  static Future<List<MonitorVendasEmpresa>?> fetchDataMes(
      String token, String url) async {
    //Estes dados serão retornados em listas, pois podem haver mais de um dado para um campo.
    List<MonitorVendasEmpresa>? empresasMes;

    try {
      //Url para a requisição.
      var urlPost = Uri.parse('$url/monitorvendasempresas/mes');

      var response = await http.post(
        urlPost,
        headers: {
          'auth-token':
              token, //Passando o token na header para a requisição ser aceita.
        },
      );

      //Caso seja aceita, a variável jsonData acessará o json fornecido pela requisição e encontrará os campos através do caminho informado.
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        if (jsonData.containsKey('data') &&
            jsonData['data'].containsKey('monitorvendasempresas') &&
            jsonData['data']['monitorvendasempresas'].isNotEmpty) {
          empresasMes = (jsonData['data']['monitorvendasempresas'] as List)
              .map((e) => MonitorVendasEmpresa.fromJson(e))
              .toList();
          //Caso não sejam encontrados dados neste caminho, a seguinte mensagem será exibida no console.
        } else {
          print('Dados ausentes no JSON.');
        }
      }
      //Caso ocorra algum erro na requisição post, o mesmo será exibido no console.
    } catch (e) {
      print('Erro durante a requisição ValorMes: $e');
    }
    return empresasMes;
  }
}

//Classe com a função para resgatar os dados no json.
class DataServiceMesAnt {
  static Future<List<MonitorVendasEmpresa>?> fetchDataMesAnt(
      String token, String url) async {
    //Estes dados serão retornados em listas, pois podem haver mais de um dado para um campo.
    List<MonitorVendasEmpresa>? empresasMesAnt;

    try {
      //Url para a requisição.
      var urlPost = Uri.parse('$url/monitorvendasempresas/mesant');

      var response = await http.post(
        urlPost,
        headers: {
          'auth-token':
              token, //Passando o token na header para a requisição ser aceita.
        },
      );

      //Caso seja aceita, a variável jsonData acessará o json fornecido pela requisição e encontrará os campos através do caminho informado.
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        if (jsonData.containsKey('data') &&
            jsonData['data'].containsKey('monitorvendasempresas') &&
            jsonData['data']['monitorvendasempresas'].isNotEmpty) {
          empresasMesAnt = (jsonData['data']['monitorvendasempresas'] as List)
              .map((e) => MonitorVendasEmpresa.fromJson(e))
              .toList();
          //Caso não sejam encontrados dados neste caminho, a seguinte mensagem será exibida no console.
        } else {
          print('Dados ausentes no JSON.');
        }
      }
      //Caso ocorra algum erro na requisição post, o mesmo será exibido no console.
    } catch (e) {
      print('Erro durante a requisição ValorMes: $e');
    }
    return empresasMesAnt;
  }
}
