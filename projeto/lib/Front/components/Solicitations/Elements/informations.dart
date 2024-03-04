import 'package:flutter/material.dart';
import 'package:projeto/Front/components/Style.dart';

class Informations extends StatefulWidget {
  final url;
  final token;
  final String usuarioLogin;
  final String empresaNome;
  final String imagem;
  final String urlBasic;

  const Informations({
    Key? key,
    this.token,
    this.url = '',
    required this.usuarioLogin,
    required this.empresaNome,
    required this.imagem,
    this.urlBasic = '',
  });

  @override
  State<Informations> createState() => _InformationsState();
}

class _InformationsState extends State<Informations> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        //Código dos elementos que ficam dentro do card na tela de solicitações
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    child: ClipOval(
                      child: widget.imagem.isNotEmpty
                          ? Image.network(
                              widget.urlBasic + widget.imagem,
                              fit: BoxFit.cover,
                            ) // Exibe a imagem
                          : CircularProgressIndicator(),
                    ),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border:
                            Border.all(width: 2, color: Style.primaryColor)),
                  ),
                ],
              ),
              SizedBox(
                width: 10, // Espaçamento entre a imagem e os outros elementos
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.usuarioLogin,
                    style: TextStyle(
                      color: Style.primaryColor,
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(widget.empresaNome,
                      style: TextStyle(
                        color: Style.primaryColor,
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
