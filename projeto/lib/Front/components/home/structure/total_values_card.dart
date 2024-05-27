//Código do card que armazenará o valor total de vendas na página inicial

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/front/components/Style.dart';

class TotalValuesCard extends StatefulWidget {
  final double children;
  final text;

  const TotalValuesCard({
    Key? key,
    required this.children,
    this.text,
  });

  @override
  State<TotalValuesCard> createState() => _TotalValuesCardState();
}

class _TotalValuesCardState extends State<TotalValuesCard> {
  NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        //Estilização
        decoration: BoxDecoration(
          color: Style.primaryColor,
          borderRadius: BorderRadius.circular(Style.height_10(context)),
        ),
        child: Column(
          //Conteúdo interno do card
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.text + currencyFormat.format(widget.children),
                  style: TextStyle(
                      color: Color(0xffFFFFFF),
                      fontWeight: FontWeight.bold,
                      fontSize: Style.height_8(context),
                      ),
                ),
              ],
            ),
          ],
        ),
        //espaçamento interno
        padding: EdgeInsets.all(Style.height_10(context)),
        width: MediaQuery.of(context).size.width * 0.41,
      ),
    );
  }
}
