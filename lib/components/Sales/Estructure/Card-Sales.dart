import 'package:flutter/material.dart';

class CardSale extends StatefulWidget {
  final List<Widget> children;

  const CardSale({Key? key, required this.children,}) : super(key: key);

  @override
  State<CardSale> createState() => _CardSaleState();
}

class _CardSaleState extends State<CardSale> {
  @override
  Widget build(BuildContext context) {
    return Material(
      // Código do card usado na tela de vendas detalhadas
      child: Container(
        margin: EdgeInsets.all(12),
        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          border: Border.all(width: 4, color: Color(0xff00568e)),
          borderRadius: BorderRadius.circular(10),
        ),
        //Parte do código para que sejam atribuidos os widgets definidos no código da tela que ficarão dentro do card
        child: Column(
          children: widget.children,
        ),
      ),
    );
  }
}
