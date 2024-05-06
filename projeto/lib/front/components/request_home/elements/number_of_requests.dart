import 'package:flutter/material.dart';
import 'package:projeto/front/components/style.dart';

class NumberOfRequests extends StatefulWidget {
  //Variável para definir o número de requisições
  final int solicitacoesremotas;

  const NumberOfRequests({Key? key, required this.solicitacoesremotas}) : super(key: key);

  @override
  State<NumberOfRequests> createState() => _NumberOfRequestsState();
}

class _NumberOfRequestsState extends State<NumberOfRequests> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        //Método para verificar o número de requisições e definir uma estilização a partir disso.
        child: Text(
          '${widget.solicitacoesremotas > 0 ? widget.solicitacoesremotas : ""}',
          style: TextStyle(
            fontSize: Style.NumberOfRequestsSize(context),
            fontWeight: FontWeight.bold,
            color: Color(0xffFFFFFF),
          ),
          textAlign: TextAlign.center,
        ),
        //Caso seja 0, a área externa será branca, fazendo com que o não seja exibido
        //Se for maior que 0, a área externa será amarela, dando destaque ao número de requisições
        decoration: BoxDecoration(
          color: widget.solicitacoesremotas > 0
              ? Color(0xffFFD700)
              : Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        width: Style.BackgroundNumberOfRequestsSize(context),
        height: Style.BackgroundNumberOfRequestsSize(context),
        padding: EdgeInsets.all(2),
      ),
    );
  }
}
