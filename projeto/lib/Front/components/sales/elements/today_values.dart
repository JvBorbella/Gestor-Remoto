import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/Front/components/Style.dart';
import 'package:projeto/front/components/sales/elements/text_card_sales.dart';

class TodayValues extends StatefulWidget {
  final double valorHoje;
  final int cancelamentosHoje;
  final double metaHoje;
  final double valorcancelamentosHoje;

  const TodayValues({
    Key? key,
    required this.valorHoje,
    required this.cancelamentosHoje,
    required this.metaHoje,
    required this.valorcancelamentosHoje,
  });

  @override
  State<TodayValues> createState() => _TodayValuesState();
}

class _TodayValuesState extends State<TodayValues> {
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
                    TextCardSales(text: currencyFormat.format(widget.valorHoje))
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Meta',
                      style:
                          TextStyle(fontSize: 9, color: Style.quarantineColor),
                    ),
                   if (widget.valorHoje == 0 && widget.metaHoje == 0)
                      TextCardSales(text: currencyFormat.format(widget.metaHoje))

                    else if (widget.valorHoje == 0 || widget.metaHoje == 0)
                      TextCardSales(text: currencyFormat.format(widget.metaHoje))

                    else if (widget.valorHoje > widget.metaHoje ||
                        widget.valorHoje == widget.metaHoje)
                      Row(
                        children: [
                          TextCardSales(
                              text: currencyFormat.format(widget.metaHoje)),
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
                          text: currencyFormat.format(widget.metaHoje)),
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
                          text: widget.cancelamentosHoje.toString())
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Vl. Cancelamento',
                      style:
                          TextStyle(fontSize: 9, color: Style.quarantineColor),
                    ),
                      TextCardSales(text: currencyFormat.format(widget.valorcancelamentosHoje))
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
