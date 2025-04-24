import 'package:flutter/material.dart';
import 'package:project/front/components/style.dart';

class PrimaryCard extends StatefulWidget {
  //Variável para permitir preencher o card com objetos externos
  final List<Widget> children;
  //Variável para definir o tamanho do card diretamente na página em que está sendo chamado

  const PrimaryCard({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  State<PrimaryCard> createState() => _PrimaryCardState();
}

class _PrimaryCardState extends State<PrimaryCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Container(
            //Espaçamento entre o card e as bordas
            margin: EdgeInsets.only(
                right: Style.height_20(context),
                left: Style.height_20(context),
                bottom: Style.height_20(context)),
            //Estilização
            decoration: BoxDecoration(
              color: Style.primaryColor,
              border: Border.all(
                  width: Style.height_1(context), color: Style.primaryColor),
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
