import 'package:flutter/material.dart';
import 'package:projeto/front/components/Style.dart';

class ActionButton extends StatefulWidget {
  //Variável para definir o texto do button na página em que é chamado
  final String text;
  //Variável para definir o destino ao clicar no button na página em que é chamado
  final onPressed;
  //Variável para definir o tamanho do button na página em que é chamado
  final double height;

  const ActionButton(
      {Key? key, 
      required this.text,
      this.onPressed,
      required this.height,
      })
      : super(key: key);

  @override
  State<ActionButton> createState() => _ActionButton();
}

class _ActionButton extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        //Alinhamento do button
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            //Redirecionamento executado ao clicar no button. Definido na página em que o button está sendo chamado.
            onPressed: () {
              if (widget.onPressed != null) {
                widget.onPressed();
              }
            },
            child: Text(
              //Texto do button está sendo definido na página em que está sendo chamado.
              widget.text,
              //Estilização do button
              style: TextStyle(
                color: Style.secondaryColor,
                fontWeight: FontWeight.bold,
                fontSize: widget.height,
              ),
            ),
          ),
          //Espaçamento para o bottom.
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
