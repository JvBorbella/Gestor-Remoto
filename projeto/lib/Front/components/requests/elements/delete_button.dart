import 'package:flutter/material.dart';
import 'package:projeto/front/components/style.dart';

class DeleteButton extends StatefulWidget {
  final onPressed;

  const DeleteButton({
    Key? key,

    this.onPressed,
  }) : super(key: key);

  @override
  State<DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      //Código do button de excluir solicitação
      child: Container(
        child: Row(
          children: [
            TextButton(
              //Função que está sendo executada ao clicar no button (Temporária)
              onPressed: () {
                if (widget.onPressed != null) {
                  widget.onPressed();
                }
              },
              //Estilização
              child: Icon(
                Icons.delete, // Ícone padrão de três pontos
                color: const Color.fromARGB(255, 197, 28, 28), // Cor do ícone
                size: Style.DeleteButtonSize(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
