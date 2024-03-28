import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:projeto/front/components/Home/Elements/day_values.dart';

import 'package:projeto/front/components/Style.dart';

class BranchCardContent extends StatefulWidget {

  final double valorHoje;
  final double valorOntem;
  final double valorSemana;
  final double valorMes;

  const BranchCardContent(
      {Key? key,
      required this.valorHoje,
      required this.valorOntem,
      required this.valorSemana,
      required this.valorMes})
      : super(key: key);

  @override
  State<BranchCardContent> createState() => _BranchCardContentState();
}

class _BranchCardContentState extends State<BranchCardContent> {
  bool isLoading = true;
  NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
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
                      'Hoje',
                      style: TextStyle(fontSize: 12, color: Style.quarantineColor),
                    ),
                    DayValues(text: currencyFormat.format(widget.valorHoje.toInt()))
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Ontem',
                      style: TextStyle(fontSize: 12, color: Style.quarantineColor),
                    ),
                     if (widget.valorOntem == 0)
                      DayValues(
                          text: currencyFormat.format(widget.valorOntem))
                    else
                      DayValues(
                          text: currencyFormat.format(widget.valorOntem)),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Semana',
                      style: TextStyle(fontSize: 12, color: Style.quarantineColor),
                    ),
                    if (widget.valorSemana == 0)
                      Container(
                        width: 10,
                        height: 10,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    else
                      DayValues(
                          text: currencyFormat.format(widget.valorSemana)),
                  ],
                ),
              ],
            ),
            //Linha divisória interna do card
            Divider(
              color: Color(0xffD9D9D9), // Cor da linha
              height: 20, // Altura da linha
              thickness: 1,
            ),
            //Conteúdo abaixo da linha divisória.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Vendas no mês',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Style.quarantineColor),
                    ),
                    if (widget.valorMes == 0)
                      Container(
                        width: 35,
                        height: 35,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    else
                      Text(
                        currencyFormat.format(widget.valorMes),
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width < 600
                                ? MediaQuery.of(context).size.width * 0.07
                                : MediaQuery.of(context).size.width * 0.018,
                            fontWeight: FontWeight.bold,
                            color: Style.primaryColor),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //  Future<void> fetchData() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   var url = Provider.of<UrlProvider>(context).url;
  //   var token = Provider.of<UrlProvider>(context).token;

  //   String? fetchedData = await DataService.fetchData(token, url,);

  //   if (fetchedData != null) {
  //     setState(() {
  //       valorHoje = fetchedData;
  //       isLoading = false; // Marcamos como carregado
  //     });
  //     print('Código da empresa: $valorHoje');
  //   }

  // }
}
