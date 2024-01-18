import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  final String text;
  final List<Widget> children;

  const Navbar({Key? key, required this.text, required this.children})
      : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Color(0xff00568e),
        height: 70,
        //Stack usado para que os elementos se sobreponham e seus respectivos tamanhos não influenciem no alinhamento
        child: Stack(
          children: [
            //Chamando os elementos internos da NavBar (Buttons)
            Container(
              child: Row(
                children: widget.children,
              ),
            ),
            //Propriedade usada para fazer com que o texto ocupe todo o tamanho disponível do container
            Positioned.fill(
              child: Center(
                child: Text(
                  //Recebendo o texto que está sendo definido nas páginas em que a navbar está sendo chamada.
                  widget.text,
                  style: TextStyle(
                    //Estilização do texto.
                    color: Color(0xffffffff),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
