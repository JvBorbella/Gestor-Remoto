import 'package:flutter/material.dart';

class RequisitionCard extends StatefulWidget {
  //Variável para permitir preencher o card com objetos externos
  final List<Widget> children;
  //Variável para definir o tamanho do card diretamente na página em que está sendo chamado

  const RequisitionCard({Key? key, required this.children,}) : super(key: key);

  @override
  State<RequisitionCard> createState() => _RequisitionCardState();
}

class _RequisitionCardState extends State<RequisitionCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        //Espaçamento entre o card e as bordas
        margin: EdgeInsets.only(right: 20.0, left: 20.0),
        //Estilização
        decoration: BoxDecoration(
          color: Color(0xffFFFEFE),
          border: Border.all(width: 4, color: Color(0xff00568e)),
          borderRadius: BorderRadius.circular(10.0),
        ),
        //Espaçamento interno do card
        padding: EdgeInsets.all(10.0),
        child: Column(
          //Coluna para agrupar os objetos que serão chamado através da variável
          children: [
            Row(
              //Alinhamento dos objetos
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: widget.children,
            ),
          ],
        ),
      ),
    );
  }
}