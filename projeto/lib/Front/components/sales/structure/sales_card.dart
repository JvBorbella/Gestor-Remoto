import 'package:flutter/material.dart';
import 'package:projeto/front/components/style.dart';

class SalesCard extends StatefulWidget {
  final List<Widget> children;

  const SalesCard({Key? key, required this.children,}) : super(key: key);

  @override
  State<SalesCard> createState() => _SalesCardState();
}

class _SalesCardState extends State<SalesCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      // Código do card usado na tela de vendas detalhadas
      child: Container(
        margin: EdgeInsets.all(Style.height_12(context)),
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          border: Border.all(width: Style.height_2(context), color: Style.primaryColor),
          borderRadius: BorderRadius.circular(Style.height_5(context)),
        ),
        //Parte do código para que sejam atribuidos os widgets definidos no código da tela que ficarão dentro do card
        child: Column(
          children: widget.children,
        ),
      ),
    );
  }
}
