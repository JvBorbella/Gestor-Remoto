import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/Front/components/Sales/Elements/text_card_sales.dart';
import 'package:projeto/Front/components/Style.dart';

class ValuesYesterday extends StatefulWidget {
  final double valorOntem;
  final int cancelamentosOntem;
  final double metaOntem;
  final double valorcancelamentosOntem;

  const ValuesYesterday({
    Key? key,
    required this.valorOntem,
    required this.cancelamentosOntem,
    required this.metaOntem,
    required this.valorcancelamentosOntem,
  });

  @override
  State<ValuesYesterday> createState() => _ValuesYesterdayState();
}

class _ValuesYesterdayState extends State<ValuesYesterday> {
  NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  Widget build(BuildContext context) {
    return Material(
      //Código dos valores que estarão na tela de vendas
      child: Container(
        child: Column(
          children: [
            //Primeira linha
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Total vendido',
                      style:
                          TextStyle(fontSize: 9, color: Style.quarantineColor),
                    ),
                    TextValues(text: currencyFormat.format(widget.valorOntem))
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Meta',
                      style:
                          TextStyle(fontSize: 9, color: Style.quarantineColor),
                    ),
                    TextValues(text: currencyFormat.format(widget.metaOntem))
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            //Segunda linha
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Cancelamentos',
                      style:
                          TextStyle(fontSize: 9, color: Style.quarantineColor),
                    ),
                      TextValues(
                          text: widget.cancelamentosOntem.toString())
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Vl. Cancelamento',
                      style:
                          TextStyle(fontSize: 9, color: Style.quarantineColor),
                    ),
                      TextValues(text: currencyFormat.format(widget.valorcancelamentosOntem))
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            //Linha divisória
            // Divider(
            //   color: Style.quarantineColor, // Cor da linha
            //   height: 20, // Altura da linha
            //   thickness: 2,
            // ),
            // SizedBox(
            //   height: 0,
            // ),
            // //Valores de metas
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Column(
            //       children: [
            //         Text(
            //           'Meta de hoje',
            //           style:
            //               TextStyle(fontSize: 9, color: Style.quarantineColor),
            //         ),
            //         TextValues(text: '(Valor)')
            //       ],
            //     ),
            //     Column(
            //       children: [
            //         Text(
            //           'Meta acum.',
            //           style:
            //               TextStyle(fontSize: 9, color: Style.quarantineColor),
            //         ),
            //         TextValues(text: '(Valor)')
            //       ],
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
