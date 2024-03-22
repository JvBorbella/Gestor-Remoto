import 'package:flutter/material.dart';
import 'package:projeto/front/components/Global/Elements/navbar_button.dart';
import 'package:projeto/front/components/Global/Estructure/navbar.dart';
import 'package:projeto/front/components/Sales/Elements/details_today.dart';
import 'package:projeto/front/components/Sales/Elements/month_details.dart';
import 'package:projeto/front/components/Sales/Elements/week_details.dart';
import 'package:projeto/front/components/Sales/Elements/details_yesterday.dart';
import 'package:projeto/front/components/Sales/Elements/previous_month_details.dart';
import 'package:projeto/front/components/Sales/Elements/previous_month_values.dart';
import 'package:projeto/front/components/Sales/Elements/today_values.dart';
import 'package:projeto/front/components/Sales/Elements/month_values.dart';
import 'package:projeto/front/components/Sales/Elements/week_values.dart';
import 'package:projeto/front/components/Sales/Elements/yesterday_values.dart';
import 'package:projeto/front/components/Sales/Estructure/sales_card.dart';
import 'package:projeto/front/components/Style.dart';
import 'package:projeto/front/pages/home.dart';

class Sales extends StatefulWidget {
  final String empresaNome;
  final double valorHoje;
  final double valorOntem;
  final double valorSemana;
  final double valorMes;
  final double valorMesAnt;
  final String url;
  final token;
  final int ticketHoje;
  final int ticketOntem;
  final int ticketSemana;
  final int ticketMes;
  final int ticketMesAnt;
  final double cancelamentosHoje;
  final double cancelamentosOntem;
  final double cancelamentosSemana;
  final double cancelamentosMes;
  final double cancelamentosMesAnt;
  final double ticketmedioHoje;
  final double ticketmedioOntem;
  final double ticketmedioSemana;
  final double ticketmedioMes;
  final double ticketmedioMesAnt;
  final double margemHoje;
  final double margemOntem;
  final double margemSemana;
  final double margemMes;
  final double margemMesAnt;
  final double metaHoje;
  final double metaOntem;
  final double metaSemana;
  final double metaMes;
  final double metaMesAnt;
  final double valorcancelamentosHoje;
  final double valorcancelamentosOntem;
  final double valorcancelamentosSemana;
  final double valorcancelamentosMes;
  final double valorcancelamentosMesAnt;

  const Sales({
    Key? key,
    required this.empresaNome,
    this.token,
    this.url = '',
    required this.valorHoje,
    required this.valorOntem,
    required this.valorSemana,
    required this.valorMes,
    required this.valorMesAnt,
    required this.ticketHoje,
    required this.ticketOntem,
    required this.ticketSemana,
    required this.ticketMes,
    required this.ticketMesAnt,
    required this.cancelamentosHoje,
    required this.cancelamentosOntem,
    required this.cancelamentosSemana,
    required this.cancelamentosMes,
    required this.cancelamentosMesAnt,
    required this.ticketmedioHoje,
    required this.ticketmedioOntem,
    required this.ticketmedioSemana,
    required this.ticketmedioMes,
    required this.ticketmedioMesAnt,
    required this.margemHoje,
    required this.margemOntem,
    required this.margemSemana,
    required this.margemMes,
    required this.margemMesAnt,
    required this.metaHoje,
    required this.metaOntem,
    required this.metaSemana,
    required this.metaMes,
    required this.metaMesAnt,
    required this.valorcancelamentosHoje,
    required this.valorcancelamentosOntem,
    required this.valorcancelamentosSemana,
    required this.valorcancelamentosMes,
    required this.valorcancelamentosMesAnt,
  }) : super(key: key);

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: ListView(
            children: [
              //Código da Navbar
              Navbar(children: [
                //Chamando os elementos internos da navbar
                ButtonNavbar(
                  destination: Home(
                    url: widget.url,
                    token: widget.token,
                  ),
                  Icons: Icons.arrow_back_ios_new,
                ),
              ], text: 'Vendas'),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.empresaNome,
                style: TextStyle(fontSize: 22, color: Style.quarantineColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              //Widget do card dos números detalhados das vendas
              CardSale(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  //Chamando elementos para dentro do card
                  Text('Hoje', style: TextStyle(
                    color: Style.quarantineColor,
                    fontSize: 18,
                  ),),
                  SizedBox(
                    height: Style.ContentInternalSpace,
                  ),
                  //Widget dos valores
                  Values(
                    valorHoje: widget.valorHoje,
                    valorcancelamentosHoje: widget.valorcancelamentosHoje,
                    cancelamentosHoje: widget.cancelamentosHoje.toInt(),
                    metaHoje: widget.metaHoje,
                  ),
                  SizedBox(
                    height: Style.ContentInternalSpace,
                  ),
                  //Widget dos valores adicionais - rodapé do card
                  Details(
                    ticketmedioHoje: widget.ticketmedioHoje,
                    margemHoje: widget.margemHoje,
                    ticketHoje: widget.ticketHoje,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CardSale(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  //Chamando elementos para dentro do card
                  Text('Ontem', style: TextStyle(
                    color: Style.quarantineColor,
                    fontSize: 18,
                  ),),
                  SizedBox(
                    height: Style.ContentInternalSpace,
                  ),
                  //Widget dos valores
                  ValuesYesterday(
                    valorOntem: widget.valorOntem,
                    valorcancelamentosOntem: widget.valorcancelamentosOntem,
                    cancelamentosOntem: widget.cancelamentosOntem.toInt(),
                    metaOntem: widget.metaOntem,
                  ),
                  SizedBox(
                    height: Style.ContentInternalSpace,
                  ),
                  //Widget dos valores adicionais - rodapé do card
                  DetailsYesterday(
                    ticketOntem: widget.ticketOntem,
                    ticketmedioOntem: widget.ticketmedioOntem,
                    margemOntem: widget.margemOntem,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CardSale(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  //Chamando elementos para dentro do card
                  Text('Semana', style: TextStyle(
                    color: Style.quarantineColor,
                    fontSize: 18,
                  ),),
                  SizedBox(
                    height: Style.ContentInternalSpace,
                  ),
                  //Widget dos valores
                  ValuesWeek(
                    valorSemana: widget.valorSemana,
                    valorcancelamentosSemana: widget.valorcancelamentosSemana,
                    cancelamentosSemana: widget.cancelamentosSemana.toInt(),
                    metaSemana: widget.metaSemana,
                  ),
                  SizedBox(
                    height: Style.ContentInternalSpace,
                  ),
                  //Widget dos valores adicionais - rodapé do card
                  DetailsWeek(
                    ticketSemana: widget.ticketSemana,
                    ticketmedioSemana: widget.ticketmedioSemana,
                    margemSemana: widget.margemSemana,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CardSale(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  //Chamando elementos para dentro do card
                  Text('Mês', style: TextStyle(
                    color: Style.quarantineColor,
                    fontSize: 18,
                  ),),
                  SizedBox(
                    height: Style.ContentInternalSpace,
                  ),
                  //Widget dos valores
                  ValuesMonth(
                    valorMes: widget.valorMes,
                    valorcancelamentosMes: widget.valorcancelamentosMes,
                    cancelamentosMes: widget.cancelamentosMes.toInt(),
                    metaMes: widget.metaMes,
                  ),
                  SizedBox(
                    height: Style.ContentInternalSpace,
                  ),
                  //Widget dos valores adicionais - rodapé do card
                  DetailsMonth(
                    ticketMes: widget.ticketMes,
                    ticketmedioMes: widget.ticketmedioMes,
                    margemMes: widget.margemMes,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CardSale(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  //Chamando elementos para dentro do card
                  Text('Mês anterior', style: TextStyle(
                    color: Style.quarantineColor,
                    fontSize: 18,
                  ),),
                  SizedBox(
                    height: Style.ContentInternalSpace,
                  ),
                  //Widget dos valores
                  PreviousValuesMonth(
                    valorMesAnt: widget.valorMesAnt,
                    valorcancelamentosMesAnt: widget.valorcancelamentosMesAnt,
                    cancelamentosMesAnt: widget.cancelamentosMesAnt.toInt(),
                    metaMesAnt: widget.metaMesAnt,
                  ),
                  SizedBox(
                    height: Style.ContentInternalSpace,
                  ),
                  //Widget dos valores adicionais - rodapé do card
                  PreviousDetailsMonth(
                    ticketMesAnt: widget.ticketMesAnt,
                    ticketmedioMesAnt: widget.ticketmedioMesAnt,
                    margemMesAnt: widget.margemMesAnt,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
