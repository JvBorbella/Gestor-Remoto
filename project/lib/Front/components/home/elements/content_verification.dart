import 'package:flutter/material.dart';
import 'package:project/back/sales_info_functions/company_sales_monitor.dart';
import 'package:project/front/components/home/elements/branch_card_content.dart';
import 'package:project/front/components/home/elements/company_name_button.dart';
import 'package:project/front/components/home/structure/branch_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContentVerification extends StatefulWidget {
  const ContentVerification({
    Key? key,
    this.empresasHoje,
    this.empresasOntem,
    this.empresasSemana,
    this.empresasMes,
    this.empresasMesAnt,
  });

  final empresasHoje;
  final empresasMes;
  final empresasMesAnt;
  final empresasOntem;
  final empresasSemana;

  @override
  State<ContentVerification> createState() => _ContentVerificationState();
}

class _ContentVerificationState extends State<ContentVerification> {
  String token = '';
  String url = '';

  @override
  void initState() {
    super.initState();
    _loadSavedUrl();
    _loadSavedToken();
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

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.empresasHoje.isNotEmpty
                ? widget.empresasHoje.length
                : widget.empresasMes.length,
            itemBuilder: (context, index) {
              final empresaHoje = _getEmpresa(widget.empresasHoje, index);
              final empresaOntem = _getEmpresa(widget.empresasOntem, index);
              final empresaSemana = _getEmpresa(widget.empresasSemana, index);
              final empresaMes = _getEmpresa(widget.empresasMes, index);
              final empresaMesAnt = _getEmpresa(widget.empresasMesAnt, index);

              return Column(
                children: [
                  BranchCard(
                    children: [
                      Column(
                        children: [
                          CompanyNameButton(
                            empresaNome: empresaHoje.empresaNome,
                            valorHoje: empresaHoje.valortotal,
                            ticketHoje: empresaHoje.ticket.toInt(),
                            valorcancelamentosHoje: empresaHoje.valorcancelamentos,
                            cancelamentosHoje: empresaHoje.cancelamentos,
                            ticketmedioHoje: empresaHoje.ticketmedio,
                            margemHoje: empresaHoje.margem,
                            metaHoje: empresaHoje.meta,
                            valorOntem: empresaOntem.valortotal,
                            ticketOntem: empresaOntem.ticket.toInt(),
                            valorcancelamentosOntem: empresaOntem.valorcancelamentos,
                            cancelamentosOntem: empresaOntem.cancelamentos,
                            ticketmedioOntem: empresaOntem.ticketmedio,
                            margemOntem: empresaOntem.margem,
                            metaOntem: empresaOntem.meta,
                            valorSemana: empresaSemana.valortotal,
                            ticketSemana: empresaSemana.ticket.toInt(),
                            valorcancelamentosSemana: empresaSemana.valorcancelamentos,
                            cancelamentosSemana: empresaSemana.cancelamentos,
                            ticketmedioSemana: empresaSemana.ticketmedio,
                            margemSemana: empresaSemana.margem,
                            metaSemana: empresaSemana.meta,
                            valorMes: empresaMes.valortotal,
                            ticketMes: empresaMes.ticket.toInt(),
                            valorcancelamentosMes: empresaMes.valorcancelamentos,
                            cancelamentosMes: empresaMes.cancelamentos,
                            ticketmedioMes: empresaMes.ticketmedio,
                            margemMes: empresaMes.margem,
                            metaMes: empresaMes.meta,
                            valorMesAnt: empresaMesAnt.valortotal,
                            ticketMesAnt: empresaMesAnt.ticket.toInt(),
                            valorcancelamentosMesAnt: empresaMesAnt.valorcancelamentos,
                            cancelamentosMesAnt: empresaMesAnt.cancelamentos,
                            ticketmedioMesAnt: empresaMesAnt.ticketmedio,
                            margemMesAnt: empresaMesAnt.margem,
                            metaMesAnt: empresaMesAnt.meta,
                          ),
                          BranchCardContent(
                            valorHoje: empresaHoje.valortotal,
                            valorOntem: empresaOntem.valortotal,
                            valorSemana: empresaSemana.valortotal,
                            valorMes: empresaMes.valortotal,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

// Método para garantir que sempre haja um objeto válido
  dynamic _getEmpresa(List<dynamic> lista, int index) {
    if (lista.isNotEmpty && index < lista.length) {
      return lista[index];
    }
    return _empresaVazia(); // Retorna um objeto com valores zerados
  }

// Objeto padrão para quando a lista estiver vazia
  dynamic _empresaVazia() {
    return CompanySalesMonitor(
      empresaNome: 'Sem dados',
      valortotal: 0.0,
      ticket: 0,
      valorcancelamentos: 0.0,
      cancelamentos: 0,
      ticketmedio: 0.0,
      margem: 0.0,
      meta: 0.0,
    );
  }
}
