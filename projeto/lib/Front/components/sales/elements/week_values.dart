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
                          TextStyle( 
                            color: Style.quarantineColor,
                            fontSize: Style.height_8(context)
                            ),
                    ),
                    TextCardSales(text: currencyFormat.format(widget.valorSemana))
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Meta',
                      style:
                          TextStyle( 
                            color: Style.quarantineColor,
                            fontSize: Style.height_8(context)
                            ),
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
                              SizedBox(width: Style.height_2(context),),
                          Icon(
                            Icons.verified,
                            color: Style.sucefullColor,
                            size: Style.height_15(context),
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
              height: Style.height_30(context),
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
                          TextStyle( 
                            color: Style.quarantineColor,
                            fontSize: Style.height_8(context)
                            ),
                    ),
                    TextCardSales(text: widget.cancelamentosSemana.toString())
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Vl. Cancelamento',
                      style:
                          TextStyle( 
                            color: Style.quarantineColor,
                            fontSize: Style.height_8(context)
                            ),
                    ),
                    TextCardSales(
                        text: currencyFormat
                            .format(widget.valorcancelamentosSemana))
                  ],
                ),
              ],
            ),
            SizedBox(
              height: Style.height_20(context),
            ),
          ],
        ),
      ),
    );
  }
}
