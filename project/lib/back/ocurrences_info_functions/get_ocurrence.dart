import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/Front/components/style.dart';

//Código onde serão acessados os dados de vendas do dia.

class GetOcurrence {
  int? flagfinalizada;
  String? obs;
  String? codigo;
  String? nome;
  String? identificador;
  String? numero;
  DateTime? datafinalizada;
  DateTime? dataprocessada;
  int? flagprocessada;
  int? flagexcluido;
  DateTime? datahoracancelamento;
  int? flagcancelado;
  DateTime? dataentrega;
  String? justificativacancelamento;
  DateTime datacadastro;
  int? flagfinalidade;
  int? flagdivergencia;
  String? ocorrenciaprodutoid;
  String? pessoaid;

  GetOcurrence({
    required this.flagfinalizada,
    required this.obs,
    required this.codigo,
    required this.nome,
    required this.identificador,
    required this.numero,
    required this.datafinalizada,
    required this.dataprocessada,
    required this.flagprocessada,
    required this.flagexcluido,
    required this.datahoracancelamento,
    required this.flagcancelado,
    required this.dataentrega,
    required this.justificativacancelamento,
    required this.datacadastro,
    required this.flagfinalidade,
    required this.flagdivergencia,
    required this.ocorrenciaprodutoid,
    required this.pessoaid,
  });

  factory GetOcurrence.fromJson(Map<String, dynamic> json) {
    return GetOcurrence(
      flagfinalizada: (json['flagfinalizada'] ?? 0).toInt(),
      obs: (json['obs'] ?? '').toString(),
      codigo: (json['codigo'] ?? '').toString(),
      nome: (json['nome'] ?? '').toString(),
      identificador: (json['identificador'] ?? '').toString(),
      numero: (json['numero'] ?? '').toString(),
      datafinalizada: json['datafinalizada'] != null
          ? DateTime.parse(json['datafinalizada'])
          : null,
      dataprocessada: json['dataprocessada'] != null
          ? DateTime.parse(json['dataprocessada'])
          : null,
      flagprocessada: (json['flagprocessada'] ?? 0).toInt(),
      flagexcluido: (json['flagexcluido'] ?? 0).toInt(),
      datahoracancelamento: json['datahoracancelamento'] != null
          ? DateTime.parse(json['datahoracancelamento'])
          : null,
      flagcancelado: (json['flagcancelado'] ?? 0).toInt(),
      dataentrega: json['dataentrega'] != null
          ? DateTime.parse(json['dataentrega'])
          : null,
      justificativacancelamento:
          (json['justificativacancelamento'] ?? '').toString(),
      datacadastro: DateTime.parse(json['datacadastro']),
      flagfinalidade: (json['flagfinalidade'] ?? 0).toInt(),
      flagdivergencia: (json['flagdivergencia'] ?? 0).toInt(),
      ocorrenciaprodutoid: (json['ocorrenciaproduto_id'] ?? '').toString(),
      pessoaid: (json['pessoa_id'] ?? '').toString(),
    );
  }
}

class DataServiceOcurrence {
  static Future<List<GetOcurrence>?> fetchDataOcurrence(
      BuildContext context,
      String token,
      String urlBasic,
      String empresaid,
      String data) async {
    List<GetOcurrence>? ocurrences;
    try {
      var urlPost = Uri.parse('''$urlBasic/ideia/core/getdata/ocorrenciaproduto%20o%20WHERE%20o.empresa_id%20=%20'$empresaid'%20AND%20o.datacadastro%20$data/''');

      var response = await http.get(
        urlPost,
        headers: {
          'Accept': 'text/html',
        },
      );

      if (empresaid.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            padding: EdgeInsets.all(Style.SaveUrlMessagePadding(context)),
            content: Text(
              'Empresa não vinculada ao usuário',
              style: TextStyle(
                fontSize: Style.SaveUrlMessageSize(context),
                color: Style.tertiaryColor,
              ),
            ),
            backgroundColor: Style.errorColor,
          ),
        );
      }

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        if (jsonData.containsKey('data') && jsonData['data'] is Map) {
          // Busca a primeira chave dentro de 'data', pois ela é dinâmica
          var dynamicKey = jsonData['data'].keys.first;

          // Verifica se o valor associado à chave é uma lista
          var dataList = jsonData['data'][dynamicKey];
          if (dataList != null && dataList is List) {
            ocurrences = dataList.map((e) => GetOcurrence.fromJson(e)).toList();

            ocurrences = ocurrences
                .where((ocurrence) => ocurrence.flagexcluido == 0)
                .toList();
          } else {
            print('Dados ausentes no JSON. Ocorrências');
          }
        }
      }
    } catch (e) {
      print('Erro durante a requisição GetOcorrencia: $e');
    }
    return ocurrences;
  }
}

class GetOcurrenceItem {
  String? obsitem;
  String? codigoproduto;
  String? nomeproduto;
  int? quantidade;
  int? numeroitem;
  int? quantidadeinformada;
  int? quantidadeestoque;
  String? ocorrenciaprodutoitemid;
  String? ocorrenciaprodutoid;

  GetOcurrenceItem({
    required this.obsitem,
    required this.codigoproduto,
    required this.nomeproduto,
    required this.quantidade,
    required this.numeroitem,
    required this.quantidadeinformada,
    required this.quantidadeestoque,
    required this.ocorrenciaprodutoitemid,
    required this.ocorrenciaprodutoid,
  });

  factory GetOcurrenceItem.fromJson(Map<String, dynamic> json) {
    return GetOcurrenceItem(
      obsitem: (json['obsitem'] ?? '').toString(),
      codigoproduto: (json['codigo'] ?? '').toString(),
      nomeproduto: (json['nome'] ?? '').toString(),
      quantidade: (json['quantidade'] ?? 0).toInt(),
      numeroitem: (json['numeroitem'] ?? 0).toInt(),
      quantidadeinformada: (json['quantidadeinformada'] ?? 0).toInt(),
      quantidadeestoque: (json['quantidadeestoque'] ?? 0).toInt(),
      ocorrenciaprodutoitemid:
          (json['ocorrenciaprodutoitem_id'] ?? '').toString(),
      ocorrenciaprodutoid: (json['ocorrenciaproduto_id'] ?? '').toString(),
    );
  }
}

class DataServiceOcurrenceItem {
  static Future<List<GetOcurrenceItem>?> fetchDataOcurrenceItem(
      String token,
      String urlBasic,
      String empresaid,
      String ocorrenciaprodutoid,
      // String ano,
      // String mes,
      // String dia
      String data) async {
    List<GetOcurrenceItem>? ocurrencesItem;

    try {
      // String dayFormatter = dia.padLeft(2, '0');
      // String monthFormatter = mes.padLeft(2, '0');
      var urlPost = Uri.parse(
          '''$urlBasic/ideia/core/getdata/ocorrenciaprodutoitem%20o%20WHERE%20o.ocorrenciaproduto_id%20=%20'$ocorrenciaprodutoid'/''');

      var response = await http.get(
        urlPost,
        headers: {
          'Accept': 'text/html',
        },
      );

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        if (jsonData.containsKey('data') && jsonData['data'] is Map) {
          // Busca a primeira chave dentro de 'data', pois ela é dinâmica
          var dynamicKey = jsonData['data'].keys.first;

          // Verifica se o valor associado à chave é uma lista
          var dataList = jsonData['data'][dynamicKey];
          if (dataList != null && dataList is List) {
            ocurrencesItem =
                dataList.map((e) => GetOcurrenceItem.fromJson(e)).toList();

            ocurrencesItem = ocurrencesItem
                .where((ocurrenceItem) =>
                    ocurrenceItem.ocorrenciaprodutoid == ocorrenciaprodutoid)
                .toList();
          } else {
            print('Dados ausentes no JSON. Ocorrências');
          }
        }
      }
    } catch (e) {
      print('Erro durante a requisição Ocorrencia: $e');
    }
    return ocurrencesItem;
  }
}
