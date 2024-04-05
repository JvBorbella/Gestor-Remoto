import 'package:flutter/material.dart';
import 'package:projeto/front/components/Style.dart';

class DayValues extends StatefulWidget {
  final String text;

  const DayValues({Key? key, required this.text}) : super(key: key);

  @override
  State<DayValues> createState() => _DayValuesState();
}

class _DayValuesState extends State<DayValues> {
  @override
  Widget build(BuildContext context) {
    return Material(
      //Código do texto que armazenará os valores nos cards de cada filial da home
      child: Text(
        widget.text,
        style: TextStyle(
            // fontSize: MediaQuery.of(context).size.width < 600
            //     ? MediaQuery.of(context).size.width * 0.032
            //     : MediaQuery.of(context).size.width * 0.012,
            color: Style.primaryColor,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
