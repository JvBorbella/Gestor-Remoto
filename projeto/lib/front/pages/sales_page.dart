import 'package:flutter/material.dart';
import 'package:projeto/Front/components/sales/elements/today_details.dart';
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

class SalesPage extends StatefulWidget {
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

  const SalesPage({
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
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  bool isLoading = true;

   @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         body: RefreshIndicator(
          onRefresh: () => _refreshData(),
          child: ListView(
            children: [
              //Código da Navbar
              Navbar(children: [
                //Chamando os elementos internos da navbar
                NavbarButton(
                  destination: HomePage(
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
              SalesCard(
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
                  Text('Ontem', style: TextStyle(
                    color: Style.quarantineColor,
                    fontSize: 18,
                  ),),
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
                  Text('Semana', style: TextStyle(
                    color: Style.quarantineColor,
                    fontSize: 18,
                  ),),
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
                  Text('Mês', style: TextStyle(
                    color: Style.quarantineColor,
                    fontSize: 18,
                  ),),
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
                  Text('Mês anterior', style: TextStyle(
                    color: Style.quarantineColor,
                    fontSize: 18,
                  ),),
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

 Future<void> loadData() async {
    // Utiliza Future.wait para buscar os dados de forma paralela
    await Future.wait([
      _refreshData()
    ]);
    // Todos os dados foram carregados, agora atualiza o estado para parar o carregamento
    setState(() {
      isLoading = false;
      // Verifica se os dados de solicitacoesremotas foram carregados corretamente
    });
  }


  Future<void> _refreshData() async {
    // Aqui você pode chamar os métodos para recarregar os dados
    // Exemplo: await loadData();
    setState(() {
      isLoading =
          true; // Define isLoading como true para mostrar o indicador de carregamento
          _SalesPageState();
    });
    await loadData();
    setState(() {
      isLoading =
          false; // Define isLoading como false para parar o indicador de carregamento
    });
  }

}
