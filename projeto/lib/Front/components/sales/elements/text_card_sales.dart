import 'package:flutter/material.dart';
import 'package:projeto/Front/components/Style.dart';

class TextCardSales extends StatefulWidget {
  final String text;

  const TextCardSales({Key? key, required this.text}) : super(key: key);

  @override
  State<TextCardSales> createState() => _TextCardSalesState();
}

class _TextCardSalesState extends State<TextCardSales> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Text(
        widget.text,
        style: TextStyle(
          fontSize: 18,
          color: Style.primaryColor,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}