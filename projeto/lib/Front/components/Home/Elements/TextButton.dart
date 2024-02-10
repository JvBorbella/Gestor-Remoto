import 'package:flutter/material.dart';
import 'package:projeto/Front/pages/sales.dart';

class TextBUtton extends StatefulWidget {
  final String empresaNome;
  final double valorHoje;
  final double valorOntem;
  // final double valorSemana;
  // final double valorMes;
  final String url;
  final token;
  final int ticket;

  const TextBUtton(
      {Key? key,
      required this.empresaNome,
      this.token,
      this.url = '',
      required this.valorHoje,
      required this.valorOntem,
      // required this.valorSemana,
      // required this.valorMes,
      required this.ticket,
      })
      : super(key: key);

  @override
  State<TextBUtton> createState() => _TextButtonState();
}

class _TextButtonState extends State<TextBUtton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      //Código do card
      child: Column(
        children: [
          TextButton(
            //Padding 0 para deixar o button alinhado com o card
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            onPressed: () {
              //Redirecionamento executada ao clicar no button
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => Sales(
                        url: widget.url,
                        token: widget.token,
                        empresaNome: widget.empresaNome,
                        valorHoje: widget.valorHoje,
                        valorOntem: widget.valorOntem,
                        // valorSemana: widget.valorSemana,
                        // valorMes: widget.valorMes,
                        ticket: widget.ticket)),
              );
            },
            //Aparência do button
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                //Texto do button está sendo definido na página home.Dart
                widget.empresaNome,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff00568e)),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
