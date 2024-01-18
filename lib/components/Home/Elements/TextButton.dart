import 'package:flutter/material.dart';
import 'package:projeto/pages/sales.dart';

class TextBUtton extends StatefulWidget {
  final String text;

  const TextBUtton({Key? key, required this.text}) : super(key: key);

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
                MaterialPageRoute(builder: (context) => Sales()),
              );
            },
            //Aparência do button
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                //Texto do button está sendo definido na página home.Dart
                widget.text,
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
