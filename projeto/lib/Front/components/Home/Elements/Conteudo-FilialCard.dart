import 'package:flutter/material.dart';
import 'package:projeto/Front/components/Home/Elements/Values-of-Days.dart';

class ConteudoFilialCard extends StatefulWidget {
  const ConteudoFilialCard({super.key});

  @override
  State<ConteudoFilialCard> createState() => _ConteudoFilialCardState();
}

class _ConteudoFilialCardState extends State<ConteudoFilialCard> {
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
                      style: TextStyle(fontSize: 12, color: Color(0xffA6A6A6)),
                    ),
                    ValuesDays(text: 'RS 000.000,00')
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Ontem',
                      style: TextStyle(fontSize: 12, color: Color(0xffA6A6A6)),
                    ),
                    ValuesDays(text: 'RS 000.000,00')
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Meta',
                      style: TextStyle(fontSize: 12, color: Color(0xffA6A6A6)),
                    ),
                    ValuesDays(text: 'RS 000.000,00')
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
                      'Projeção de venda',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffA6A6A6)),
                    ),
                    Text(
                      'RS 0.000.000,00',
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width < 600
                              ? MediaQuery.of(context).size.width * 0.07
                              : MediaQuery.of(context).size.width * 0.018,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff00568e)),
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
}
