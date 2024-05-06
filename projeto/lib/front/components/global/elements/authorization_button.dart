import 'package:flutter/material.dart';
import 'package:projeto/front/components/style.dart';

class AuthorizationButton extends StatefulWidget {
  //Variável para definir o texto do button na página em que está sendo chamado
  final String text;
  //Variável para definir o destino ao clicar no button, na página em que está sendo chamado
  // final String liberacaoremotaId;
  // final String url;
  // final String token;
  // final String message;
  final onPressed;

  const AuthorizationButton(
      {Key? key,
      required this.text,
      // required this.liberacaoremotaId,
      // required this.url,
      // required this.token,
      // required this.message,
      this.onPressed})
      : super(key: key);

  @override
  State<AuthorizationButton> createState() => _AuthorizationButtonState();
}

class _AuthorizationButtonState extends State<AuthorizationButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        //Estilização do button
        decoration: BoxDecoration(
          border: Border.all(width: Style.WidthBorderImageContainer(context), color: Color(0xff42B9F0)),
          borderRadius: BorderRadius.circular(Style.BorderAuthorizationButtonCircular(context)),
        ),
        child: Column(
          //Alinhamento interno
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              //Função aplicada ao ser clicado
              onPressed: () {
                if (widget.onPressed != null) {
                  widget.onPressed();
                }
              },
              //Texto retornado, que foi definido na página em que o button está sendo chamado
              child: Text(
                widget.text,
                style: TextStyle(
                  color: Color(0xff42b9f0),
                  fontWeight: FontWeight.bold,
                  fontSize: Style.TextRequestButtonHeight(context),
                ),
              ),
            ),
          ],
        ),
        //Tamanho do button
        width: Style.RequestButtonWidth(context),
        height: Style.RequestButtonHeight(context),
        padding: EdgeInsets.all(0),
      ),
    );
  }
}
