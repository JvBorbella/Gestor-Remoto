import 'package:flutter/material.dart';
import 'package:projeto/Front/components/sales/elements/today_details.dart';
import 'package:projeto/back/company_sales_monitor.dart';
import 'package:projeto/front/components/global/elements/navbar_button.dart';
import 'package:projeto/front/components/global/structure/navbar.dart';
import 'package:projeto/front/components/sales/elements/month_details.dart';
import 'package:projeto/front/components/sales/elements/prev_month_details.dart';
import 'package:projeto/front/components/sales/elements/prev_month_values.dart';
import 'package:projeto/front/components/sales/elements/today_values.dart';
import 'package:projeto/front/components/sales/elements/week_details.dart';
import 'package:projeto/front/components/sales/elements/month_values.dart';
import 'package:projeto/front/components/sales/elements/week_values.dart';
import 'package:projeto/front/components/sales/elements/yesterday_details.dart';
import 'package:projeto/front/components/sales/elements/yesterday_values.dart';
import 'package:projeto/front/components/sales/structure/sales_card.dart';
import 'package:projeto/front/components/Style.dart';
import 'package:projeto/front/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalesPage extends StatefulWidget {
  final String empresaNome;
  final double valorHoje;
  final double valorOntem;
  final double valorSemana;
  final double valorMes;
  final double valorMesAnt;
  // final String url;
  // final token;
  // final login;
  // final image;
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

  const SalesPage({
    Key? key,
    required this.empresaNome,
    // this.token,
    // this.login,
    // this.image,
    // this.url = '',
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
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  List<CompanySalesMonitor> empresasHoje = [];
  List<CompanySalesMonitor> empresasOntem = [];
  List<CompanySalesMonitor> empresasSemana = [];
  List<CompanySalesMonitor> empresasMes = [];
  List<CompanySalesMonitor> empresasMesAnt = [];

  String token = '';
  String url = '';
  String login = '';
  String image = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadSavedToken();
    _loadSavedLogin();
    _loadSavedImage();
    _loadSavedUrl();
  }

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
                NavbarButton(
                  destination: HomePage(
                    // url: widget.url,
                    // token: widget.token,
                    // login: widget.url,
                    // image: widget.image,
                    // token: widget.token,
                  ),
                  Icons: Icons.arrow_back_ios_new,
                ),
              ], text: 'Vendas'),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.empresaNome,
                style: TextStyle(color: Style.quarantineColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              //Widget do card dos números detalhados das vendas
              SalesCard(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  //Chamando elementos para dentro do card
                  Text(
                    'Hoje',
                    style: TextStyle(
                      color: Style.quarantineColor,
                      // fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: Style.ContentInternalSpace,
                  ),
                  //Widget dos valores
                  TodayValues(
                    valorHoje: widget.valorHoje,
                    valorcancelamentosHoje: widget.valorcancelamentosHoje,
                    cancelamentosHoje: widget.cancelamentosHoje.toInt(),
                    metaHoje: widget.metaHoje,
                  ),
                  SizedBox(
                    height: Style.ContentInternalSpace,
                  ),
                  //Widget dos valores adicionais - rodapé do card
                  TodayDetails(
                    ticketmedioHoje: widget.ticketmedioHoje,
                    margemHoje: widget.margemHoje,
                    ticketHoje: widget.ticketHoje,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SalesCard(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  //Chamando elementos para dentro do card
                  Text(
                    'Ontem',
                    style: TextStyle(
                      color: Style.quarantineColor,
                      // fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: Style.ContentInternalSpace,
                  ),
                  //Widget dos valores
                  YesterdayValues(
                    valorOntem: widget.valorOntem,
                    valorcancelamentosOntem: widget.valorcancelamentosOntem,
                    cancelamentosOntem: widget.cancelamentosOntem.toInt(),
                    metaOntem: widget.metaOntem,
                  ),
                  SizedBox(
                    height: Style.ContentInternalSpace,
                  ),
                  //Widget dos valores adicionais - rodapé do card
                  YesterdayDetails(
                    ticketOntem: widget.ticketOntem,
                    ticketmedioOntem: widget.ticketmedioOntem,
                    margemOntem: widget.margemOntem,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SalesCard(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  //Chamando elementos para dentro do card
                  Text(
                    'Semana',
                    style: TextStyle(
                      color: Style.quarantineColor,
                      // fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: Style.ContentInternalSpace,
                  ),
                  //Widget dos valores
                  WeekValues(
                    valorSemana: widget.valorSemana,
                    valorcancelamentosSemana: widget.valorcancelamentosSemana,
                    cancelamentosSemana: widget.cancelamentosSemana.toInt(),
                    metaSemana: widget.metaSemana,
                  ),
                  SizedBox(
                    height: Style.ContentInternalSpace,
                  ),
                  //Widget dos valores adicionais - rodapé do card
                  WeekDetails(
                    ticketSemana: widget.ticketSemana,
                    ticketmedioSemana: widget.ticketmedioSemana,
                    margemSemana: widget.margemSemana,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SalesCard(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  //Chamando elementos para dentro do card
                  Text(
                    'Mês',
                    style: TextStyle(
                      color: Style.quarantineColor,
                      // fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: Style.ContentInternalSpace,
                  ),
                  //Widget dos valores
                  MonthValues(
                    valorMes: widget.valorMes,
                    valorcancelamentosMes: widget.valorcancelamentosMes,
                    cancelamentosMes: widget.cancelamentosMes.toInt(),
                    metaMes: widget.metaMes,
                  ),
                  SizedBox(
                    height: Style.ContentInternalSpace,
                  ),
                  //Widget dos valores adicionais - rodapé do card
                  MonthDetails(
                    ticketMes: widget.ticketMes,
                    ticketmedioMes: widget.ticketmedioMes,
                    margemMes: widget.margemMes,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SalesCard(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  //Chamando elementos para dentro do card
                  Text(
                    'Mês anterior',
                    style: TextStyle(
                      color: Style.quarantineColor,
                      // fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: Style.ContentInternalSpace,
                  ),
                  //Widget dos valores
                  PrevMonthValues(
                    valorMesAnt: widget.valorMesAnt,
                    valorcancelamentosMesAnt: widget.valorcancelamentosMesAnt,
                    cancelamentosMesAnt: widget.cancelamentosMesAnt.toInt(),
                    metaMesAnt: widget.metaMesAnt,
                  ),
                  SizedBox(
                    height: Style.ContentInternalSpace,
                  ),
                  //Widget dos valores adicionais - rodapé do card
                  PrevMonthDetails(
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

   Future<void> _loadSavedUrl() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedUrl = await sharedPreferences.getString('url') ?? '';
    setState(() {
      url = savedUrl;
    });
  }

  Future<void> _loadSavedToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedToken = await sharedPreferences.getString('token') ?? '';
    setState(() {
      token = savedToken;
    });
  }

  Future<void> _loadSavedLogin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedLogin = await sharedPreferences.getString('login') ?? '';
    setState(() {
      login = savedLogin;
    });
  }

  Future<void> _loadSavedImage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedImage = await sharedPreferences.getString('image') ?? '';
    setState(() {
      image = savedImage;
    });
  }
}
