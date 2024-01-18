import 'package:flutter/material.dart';

class FormCard extends StatefulWidget {
  //Variável para permitir que sejam inseridos outros elementos dentro do card.
  final List<Widget> children;

  const FormCard({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  State<FormCard> createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      //Código do form container.
      child: Column(
        children: [
          // Imagem usada nas telas de login e config.
          Image.network(
                'https://ideiatecnologia.com.br/wp-content/webp-express/webp-images/uploads/2023/11/imagem_2023-11-13_202733151.png.webp',
                color: Color(0xff00568e),
                height: 90,
              ),
              //Área do container com os widgets de form.
          Container(
            child: Column(
              children: widget.children,
            ),
            //Espaçamento interno do container.
            padding: EdgeInsets.only(left: 20, right: 20),
          ),
        ],
      ),
    );
  }
}
