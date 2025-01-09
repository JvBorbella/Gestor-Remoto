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
                          TextStyle( 
                            color: Style.quarantineColor,
                            fontSize: Style.height_8(context)
                            ),
                    ),
                    TextCardSales(text: currencyFormat.format(widget.valorOntem))
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
                          text: currencyFormat.format(widget.metaOntem)),
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
                          text: widget.cancelamentosOntem.toString())
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
                      TextCardSales(text: currencyFormat.format(widget.valorcancelamentosOntem))
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
