import 'package:flutter/material.dart';
import 'package:projeto/front/components/style.dart';

class ConditionalTextCardRequests extends StatelessWidget {
  final int solicitacoesremotas;

  const ConditionalTextCardRequests({Key? key, required this.solicitacoesremotas})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Row(
          children: [
            if (solicitacoesremotas == 0)
              Text(
                'Não há nenhuma requisição no momento',
                style: TextStyle(
                  fontSize: Style.ConditionalTextSize(context),
                  color: Color(0xffA6A6A6),
                ),
              ),
            if (solicitacoesremotas > 0)
              Text(
                'Nova solicitação!',
                style: TextStyle(
                  fontSize: Style.ConditionalTextSize(context),
                  color: Color(0xff00568E),
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
