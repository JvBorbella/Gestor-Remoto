import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/Front/components/Style.dart';
import 'package:projeto/front/components/sales/elements/text_card_sales.dart';

class YesterdayValues extends StatefulWidget {
  final double valorOntem;
  final int cancelamentosOntem;
  final double metaOntem;
  final double valorcancelamentosOntem;

  const YesterdayValues({
    Key? key,
    required this.valorOntem,
    required this.cancelamentosOntem,
    required this.metaOntem,
    required this.valorcancelamentosOntem,
  });

  @override
  State<YesterdayValues> createState() => _YesterdayValuesState();
}

class _YesterdayValuesState extends State<YesterdayValues> {
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
                    TextCardSales(text: currencyFormat.format(widget.valorOntem))
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Meta',
                      style:
                          TextStyle(fontSize: 9, color: Style.quarantineColor),
                    ),
                    if (widget.valorOntem == 0 && widget.metaOntem == 0)
                      TextCardSales(text: currencyFormat.format(widget.metaOntem))
                      else if(widget.valorOntem == 0 || widget.metaOntem == 0)
                      TextCardSales(text: currencyFormat.format(widget.metaOntem))
                    else if (widget.valorOntem > widget.metaOntem ||
                        widget.valorOntem == widget.metaOntem)
                      Row(
                        children: [
                          TextCardSales(
                              text: currencyFormat.format(widget.metaOntem)),
                              SizedBox(width: 2,),
                          Icon(
                            Icons.verified,
                            color: Style.sucefullColor,
                            size: 16,
                          )
                        ],
                      )
                    else
                      TextCardSales(
                          text: currencyFormat.format(widget.metaOntem)),
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
                      TextCardSales(
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
                      TextCardSales(text: currencyFormat.format(widget.valorcancelamentosOntem))
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
            //         TextCardSales(text: '(Valor)')
            //       ],
            //     ),
            //     Column(
            //       children: [
            //         Text(
            //           'Meta acum.',
            //           style:
            //               TextStyle(fontSize: 9, color: Style.quarantineColor),
            //         ),
            //         TextCardSales(text: '(Valor)')
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
