import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatefulWidget {
  //Variável para definir o texto do input na página em que é chamado
  final String text;
  //Variável para definir o tipo do teclado qque será exibiso ao clicar no input, na página em que é chamado
  final TextInputType type;
  //Variável para definir se o texto passado no input será exibido ou ocultado, na página em que é chamado
  final obscureText;
  final controller;

  const Input(
      {Key? key, required this.text, required this.type, this.obscureText, this.controller})
      : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return Material(
      //ConstrainedBox usada para definir um tamanho máximo para o input
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
        child: Container(
          //Margem interna do input.
          margin: EdgeInsets.only(left: 5.0, right: 5),
          child: Column(
            //Alinhagem do input
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                //Configurações do input
                controller: widget.controller,
                keyboardType: widget.type,
                obscureText: widget.obscureText,
                cursorColor: Color(0xff00568e),
                decoration: InputDecoration(
                  labelText: widget.text,
                  labelStyle: TextStyle(
                    color: Color(0xffA6A6A6),
                    fontSize: 12,
                  ),
                  //Propriedade usada para fazer com que no Focus do input, o label seja alinhado ao centro.
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  //Borda do input
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff42b9f0)),
                  ),
                  //Borda do input no focus
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff42b9f0),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              //Espaçamento para elementos abaixo.
              SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
