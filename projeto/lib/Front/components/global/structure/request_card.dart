import 'package:flutter/material.dart';
import 'package:projeto/front/components/Style.dart';

class RequestCard extends StatefulWidget {
  //Variável para permitir preencher o card com objetos externos
  final List<Widget> children;
  //Variável para definir o tamanho do card diretamente na página em que está sendo chamado

  const RequestCard({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Container(
            //Espaçamento entre o card e as bordas
            margin: EdgeInsets.only(right: 20.0, left: 20.0),
            //Estilização
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Style.primaryColor),
              borderRadius: BorderRadius.circular(10.0),
            ),
            //Espaçamento interno do card
            padding: EdgeInsets.all(10.0),
            child: Column(
              //Coluna para agrupar os objetos que serão chamado através da variável
              children: [
                Stack(
                  children: [
                    Row(
                      //Alinhamento dos objetos
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: widget.children,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
