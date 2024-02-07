//Código do card que armazenará o valor total de vendas na página inicial

import 'package:flutter/material.dart';

class TotalCard extends StatefulWidget {
  final double vendadia;

  const TotalCard({Key? key, required this.vendadia});

  @override
  State<TotalCard> createState() => _TotalCardState();
}

class _TotalCardState extends State<TotalCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        //Espaçamento entre o card e as bordas
        margin:
            EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0, bottom: 10.0),
        //Estilização
        decoration: BoxDecoration(
          color: Color(0xFF00568e),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          //Conteúdo interno do card
          children: [
            Row(
              children: [
                Text(
                  'Total de hoje - RS ' + widget.vendadia.toString(),
                  style: TextStyle(
                      color: Color(0xffFFFFFF),
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
          ],
        ),
        //espaçamento interno
        padding: EdgeInsets.only(left: 10.0, top: 10, bottom: 10),
      ),
    );
  }
}
