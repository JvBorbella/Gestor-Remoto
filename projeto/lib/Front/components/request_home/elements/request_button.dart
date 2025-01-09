import 'package:flutter/material.dart';
import 'package:projeto/front/components/style.dart';
import 'package:projeto/front/pages/request_page.dart';

class RequestButton extends StatefulWidget {
  //Variável para que seja definido o texto do button na página em que está sendo chamado
  final String text;
  final int solicitacoesremotas;
  final token;
  final String url;
  final String urlBasic;

  const RequestButton(
      {Key? key,
      required this.text,
      required this.solicitacoesremotas,
      this.token,
      this.url = '',
      this.urlBasic = '',
      })
      : super(key: key);

  @override
  State<RequestButton> createState() => _RequestButtonState();
}

class _RequestButtonState extends State<RequestButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: TextButton(
         onPressed: () {
                //Método para verificar se há requisições ou não.
                checkRequisitionsAndNavigate(context);
              },
        child: Container(
        decoration: BoxDecoration(
          //Estilização
          border: Border.all(width: Style.height_2(context), color: Color(0xff42B9F0)),
          borderRadius: BorderRadius.circular(Style.height_5(context)),
        ),
        //Conteúdo interno do button
        child: Column(
          //Alinhamento interno
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              //Função acionada ao ser clicado
              onPressed: () {
                //Método para verificar se há requisições ou não.
                checkRequisitionsAndNavigate(context);
              },
              //Texto retornado da página em que está sendo chamado o button
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
        //Tamanho e espaçamento
        width: Style.RequestButtonWidth(context),
        height: Style.RequestButtonHeight(context),
        padding: EdgeInsets.all(0),
      ),
        ) 
    );
  }

  //Método para verificar o número de requisições, caso seja 0, será exibida uma mensagem,
  //caso seja diferente de 0, o usuário será direcionado à outra página
  void checkRequisitionsAndNavigate(BuildContext context) {
    //chamando a váriável do widget onde está sendo definido o número de requisições
    int numberOfRequisitions = widget.solicitacoesremotas;

    //Verificação
    if (numberOfRequisitions == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          padding: EdgeInsets.all(Style.SaveUrlMessagePadding(context)),
          content: Text(
            'Não há nenhuma solicitação no momento!',
            style: TextStyle(
              fontSize: Style.SaveUrlMessageSize(context),
            ),
          ),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              RequestPage(url: widget.url, token: widget.token, urlBasic: widget.urlBasic),
        ),
      );
    }
  }
}
