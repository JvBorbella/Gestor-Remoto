import 'package:flutter/material.dart';
import 'package:projeto/components/Global/Elements/Navbar-Button.dart';
import 'package:projeto/components/Global/Elements/liberation-button.dart';
import 'package:projeto/components/Solicitations/Elements/Text-Solicitacion.dart';
import 'package:projeto/components/Solicitations/Elements/deleteButton.dart';
import 'package:projeto/components/Solicitations/Elements/informations.dart';
import 'package:projeto/components/Global/Estructure/navbar.dart';
import 'package:projeto/components/Global/Estructure/requisition-card.dart';
import 'package:projeto/pages/home.dart';

class Solicitacion extends StatefulWidget {
  const Solicitacion({Key? key});

  @override
  State<Solicitacion> createState() => _SolicitacionState();
}

class _SolicitacionState extends State<Solicitacion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            //Chamando a navbar e os elementos internos dela.
           Navbar(children: [
              //Chamando os elementos internos da navbar
              ButtonNavbar(
                  destination: Home(),
                  Icons: Icons.arrow_back_ios_new,
                ),
            ], text: 'Solicitações'),
            SizedBox(
              height: 10,
            ),
            // Spacer para preencher o espaço entre Navbar e RequisitionCard
            Spacer(),
            //Chamando o card que receberá as informações do usuário
            RequisitionCard(
              children: [
                Container(
                  //Propriedade Expanded adicionada dentro do card para fazer com que os elementos se distribuam conforme a largura do mesmo.
                  child: Expanded(
                    child: Column(
                      //Alinhamento interno
                      
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Chamando os elementos para dentro do card
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Chamando o código que armazenará as informações do usuário
                            Informations(),
                            Delete()
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //Chamando o texto referente à solicitação
                        Row(
                          //Alinhamento
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //Propriedade Expanded para que seja realizada a quebra de texto 
                            Expanded(
                              child: TextSolicitacion(
                                text:
                                    '(Pequeno resumo referente à solicitação feita pelo usuário.)',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        //Chamando o button de autorização
                        Row(
                          //Alinhamento
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Button para autorizar requisição
                            LiberationButtom(
                              text: 'Autorizar',
                              destination: Home(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
