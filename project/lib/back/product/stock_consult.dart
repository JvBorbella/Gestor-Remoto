import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/Front/components/style.dart';

class StockConsult {
  //--- Produto ---
  String? imagem_url;
  String? codigo;
  String? nome;
  dynamic tpreco01;
  dynamic tcusto01;
  String? unidademedida_id;
  String? grupotributarioproduto_id;
  dynamic pesoliquido;
//--- Empresa---
  String empresa_codigo;
  String? empresa_nome;
  int? estoqueminimo;
  int? estoquemaximo;
  int? estoqueseguranca;
  int? estoquepontopedido;
  dynamic dataultimavenda;
  String? classificacaoabc;
//---Estoque---
  String? codigo_2;
  String? nome_2;
  String? estoque_id;
  String? estoque_id_2;
  dynamic quantidade;

  String? nome_3;
  String? abreviacao;

  StockConsult({
    required this.imagem_url,
    required this.codigo,
    required this.nome,
    required this.tpreco01,
    required this.tcusto01,
    required this.unidademedida_id,
    required this.grupotributarioproduto_id,
    required this.pesoliquido,
    required this.empresa_codigo,
    required this.empresa_nome,
    required this.estoqueminimo,
    required this.estoquemaximo,
    required this.estoqueseguranca,
    required this.estoquepontopedido,
    required this.dataultimavenda,
    required this.classificacaoabc,
    required this.codigo_2,
    required this.nome_2,
    required this.estoque_id,
    required this.estoque_id_2,
    required this.quantidade,
    required this.nome_3,
    required this.abreviacao,
  });

  factory StockConsult.fromJson(Map<String, dynamic> json) {
    return StockConsult(
      imagem_url: (json['imagem_url'] ?? '').toString(),
      codigo: (json['codigo'] ?? '').toString(),
      nome: (json['nome'] ?? '').toString(),
      tpreco01: json['tpreco01'] is int
          ? (json['tpreco01'] as int).toDouble()
          : json['tpreco01'] is double
              ? json['tpreco01'] as double
              : 0.0,
      tcusto01: json['tcusto01'] is int
          ? (json['tcusto01'] as int).toDouble()
          : json['tcusto01'] is double
              ? json['tcusto01'] as double
              : 0.0,
      unidademedida_id: (json['unidademedida_id'] ?? '').toString(),
      grupotributarioproduto_id: (json['grupotributarioproduto_id'] ?? '').toString(),
      pesoliquido: json['pesoliquido'] is int
          ? (json['pesoliquido'] as int).toDouble()
          : json['pesoliquido'] is double
              ? json['pesoliquido'] as double
              : 0.0,
      empresa_codigo: (json['empresa_codigo'] ?? '').toString(),
      empresa_nome: (json['empresa_nome'] ?? '').toString(),
      estoqueminimo: (json['estoqueminimo'] ?? 0).toInt(),
      estoquemaximo: (json['estoquemaximo'] ?? 0).toInt(),
      estoqueseguranca: (json['estoqueseguranca'] ?? 0).toInt(),
      estoquepontopedido: (json['estoquepontopedido'] ?? 0).toInt(),
      dataultimavenda: json['dataultimavenda'] != null ? DateTime.parse(json['dataultimavenda']) : null,
      classificacaoabc: (json['classificacaoabc_1'] ?? '').toString(),
      codigo_2: (json['codigo_2'] ?? '').toString(),
      nome_2: (json['nome_2'] ?? '').toString(),
      estoque_id: (json['estoque_id'] ?? '').toString(),
      estoque_id_2: (json['estoque_id_2'] ?? '').toString(),
      quantidade: (json['quantidade'] ?? 0).toInt(),
      nome_3: (json['nome_3'] ?? '').toString(),
      abreviacao: (json['abreviacao'] ?? '').toString(),
    );
  }
}

class DataServiceStockConsult {
  static Future<List<StockConsult>?> fetchDataStockConsult(
    context,
    String urlBasic,
    String empresa_id,
    String produto,
  ) async {
    List<StockConsult>? stockConsult;

    try {
      String rawQueryDay =
          '''produtoestoque%20pe%20INNER%20JOIN%20produto%20p%20ON%20pe.produto_id%20=%20p.produto_id%20INNER%20JOIN%20empresa%20e%20ON%20e.empresa_id%20=%20pe.empresa_id%20INNER%20JOIN%20estoque%20et%20ON%20et.estoque_id%20=%20pe.estoque_id%20INNER%20JOIN%20produtoempresa%20pem%20ON%20pem.produto_id%20=%20p.produto_id%20AND%20pem.empresa_id%20=%20e.empresa_id%20INNER%20JOIN%20grupotributarioproduto%20gp%20ON%20gp.grupotributarioproduto_id%20=%20p.grupotributarioproduto_id%20INNER%20JOIN%20unidademedida%20un%20ON%20un.unidademedida_id%20=%20p.unidademedida_id%20WHERE%20p.codigo%20=%20'$produto'%20AND%20('$empresa_id'%20=%20''%20OR%20e.empresa_id%20=%20'$empresa_id')/''';

      var urlPost = Uri.parse('$urlBasic/ideia/core/getdata/$rawQueryDay');

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
            stockConsult =
                dataList.map((e) => StockConsult.fromJson(e)).toList();

              stockConsult.sort((a, b) {
            return a.empresa_codigo.compareTo(b.empresa_codigo);
          });
                
          } else {
            print('A chave dinâmica não contém uma lista válida.');
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              padding: EdgeInsets.all(Style.SaveUrlMessagePadding(context)),
              content: Text(
                'Produto não encontrado',
                style: TextStyle(
                  fontSize: Style.SaveUrlMessageSize(context),
                  color: Style.tertiaryColor,
                ),
              ),
              backgroundColor: Style.errorColor,
            ),
          );
          print('Estrutura "data" ausente ou inválida no JSON.');
        }
      } else {
        print('Erro HTTP: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro durante a requisição nfeValues: $e');
    }
    return stockConsult;
  }
}
