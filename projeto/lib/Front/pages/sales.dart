import 'package:flutter/material.dart';
import 'package:projeto/back/company_sales_monitor.dart';
import 'package:projeto/front/components/global/elements/navbar_button.dart';
import 'package:projeto/front/components/global/structure/navbar.dart';
import 'package:projeto/front/components/sales/elements/details.dart';
import 'package:projeto/front/components/sales/elements/values.dart';
import 'package:projeto/front/components/sales/structure/sales_card.dart';
import 'package:projeto/front/components/Style.dart';
import 'package:projeto/front/pages/home.dart';

class SalesCard extends StatelessWidget {
  final String periodTitle;
  final List<MonitorVendasEmpresa>? salesData;

  SalesCard({required this.periodTitle, required this.salesData});

  @override
  Widget build(BuildContext context) {
    return CardSale(
      children: [
        Text(
          periodTitle,
          style: TextStyle(
            color: Style.quarantineColor,
            fontSize: 18,
          ),
        ),
        SizedBox(height: Style.ContentInternalSpace),
        if (salesData != null && salesData!.isNotEmpty)
          ...buildSalesWidgets(salesData!),
        if (salesData == null || salesData!.isEmpty)
          Text('Dados não disponíveis'),
      ],
    );
  }

  List<Widget> buildSalesWidgets(List<MonitorVendasEmpresa> salesData) {
    return [
      // Widget para exibir os valores de vendas
      Values(
        valortotal: salesData[0].valortotal,
        valorcancelamentos: salesData[0].valorcancelamentos,
        cancelamentos: salesData[0].cancelamentos.toInt(),
        meta: salesData[0].meta,
      ),
      // Widget para exibir os detalhes das vendas
      Details(
        ticketmedio: salesData[0].ticketmedio,
        margem: salesData[0].margem,
        ticket: salesData[0].ticket.toInt(),
      ),
      // Adicione widgets adicionais conforme necessário
    ];
  }
}

class Sales extends StatefulWidget {
  final String empresaNome;
  final String url;
  final token;
  final List<MonitorVendasEmpresa> empresasHoje;
  final List<MonitorVendasEmpresa> empresasOntem;
  final List<MonitorVendasEmpresa> empresasSemana;
  final List<MonitorVendasEmpresa> empresasMes;
  final List<MonitorVendasEmpresa> empresasMesAnt;

  const Sales({
    Key? key,
    required this.empresaNome,
    this.token,
    this.url = '',
    required this.empresasHoje,
    required this.empresasOntem,
    required this.empresasSemana,
    required this.empresasMes,
    required this.empresasMesAnt,
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
              Navbar(children: [
                ButtonNavbar(
                  destination: Home(
                    url: widget.url,
                    token: widget.token,
                  ),
                  Icons: Icons.arrow_back_ios_new,
                ),
              ], text: 'Vendas'),
              Text(
                widget.empresaNome,
                style: TextStyle(color: Style.quarantineColor, fontSize: 21),
                textAlign: TextAlign.center,
              ),
              SalesCard(periodTitle: 'Hoje', salesData: widget.empresasHoje),
              SalesCard(periodTitle: 'Ontem', salesData: widget.empresasOntem),
              SalesCard(periodTitle: 'Semana', salesData: widget.empresasSemana),
              SalesCard(periodTitle: 'Mês', salesData: widget.empresasMes),
              SalesCard(periodTitle: 'Mês anteriror',salesData: widget.empresasMesAnt),
              // Adicione para os outros períodos
            ],
          ),
        ),
      ),
    );
  }
}
