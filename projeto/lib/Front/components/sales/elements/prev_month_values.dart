import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/Front/components/Style.dart';
import 'package:projeto/front/components/sales/elements/text_card_sales.dart';

class PrevMonthValues extends StatefulWidget {
  final double valorMesAnt;
  final int cancelamentosMesAnt;
  final double metaMesAnt;
  final double valorcancelamentosMesAnt;

  const PrevMonthValues({
    Key? key,
    required this.valorMesAnt,
    required this.cancelamentosMesAnt,
    required this.metaMesAnt,
    required this.valorcancelamentosMesAnt,
  });

  @override
  State<PrevMonthValues> createState() => _PrevMonthValuesState();
}

class _PrevMonthValuesState extends State<PrevMonthValues> {
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
                    TextCardSales(text: currencyFormat.format(widget.valorMesAnt))
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
                    if (widget.valorMesAnt == 0 && widget.metaMesAnt == 0)
                      TextCardSales(text: currencyFormat.format(widget.metaMesAnt))

                    else if (widget.valorMesAnt == 0 || widget.metaMesAnt == 0)
                      TextCardSales(text: currencyFormat.format(widget.metaMesAnt))

                    else if (widget.valorMesAnt > widget.metaMesAnt ||
                        widget.valorMesAnt == widget.metaMesAnt)
                      Row(
                        children: [
                          TextCardSales(
                              text: currencyFormat.format(widget.metaMesAnt)),
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
                          text: currencyFormat.format(widget.metaMesAnt)),
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
                    TextCardSales(text: widget.cancelamentosMesAnt.toString())
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
                            .format(widget.valorcancelamentosMesAnt))
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
