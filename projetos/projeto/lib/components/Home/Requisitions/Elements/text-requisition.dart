import 'package:flutter/material.dart';
import 'package:projeto/components/Home/Requisitions/Elements/number-requisition.dart';

class TextRequisition extends StatefulWidget {
  const TextRequisition({Key? key}) : super(key: key);

  @override
  State<TextRequisition> createState() => _TextRequisitionState();
}

class _TextRequisitionState extends State<TextRequisition> {
  @override
  Widget build(BuildContext context) {
    //Variável para chamar o número de requisições definido em outro arquivo
    int numberOfRequisitions = NumberOfRequisitions().numberOfRequisitions;

    return Material(
      child: Container(
        child: Row(
          children: [
            //Caso o número de requisições seja 0, será exibida a mensagem:
            //"Não há nenhuma requisição no momento"
            if (numberOfRequisitions == 0)
              Text(
                'Não há nenhuma requisição no momento',
                style: TextStyle(
                  //Estilização
                  fontSize: 11,
                  color: Color(0xffA6A6A6),
                ),
              ),
            //Se for maior do que 0, a mensagem exibida será:
            //"Nova solicitação!"
            if (numberOfRequisitions > 0)
              Text(
                'Nova solicitação!',
                style: TextStyle(
                  //Estilização
                  fontSize: 13,
                  color: Color(0xff00568E),
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
