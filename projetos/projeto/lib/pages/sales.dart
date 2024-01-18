import 'package:flutter/material.dart';
import 'package:projeto/components/Global/Elements/Navbar-Button.dart';
import 'package:projeto/components/Global/Estructure/navbar.dart';
import 'package:projeto/components/Sales/Elements/Details.dart';
import 'package:projeto/components/Sales/Elements/values.dart';
import 'package:projeto/components/Sales/Estructure/Card-Sales.dart';
import 'package:projeto/pages/home.dart';

class Sales extends StatefulWidget {
  const Sales({super.key});

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            //Código da Navbar
            Navbar(children: [
              //Chamando os elementos internos da navbar
              ButtonNavbar(
                  destination: Home(),
                  Icons: Icons.arrow_back_ios_new,
                ),
            ], text: 'Vendas'),
            //Widget do card dos números detalhados das vendas
            CardSale(
              children: [
                //Chamando elementos para dentro do card
                Text(
                  '(Empresa)',
                  style: TextStyle(fontSize: 26, color: Color(0xffA6A6A6)),
                ),
                SizedBox(
                  height: 10,
                ),
                //Widget dos valores
                Values(),
                SizedBox(
                  height: 10,
                ),
                //Widget dos valores adicionais - rodapé do card
                Details(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
