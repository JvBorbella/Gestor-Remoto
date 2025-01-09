import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/front/components/style.dart';
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
                          TextStyle( 
                            color: Style.quarantineColor,
                            fontSize: Style.height_8(context)
                            ),
                    ),
                    TextCardSales(text: currencyFormat.format(widget.valorHoje))
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
                              SizedBox(width: Style.height_2(context),),
                          Icon(
                            Icons.verified,
                            color: Style.sucefullColor,
                            size: Style.IconVerifiedSize(context),
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
                      TextCardSales(
                          text: widget.cancelamentosHoje.toString())
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
                      TextCardSales(text: currencyFormat.format(widget.valorcancelamentosHoje))
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
