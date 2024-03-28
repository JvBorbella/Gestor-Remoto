import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/Front/components/Style.dart';
import 'package:projeto/front/components/sales/elements/text_card_sales.dart';

class WeekValues extends StatefulWidget {
  final double valorSemana;
  final int cancelamentosSemana;
  final double metaSemana;
  final double valorcancelamentosSemana;

  const WeekValues({
    Key? key,
    required this.valorSemana,
    required this.cancelamentosSemana,
    required this.metaSemana,
    required this.valorcancelamentosSemana,
  });

  @override
  State<WeekValues> createState() => _WeekValuesState();
}

class _WeekValuesState extends State<WeekValues> {
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
                    TextCardSales(text: currencyFormat.format(widget.valorSemana))
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Meta',
                      style:
                          TextStyle(fontSize: 9, color: Style.quarantineColor),
                    ),
                    if (widget.valorSemana == 0 && widget.metaSemana == 0)
                      TextCardSales(text: currencyFormat.format(widget.metaSemana))

                    else if (widget.valorSemana == 0 || widget.metaSemana == 0)
                      TextCardSales(text: currencyFormat.format(widget.metaSemana))

                    else if (widget.valorSemana > widget.metaSemana ||
                        widget.valorSemana == widget.metaSemana)
                      Row(
                        children: [
                          TextCardSales(
                              text: currencyFormat.format(widget.metaSemana)),
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
                          text: currencyFormat.format(widget.metaSemana)),
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
                    TextCardSales(text: widget.cancelamentosSemana.toString())
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Vl. Cancelamento',
                      style:
                          TextStyle(fontSize: 9, color: Style.quarantineColor),
                    ),
                    TextCardSales(
                        text: currencyFormat
                            .format(widget.valorcancelamentosSemana))
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
