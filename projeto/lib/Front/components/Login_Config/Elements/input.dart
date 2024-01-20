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
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Se um controlador foi fornecido, use-o; caso contrário, use o controlador interno.
    if (widget.controller != null) {
      _textController = widget.controller;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
        child: Container(
          margin: EdgeInsets.only(left: 5.0, right: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _textController,
                keyboardType: widget.type,
                obscureText: widget.obscureText ?? false, // Padrão para false se não for fornecido.
                cursorColor: Color(0xff00568e),
                decoration: InputDecoration(
                  labelText: widget.text,
                  labelStyle: TextStyle(
                    color: Color(0xffA6A6A6),
                    fontSize: 12,
                  ),
                  floatingLabelAlignment: FloatingLabelAlignment.center,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff42b9f0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff42b9f0),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Certifique-se de liberar o controlador ao destruir o widget.
    _textController.dispose();
    super.dispose();
  }
}
