import 'dart:convert';
import 'package:http/http.dart' as http;

//Código onde serão acessados os dados de vendas do dia.

class CompanySalesMonitor {
  late String empresaNome;
  late double valortotal;
  late double ticket;
  late double cancelamentos;
  late double ticketmedio;
  late double margem;
  late double meta;
  late double valorcancelamentos;

  CompanySalesMonitor({
    required this.empresaNome,
    required this.valortotal,
    required this.ticket,
    required this.cancelamentos,
    required this.ticketmedio,
    required this.margem,
    required this.meta,
    required this.valorcancelamentos,
  });

  factory CompanySalesMonitor.fromJson(Map<String, dynamic> json) {
    return CompanySalesMonitor(
      empresaNome: json['empresa_nome'],
      valortotal: (json['valortotal'] ?? 0).toDouble(),
      ticket: (json['ticket'] ?? 0).toDouble(),
      cancelamentos: (json['cancelamentos'] ?? 0).toDouble(),
      ticketmedio: (json['ticket_medio'] ?? 0).toDouble(),
      margem: (json['margem'] ?? 0).toDouble(),
      meta: (json['meta'] ?? 0).toDouble(),
      valorcancelamentos: (json['valorcancelamentos'] ?? 0).toDouble(),
    );
  }
}

class DataServiceToday {
  static Future<List<CompanySalesMonitor>?> fetchDataToday(
      String token, String url, {bool? ascending}) async {
    List<CompanySalesMonitor>? empresasHoje;

    try {
      var urlPost = Uri.parse('$url/monitorvendasempresas/hoje');

      var response = await http.post(
        urlPost,
        headers: {
          'auth-token': token,
        },
      );
      print(urlPost);

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        if (jsonData.containsKey('data') &&
            jsonData['data'].containsKey('monitorvendasempresas') &&
            jsonData['data']['monitorvendasempresas'].isNotEmpty) {
          empresasHoje = (jsonData['data']['monitorvendasempresas'] as List)
              .map((e) => CompanySalesMonitor.fromJson(e))
              .toList();

          empresasHoje.sort((a, b) {
            if (ascending!) {
              return a.valortotal.compareTo(b.valortotal);
            } else {
              return b.valortotal.compareTo(a.valortotal);
            }
          });
        } else {
          print('Dados ausentes no JSON. TODAY');
        }
      }
    } catch (e) {
      print('Erro durante a requisição ValorHoje: $e');
    }
    return empresasHoje;
  }
}

class DataServiceYesterday {
  static Future<List<CompanySalesMonitor>?> fetchDataYesterday(
      String token, String url, {bool? ascending}) async {
    List<CompanySalesMonitor>? empresasOntem;

    try {
      var urlPost = Uri.parse('$url/monitorvendasempresas/ontem');

      var response = await http.post(
        urlPost,
        headers: {
          'auth-token': token,
        },
      );
      print(urlPost);

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        if (jsonData.containsKey('data') &&
            jsonData['data'].containsKey('monitorvendasempresas') &&
            jsonData['data']['monitorvendasempresas'].isNotEmpty) {
          empresasOntem = (jsonData['data']['monitorvendasempresas'] as List)
              .map((e) => CompanySalesMonitor.fromJson(e))
              .toList();

          empresasOntem.sort((a, b) {
            if (ascending!) {
              return a.valortotal.compareTo(b.valortotal);
            } else {
              return b.valortotal.compareTo(a.valortotal);
            }
          });
        } else {
          print('Dados ausentes no JSON. YESTERDAY');
        }
      }
    } catch (e) {
      print('Erro durante a requisição ValorOntem: $e');
    }
    return empresasOntem;
  }
}

class DataServiceWeek {
  static Future<List<CompanySalesMonitor>?> fetchDataWeek(
      String token, String url, {bool? ascending}) async {
    List<CompanySalesMonitor>? empresasSemana;

    try {
      var urlPost = Uri.parse('$url/monitorvendasempresas/semana');

      var response = await http.post(
        urlPost,
        headers: {
          'auth-token': token,
        },
      );
      print(urlPost);

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        if (jsonData.containsKey('data') &&
            jsonData['data'].containsKey('monitorvendasempresas') &&
            jsonData['data']['monitorvendasempresas'].isNotEmpty) {
          empresasSemana = (jsonData['data']['monitorvendasempresas'] as List)
              .map((e) => CompanySalesMonitor.fromJson(e))
              .toList();

          empresasSemana.sort((a, b) {
            if (ascending!) {
              return a.valortotal.compareTo(b.valortotal);
            } else {
              return b.valortotal.compareTo(a.valortotal);
            }
          });
        } else {
          print('Dados ausentes no JSON. WEEK');
        }
      }
    } catch (e) {
      print('Erro durante a requisição ValorSemana: $e');
    }
    return empresasSemana;
  }
}

class DataServiceMonth {
  static Future<List<CompanySalesMonitor>?> fetchDataMonth(
      String token, String url, {bool? ascending}) async {
    List<CompanySalesMonitor>? empresasMes;

    try {
      var urlPost = Uri.parse('$url/monitorvendasempresas/mes');

      var response = await http.post(
        urlPost,
        headers: {
          'auth-token': token,
        },
      );
      print(urlPost);

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        if (jsonData.containsKey('data') &&
            jsonData['data'].containsKey('monitorvendasempresas') &&
            jsonData['data']['monitorvendasempresas'].isNotEmpty) {
          empresasMes = (jsonData['data']['monitorvendasempresas'] as List)
              .map((e) => CompanySalesMonitor.fromJson(e))
              .toList();

          empresasMes.sort((a, b) {
            if (ascending!) {
              return a.valortotal.compareTo(b.valortotal);
            } else {
              return b.valortotal.compareTo(a.valortotal);
            }
          });
        } else {
          print('Dados ausentes no JSON. MONTH');
        }
      }
    } catch (e) {
      print('Erro durante a requisição ValorMes: $e');
    }
    return empresasMes;
  }
}

class DataServicePrevMonth {
  static Future<List<CompanySalesMonitor>?> fetchDataPrevMonth(
      String token, String url) async {
    List<CompanySalesMonitor>? empresasMesAnt;

    try {
      var urlPost = Uri.parse('$url/monitorvendasempresas/mesant');

      var response = await http.post(
        urlPost,
        headers: {
          'auth-token': token,
        },
      );
      print(urlPost);

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        if (jsonData.containsKey('data') &&
            jsonData['data'].containsKey('monitorvendasempresas') &&
            jsonData['data']['monitorvendasempresas'].isNotEmpty) {
          empresasMesAnt = (jsonData['data']['monitorvendasempresas'] as List)
              .map((e) => CompanySalesMonitor.fromJson(e))
              .toList();

          // Comparação com os dados do mês atual e ajuste da lista
          await _adjustListSize(empresasMesAnt, token, url);

        } else {
          print('Dados ausentes no JSON. PREV. MONTH');
        }
      }
    } catch (e) {
      print('Erro durante a requisição ValorMes: $e');
    }
    return empresasMesAnt;
  }

  static Future<void> _adjustListSize(List<CompanySalesMonitor>? prevMonthData, String token, String url) async {
    // Obtém os dados do mês atual
    var currentMonthData = await DataServiceMonth.fetchDataMonth(token, url);

    // Ajuste de tamanho
    if (prevMonthData != null && currentMonthData != null) {
      int difference = currentMonthData.length - prevMonthData.length;

      for (int i = 0; i < difference; i++) {
        prevMonthData.add(CompanySalesMonitor(
          empresaNome: 'N/A',
          valortotal: 0.0,
          ticket: 0.0,
          cancelamentos: 0.0,
          ticketmedio: 0.0,
          margem: 0.0,
          meta: 0.0,
          valorcancelamentos: 0.0,
        ));
      }
    }
  }
}

