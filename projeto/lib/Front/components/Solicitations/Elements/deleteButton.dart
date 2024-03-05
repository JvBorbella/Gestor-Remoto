import 'package:flutter/material.dart';
import 'package:projeto/Back/Profiles-Requisitions.dart';
import 'package:projeto/Front/pages/home.dart';

class Delete extends StatefulWidget {
  final String token;
  final String url;
  final String liberacaoremotaId;

  const Delete(
      {Key? key,
      required this.token,
      required this.url,
      required this.liberacaoremotaId})
      : super(key: key);

  @override
  State<Delete> createState() => _DeleteState();
}

class _DeleteState extends State<Delete> {
  @override
  Widget build(BuildContext context) {
    return Material(
      //Código do button de excluir solicitação
      child: Container(
        child: Row(
          children: [
            Stack(
              children: [

              ],
            ),
            TextButton(
              //Função que está sendo executada ao clicar no button (Temporária)
              onPressed: () async {
                await RejectRequisition.rejectrequisition(
                  context,
                  widget.url,
                  widget.token,
                  widget.liberacaoremotaId,
                );
              },
              //Estilização
              child: Icon(
                Icons.delete, // Ícone padrão de três pontos
                color: const Color.fromARGB(255, 197, 28, 28), // Cor do ícone
              ),
            )
          ],
        ),
      ),
    );
  }
}
