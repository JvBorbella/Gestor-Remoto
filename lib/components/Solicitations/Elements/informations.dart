import 'package:flutter/material.dart';

class Informations extends StatefulWidget {
  const Informations({super.key});

  @override
  State<Informations> createState() => _InformationsState();
}

class _InformationsState extends State<Informations> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        //Código dos elementos que ficam dentro do card na tela de solicitações
        child: Row(
          //Alinhamento
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                //Imagem do usuário solicitante.
                Container(
                  child: ClipOval(
                    child: Image.network(
                      'https://cdn-icons-png.flaticon.com/512/4519/4519678.png',
                      width: 70,
                      height: 70,
                      color: Color(0xff00568e),
                      fit: BoxFit.cover,
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Color(0xff00568e)),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ],
            ),
            //Espaçamento lateral pros outros elementos.
            SizedBox(
              width: 10,
            ),
            //Alinhamento das informações do usuário
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('(Data)'),
                Text('(Empresa)'),
                Text('(Usuário)'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
