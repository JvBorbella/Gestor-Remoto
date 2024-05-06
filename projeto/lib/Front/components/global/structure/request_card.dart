import 'package:flutter/material.dart';
import 'package:projeto/front/components/style.dart';

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
            margin: EdgeInsets.only(right: Style.height_20(context), left: Style.height_20(context)),
            //Estilização
            decoration: BoxDecoration(
              border: Border.all(width: Style.height_1(context), color: Style.primaryColor),
              borderRadius: BorderRadius.circular(Style.height_10(context)),
            ),
            //Espaçamento interno do card
            padding: EdgeInsets.all(Style.height_10(context)),
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
        ],
      ),
    );
  }
}
