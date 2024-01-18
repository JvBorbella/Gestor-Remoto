import 'package:flutter/material.dart';
import 'package:projeto/Front/pages/home.dart';

class Delete extends StatefulWidget {
  const Delete({super.key});

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
          //Alinhamento do button
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextButton(
              //Função que está sendo executada ao clicar no button (Temporária)
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Home()),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      'Solicitação excluída!',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ),
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
        //Tamanho do container que armazena o button.
        width: MediaQuery.of(context).size.width * 0.3,
      ),
    );
  }
}
