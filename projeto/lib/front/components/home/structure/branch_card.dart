import 'package:flutter/material.dart';
import 'package:projeto/front/components/style.dart';

class BranchCard extends StatefulWidget {
  //Variável para inserir objetos dentro do card
  final List<Widget> children;

  const BranchCard({Key? key, required this.children,}) : super(key: key);

  @override
  State<BranchCard> createState() => _BranchCardState();
}

class _BranchCardState extends State<BranchCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      // Código do card
      child: Container(
        //Margem externa e altura do card que está sendo definida na página home.dart
        margin: EdgeInsets.only(right: Style.height_20(context), left: Style.height_20(context), bottom: Style.height_15(context)),
        decoration: BoxDecoration(
            //Estilização do card
            color: Color(0xffffffff),
            border: Border.all(width: Style.height_1(context), color: Color(0xffD9D9D9)),
            borderRadius: BorderRadius.circular(Style.height_10(context))),
        //Parte do código para que sejam atribuidos os widgets definidos no código da tela que ficarão dentro do card
        child: Column(
          
          children: widget.children,
        ),
        padding: EdgeInsets.only(bottom: Style.height_10(context), top: Style.height_5(context)),
      ),
    );
  }
}
