import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/front/components/style.dart';

class YesterdayDetails extends StatefulWidget {
  final int ticketOntem;
  final double ticketmedioOntem;
  final double margemOntem;

  const YesterdayDetails({
    Key? key,
    required this.ticketOntem,
    required this.ticketmedioOntem,
    required this.margemOntem,
  });

  @override
  State<YesterdayDetails> createState() => _YesterdayDetailsState();
}

class _YesterdayDetailsState extends State<YesterdayDetails> {
   NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  Widget build(BuildContext context) {
    return Material(
      //Código dos valores adicionais do card de vendas
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                 Container(
                      //Estilização
                      padding: EdgeInsets.all(Style.height_8(context)),
                      decoration: BoxDecoration(
                        color: Style.primaryColor,
                        // borderRadius: BorderRadius.only(
                        //     bottomLeft: Radius.circular(Style.height_1(context)),
                        //     bottomRight: Radius.circular(Style.height_1(context))),
                            border: Border.all(color: Colors.transparent),
                      ),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Ticket md',
                                      style: TextStyle(
                                          color: Style.tertiaryColor,
                                          fontSize: Style.TextDetailsSize(context),
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      (currencyFormat.format(widget.ticketmedioOntem)),
                                      style: TextStyle(
                                          color: Style.tertiaryColor,
                                          fontSize: Style.height_8(context),
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: Style.height_10(context),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Margem',
                                      style: TextStyle(
                                          color: Style.tertiaryColor,
                                          fontSize: Style.TextDetailsSize(context),
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      '${widget.margemOntem.toStringAsFixed(2)}%',
                                      style: TextStyle(
                                          color: Style.tertiaryColor,
                                          fontSize: Style.height_8(context),
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: Style.height_10(context),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Cupons',
                                      style: TextStyle(
                                          color: Style.tertiaryColor,
                                          fontSize: Style.TextDetailsSize(context),
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      widget.ticketOntem.toString(),
                                      style: TextStyle(
                                          color: Style.tertiaryColor,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
