import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/Front/components/Style.dart';
import 'package:projeto/front/components/sales/elements/text_card_sales.dart';

class MonthValues extends StatefulWidget {
  final double valorMes;
  final int cancelamentosMes;
  final double metaMes;
  final double valorcancelamentosMes;

  const MonthValues({
    Key? key,
    required this.valorMes,
    required this.cancelamentosMes,
    required this.metaMes,
    required this.valorcancelamentosMes,
  });

  @override
  State<MonthValues> createState() => _MonthValuesState();
}

class _MonthValuesState extends State<MonthValues> {
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
                    TextCardSales(text: currencyFormat.format(widget.valorMes))
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Meta',
                      style:
                          TextStyle( color: Style.quarantineColor),
                    ),
                    if (widget.valorMes == 0 && widget.metaMes == 0)
                      TextCardSales(text: currencyFormat.format(widget.metaMes))

                    else if (widget.valorMes == 0 || widget.metaMes == 0)
                      TextCardSales(text: currencyFormat.format(widget.metaMes))

                    else if (widget.valorMes > widget.metaMes ||
                        widget.valorMes == widget.metaMes)
                      Row(
                        children: [
                          TextCardSales(
                              text: currencyFormat.format(widget.metaMes)),
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
                          text: currencyFormat.format(widget.metaMes)),
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
                          text: widget.cancelamentosMes.toString())
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
                      TextCardSales(text: currencyFormat.format(widget.valorcancelamentosMes))
                  ],
                ),
              ],
            ),
            SizedBox(
              height: Style.height_20(context),
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
            //               TextStyle( color: Style.quarantineColor),
            //         ),
            //         TextCardSales(text: '(Valor)')
            //       ],
            //     ),
            //     Column(
            //       children: [
            //         Text(
            //           'Meta acum.',
            //           style:
            //               TextStyle( color: Style.quarantineColor),
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
