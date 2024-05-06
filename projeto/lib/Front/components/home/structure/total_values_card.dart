//Código do card que armazenará o valor total de vendas na página inicial

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/front/components/Style.dart';

class TotalValuesCard extends StatefulWidget {
  // final double vendadia;
  // final double vendadiaanterior;
  // final double vendasemana;
  // final double vendames;
  final double children;
  final text;

  const TotalValuesCard({
    Key? key,
    required this.children,
    this.text,
    // required this.vendadia,
    // required this.vendadiaanterior,
    // required this.vendasemana,
    // required this.vendames,
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
        //Espaçamento entre o card e as bordas
        // margin:
        //     EdgeInsets.only(top: 5.0, right: 20.0, left: 20.0, bottom: 10.0),
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
                      // fontSize: MediaQuery.of(context).size.width * 0.04,
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
