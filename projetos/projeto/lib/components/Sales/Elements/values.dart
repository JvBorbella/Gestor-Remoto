import 'package:flutter/material.dart';
import 'package:projeto/components/Sales/Elements/Text-Values.dart';

class Values extends StatefulWidget {
  const Values({super.key});

  @override
  State<Values> createState() => _ValuesState();
}

class _ValuesState extends State<Values> {
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
                      'Hoje',
                      style: TextStyle(fontSize: 9, color: Color(0xffA6A6A6)),
                    ),
                    TextValues(text: '(Valor)')
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Ontem',
                      style: TextStyle(fontSize: 9, color: Color(0xffA6A6A6)),
                    ),
                    TextValues(text: '(Valor)')
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
                      'Semana passada',
                      style: TextStyle(fontSize: 9, color: Color(0xffA6A6A6)),
                    ),
                    TextValues(text: '(Valor)')
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Mês passado',
                      style: TextStyle(fontSize: 9, color: Color(0xffA6A6A6)),
                    ),
                    TextValues(text: '(Valor)')
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            //Linha divisória
            Divider(
              color: Color(0xffD9D9D9), // Cor da linha
              height: 20, // Altura da linha
              thickness: 2,
            ),
            SizedBox(
              height: 0,
            ),
            //Valores de metas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Meta de hoje',
                      style: TextStyle(fontSize: 9, color: Color(0xffA6A6A6)),
                    ),
                    TextValues(text: '(Valor)')
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Meta acum.',
                      style: TextStyle(fontSize: 9, color: Color(0xffA6A6A6)),
                    ),
                    TextValues(text: '(Valor)')
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
