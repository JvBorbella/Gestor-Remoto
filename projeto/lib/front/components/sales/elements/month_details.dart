import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/front/components/Style.dart';

class MonthDetails extends StatefulWidget {
  final int ticketMes;
  final double ticketmedioMes;
  final double margemMes;

  const MonthDetails({
    Key? key,
    required this.ticketMes,
    required this.ticketmedioMes,
    required this.margemMes,
  });

  @override
  State<MonthDetails> createState() => _MonthDetailsState();
}

class _MonthDetailsState extends State<MonthDetails> {
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
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Style.primaryColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5))),
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
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      (currencyFormat.format(widget.ticketmedioMes)),
                                      style: TextStyle(
                                          color: Style.tertiaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Margem',
                                      style: TextStyle(
                                          color: Style.tertiaryColor,
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      '${widget.margemMes.toStringAsFixed(2)}%',
                                      style: TextStyle(
                                          color: Style.tertiaryColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Cupons',
                                      style: TextStyle(
                                          color: Style.tertiaryColor,
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      widget.ticketMes.toString(),
                                      style: TextStyle(
                                          color: Style.tertiaryColor,
                                          fontSize: 12,
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
