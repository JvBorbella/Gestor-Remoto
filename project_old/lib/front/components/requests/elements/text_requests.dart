import 'package:flutter/material.dart';
import 'package:project/front/components/style.dart';

class TextSolicitacion extends StatefulWidget {
  final String text;

  const TextSolicitacion({Key? key, required this.text}) : super(key: key);

  @override
  State<TextSolicitacion> createState() => _TextSolicitacionState();
}

class _TextSolicitacionState extends State<TextSolicitacion> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Text(
        //Texto que será exibido está sendo definido na página em que este widget está sendo chamado
        widget.text,
        style: TextStyle(
          fontSize: Style.TextSolicitacionSize(context),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
