import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto/Front/components/global/structure/navbar.dart';
import 'package:projeto/back/company_sales_monitor.dart';
import 'package:projeto/back/sales_monitor.dart';
import 'package:projeto/front/components/global/structure/request_card.dart';
import 'package:projeto/front/components/home/elements/branch_card_content.dart';
import 'package:projeto/front/components/home/elements/company_name_button.dart';
import 'package:projeto/front/components/home/elements/drawer_button.dart';

// import 'package:projeto/front/components/home/elements/modal_button.dart';
import 'package:projeto/front/components/home/structure/branch_card.dart';
import 'package:projeto/front/components/home/structure/total_values_card.dart';
import 'package:projeto/front/components/request_home/elements/number_of_requests.dart';
import 'package:projeto/front/components/request_home/elements/request_button.dart';
import 'package:projeto/front/components/request_home/structure/conditional_text_card_requests.dart';
import 'package:projeto/front/components/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {

  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String urlController = '';
  List<CompanySalesMonitor> empresasHoje = [];
  List<CompanySalesMonitor> empresasOntem = [];
  List<CompanySalesMonitor> empresasSemana = [];
  List<CompanySalesMonitor> empresasMes = [];
  List<CompanySalesMonitor> empresasMesAnt = [];
  late double vendadia = 0.0;
  late double vendadiaanterior = 0.0;
  late double vendasemana = 0.0;
  late double vendames = 0.0;
  late int solicitacoesremotas = -1;
  // Valor padrão de carregamento
  bool isLoading = true;
  NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');

  String token = '';
  String login = '';
  String image = '';
  String url = '';
  String urlBasic = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadSavedUrl();
    _loadSavedToken();
    _loadSavedLogin();
    _loadSavedImage(); 
    _loadSavedUrlBasic();
    _loadSavedEmail();
    loadData();
    fetchDataWeek();
    fetchDataMonth();
    fetchDataPrevMonth();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadSavedUrl();
    _loadSavedToken();
    _loadSavedLogin();
    _loadSavedImage();
    _loadSavedUrlBasic();
    _loadSavedEmail();
  }

   void _closeModal() {
      //Função para fechar o modal
      Navigator.of(context).pop();
    }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: CustomDrawer(),
          width: MediaQuery.of(context).size.width * 0.9,
        ),
        body: RefreshIndicator(
          onRefresh: () => _refreshData(),
          child: ListView(
            children: [
              Navbar(
                children: [
                  DrawerButton(
                    style: ButtonStyle(
                        iconColor:
                            MaterialStatePropertyAll(Style.tertiaryColor),
                        padding: MaterialStatePropertyAll(EdgeInsets.all(12))),
                  ),
                  // ModalButton(),
                ],
                text: 'Página inicial',
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Total de hoje',
                              style: TextStyle(
                                color: Style.primaryColor,
                                // fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            TotalValuesCard(
                              text: '',
                              children: vendadia,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Total de ontem',
                              style: TextStyle(
                                color: Style.primaryColor,
                                // fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            TotalValuesCard(
                              text: '',
                              children: vendadiaanterior,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Total da semana',
                              style: TextStyle(
                                color: Style.primaryColor,
                                // fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            TotalValuesCard(
                              text: '',
                              children: vendasemana,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Total do mês',
                              style: TextStyle(
                                color: Style.primaryColor,
                                // fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            TotalValuesCard(
                              text: '',
                              children: vendames,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              RequestCard(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 2,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: solicitacoesremotas <= 0
                                    ? EdgeInsets.only(left: 30)
                                    : EdgeInsets.all(0),
                              ),
                              Text(
                                'Requisições',
                                style: TextStyle(
                                    color: Style.primaryColor,
                                    // fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              NumberOfRequests(
                                  solicitacoesremotas: solicitacoesremotas),
                            ],
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Row(
                            children: [
                              ConditionalTextCardRequests(
                                solicitacoesremotas: solicitacoesremotas,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RequestButton(
                                text: 'Liberação remota',
                                solicitacoesremotas: solicitacoesremotas,
                                url: url,
                                token: token,
                                urlBasic: urlBasic,
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: empresasHoje.length,
                itemBuilder: (context, index) {
                  // Verifica se empresasOntem possui elementos antes de acessá-los
                  if (index < empresasOntem.length) {
                    return Column(
                      children: [
                        BranchCard(
                          children: [
                            Column(
                              children: [
                                if (empresasSemana.isNotEmpty &&
                                    empresasMes.isNotEmpty)
                                  CompanyNameButton(
                                    // url: url,
                                    // token: token,
                                    // login: widget.login,
                                    // image: widget.image,
                                    empresaNome: empresasHoje[index].empresaNome,
                                    valorHoje: empresasHoje[index].valortotal,
                                    ticketHoje: empresasHoje[index].ticket.toInt(),
                                    valorcancelamentosHoje: empresasHoje[index].valorcancelamentos,
                                    cancelamentosHoje: empresasHoje[index].cancelamentos,
                                    ticketmedioHoje: empresasHoje[index].ticketmedio,
                                    margemHoje: empresasHoje[index].margem,
                                    metaHoje: empresasHoje[index].meta,
                                    valorOntem: empresasOntem[index].valortotal,
                                    ticketOntem: empresasOntem[index].ticket.toInt(),
                                    valorcancelamentosOntem: empresasOntem[index].valorcancelamentos,
                                    cancelamentosOntem: empresasOntem[index].cancelamentos,
                                    ticketmedioOntem: empresasOntem[index].ticketmedio,
                                    margemOntem: empresasOntem[index].margem,
                                    metaOntem: empresasOntem[index].meta,
                                    valorSemana: empresasSemana[index].valortotal,
                                    ticketSemana: empresasSemana[index].ticket.toInt(),
                                    valorcancelamentosSemana: empresasSemana[index].valorcancelamentos,
                                    cancelamentosSemana: empresasSemana[index].cancelamentos,
                                    ticketmedioSemana: empresasSemana[index].ticketmedio,
                                    margemSemana: empresasSemana[index].margem,
                                    metaSemana: empresasSemana[index].meta,
                                    valorMes: empresasMes[index].valortotal,
                                    ticketMes: empresasMes[index].ticket.toInt(),
                                    valorcancelamentosMes: empresasMes[index].valorcancelamentos,
                                    cancelamentosMes: empresasMes[index].cancelamentos,
                                    ticketmedioMes: empresasMes[index].ticketmedio,
                                    margemMes: empresasMes[index].margem,
                                    metaMes: empresasMes[index].meta,
                                    valorMesAnt: empresasMesAnt[index].valortotal,
                                    ticketMesAnt: empresasMesAnt[index].ticket.toInt(),
                                    valorcancelamentosMesAnt: empresasMesAnt[index].valorcancelamentos,
                                    cancelamentosMesAnt: empresasMesAnt[index].cancelamentos,
                                    ticketmedioMesAnt:empresasMesAnt[index].ticketmedio,
                                    margemMesAnt: empresasMesAnt[index].margem,
                                    metaMesAnt: empresasMesAnt[index].meta,
                                  )
                                else if (empresasMes.isNotEmpty)
                                  CompanyNameButton(
                                    // url: url,
                                    // token: token,
                                    // login: widget.login,
                                    // image: widget.image,
                                    empresaNome: empresasHoje[index].empresaNome,
                                    valorHoje: empresasHoje[index].valortotal,
                                    ticketHoje: empresasHoje[index].ticket.toInt(),
                                    valorcancelamentosHoje: empresasHoje[index].valorcancelamentos,
                                    cancelamentosHoje: empresasHoje[index].cancelamentos,
                                    ticketmedioHoje: empresasHoje[index].ticketmedio,
                                    margemHoje: empresasHoje[index].margem,
                                    metaHoje: empresasHoje[index].meta,
                                    valorOntem: empresasOntem[index].valortotal,
                                    ticketOntem: empresasOntem[index].ticket.toInt(),
                                    valorcancelamentosOntem: empresasOntem[index].valorcancelamentos,
                                    cancelamentosOntem: empresasOntem[index].cancelamentos,
                                    ticketmedioOntem: empresasOntem[index].ticketmedio,
                                    margemOntem: empresasOntem[index].margem,
                                    metaOntem: empresasOntem[index].meta,
                                    valorSemana: 0,
                                    ticketSemana: 0,
                                    valorcancelamentosSemana: 0,
                                    cancelamentosSemana: 0,
                                    ticketmedioSemana: 0,
                                    margemSemana: 0,
                                    metaSemana: 0,
                                    valorMes: empresasMes[index].valortotal,
                                    ticketMes: empresasMes[index].ticket.toInt(),
                                    valorcancelamentosMes: empresasMes[index].valorcancelamentos,
                                    cancelamentosMes: empresasMes[index].cancelamentos,
                                    ticketmedioMes: empresasMes[index].ticketmedio,
                                    margemMes: empresasMes[index].margem,
                                    metaMes: empresasMes[index].meta,
                                    valorMesAnt: empresasMesAnt[index].valortotal,
                                    ticketMesAnt: empresasMesAnt[index].ticket.toInt(),
                                    valorcancelamentosMesAnt: empresasMesAnt[index].valorcancelamentos,
                                    cancelamentosMesAnt: empresasMesAnt[index].cancelamentos,
                                    ticketmedioMesAnt: empresasMesAnt[index].ticketmedio,
                                    margemMesAnt: empresasMesAnt[index].margem,
                                    metaMesAnt: empresasMesAnt[index].meta,
                                  )
                                else if (empresasSemana.isNotEmpty)
                                  CompanyNameButton(
                                    // url: url,
                                    // token: token,
                                    // login: widget.login,
                                    // image: widget.image,
                                    empresaNome: empresasHoje[index].empresaNome,
                                    valorHoje: empresasHoje[index].valortotal,
                                    ticketHoje: empresasHoje[index].ticket.toInt(),
                                    valorcancelamentosHoje: empresasHoje[index].valorcancelamentos,
                                    cancelamentosHoje: empresasHoje[index].cancelamentos,
                                    ticketmedioHoje: empresasHoje[index].ticketmedio,
                                    margemHoje: empresasHoje[index].margem,
                                    metaHoje: empresasHoje[index].meta,
                                    valorOntem: empresasOntem[index].valortotal,
                                    ticketOntem: empresasOntem[index].ticket.toInt(),
                                    valorcancelamentosOntem: empresasOntem[index].valorcancelamentos,
                                    cancelamentosOntem: empresasOntem[index].cancelamentos,
                                    ticketmedioOntem: empresasOntem[index].ticketmedio,
                                    margemOntem: empresasOntem[index].margem,
                                    metaOntem: empresasOntem[index].meta,
                                    valorSemana: empresasSemana[index].valortotal,
                                    ticketSemana: empresasSemana[index].ticket.toInt(),
                                    valorcancelamentosSemana: empresasSemana[index].valorcancelamentos,
                                    cancelamentosSemana: empresasSemana[index].cancelamentos,
                                    ticketmedioSemana: empresasSemana[index].ticketmedio,
                                    margemSemana: empresasSemana[index].margem,
                                    metaSemana: empresasSemana[index].meta,
                                    valorMes: 0,
                                    ticketMes: 0,
                                    valorcancelamentosMes: 0,
                                    cancelamentosMes: 0,
                                    ticketmedioMes: 0,
                                    margemMes: 0,
                                    metaMes: 0,
                                    valorMesAnt: empresasMesAnt[index].valortotal,
                                    ticketMesAnt: empresasMesAnt[index].ticket.toInt(),
                                    valorcancelamentosMesAnt: empresasMesAnt[index].valorcancelamentos,
                                    cancelamentosMesAnt: empresasMesAnt[index].cancelamentos,
                                    ticketmedioMesAnt: empresasMesAnt[index].ticketmedio,
                                    margemMesAnt: empresasMesAnt[index].margem,
                                    metaMesAnt: empresasMesAnt[index].meta,
                                  )
                                else
                                  CompanyNameButton(
                                    // url: url,
                                    // token: token,
                                    // login: widget.login,
                                    // image: widget.image,
                                    empresaNome: empresasHoje[index].empresaNome,
                                    valorHoje: empresasHoje[index].valortotal,
                                    ticketHoje: empresasHoje[index].ticket.toInt(),
                                    valorcancelamentosHoje: empresasHoje[index].valorcancelamentos,
                                    cancelamentosHoje: empresasHoje[index].cancelamentos,
                                    ticketmedioHoje: empresasHoje[index].ticketmedio,
                                    margemHoje: empresasHoje[index].margem,
                                    metaHoje: empresasHoje[index].meta,
                                    valorOntem: empresasOntem[index].valortotal,
                                    ticketOntem: empresasOntem[index].ticket.toInt(),
                                    valorcancelamentosOntem: empresasOntem[index].valorcancelamentos,
                                    cancelamentosOntem: empresasOntem[index].cancelamentos,
                                    ticketmedioOntem: empresasOntem[index].ticketmedio,
                                    margemOntem: empresasOntem[index].margem,
                                    metaOntem: empresasOntem[index].meta,
                                    valorSemana: 0,
                                    ticketSemana: 0,
                                    valorcancelamentosSemana: 0,
                                    cancelamentosSemana: 0,
                                    ticketmedioSemana: 0,
                                    margemSemana: 0,
                                    metaSemana: 0,
                                    valorMes: 0,
                                    ticketMes: 0,
                                    valorcancelamentosMes: 0,
                                    cancelamentosMes: 0,
                                    ticketmedioMes: 0,
                                    margemMes: 0,
                                    metaMes: 0,
                                    valorMesAnt: empresasMesAnt[index].valortotal,
                                    ticketMesAnt: empresasMesAnt[index].ticket.toInt(),
                                    valorcancelamentosMesAnt: empresasMesAnt[index].valorcancelamentos,
                                    cancelamentosMesAnt: empresasMesAnt[index].cancelamentos,
                                    ticketmedioMesAnt: empresasMesAnt[index].ticketmedio,
                                    margemMesAnt: empresasMesAnt[index].margem,
                                    metaMesAnt: empresasMesAnt[index].meta,
                                  ),
                                if (empresasSemana.isNotEmpty &&
                                    empresasMes.isNotEmpty)
                                  BranchCardContent(
                                    valorHoje: empresasHoje[index].valortotal,
                                    valorOntem: empresasOntem[index].valortotal,
                                    valorSemana: empresasSemana[index].valortotal,
                                    valorMes: empresasMes[index].valortotal,
                                  )
                                else if (empresasMes.isNotEmpty)
                                  BranchCardContent(
                                    valorHoje: empresasHoje[index].valortotal,
                                    valorOntem: empresasOntem[index].valortotal,
                                    valorSemana: 0,
                                    valorMes: empresasMes[index].valortotal,
                                  )
                                else if (empresasSemana.isNotEmpty)
                                  BranchCardContent(
                                    valorHoje: empresasHoje[index].valortotal,
                                    valorOntem: empresasOntem[index].valortotal,
                                    valorSemana: empresasSemana[index].valortotal,
                                    valorMes: 0,
                                  )
                                else
                                  BranchCardContent(
                                    valorHoje: empresasHoje[index].valortotal,
                                    valorOntem: empresasOntem[index].valortotal,
                                    valorSemana: 0,
                                    valorMes: 0,
                                  )
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        BranchCard(
                          children: [
                            Column(
                              children: [
                                if (empresasSemana.isNotEmpty &&
                                    empresasMes.isNotEmpty)
                                  CompanyNameButton(
                                    // url: url,
                                    // token: token,
                                    // login: widget.login,
                                    // image: widget.image,
                                    empresaNome: empresasHoje[index].empresaNome,
                                    valorHoje: empresasHoje[index].valortotal,
                                    ticketHoje: empresasHoje[index].ticket.toInt(),
                                    valorcancelamentosHoje: empresasHoje[index].valorcancelamentos,
                                    cancelamentosHoje: empresasHoje[index].cancelamentos,
                                    ticketmedioHoje: empresasHoje[index].ticketmedio,
                                    margemHoje: empresasHoje[index].margem,
                                    metaHoje: empresasHoje[index].meta,
                                    valorOntem: 0,
                                    ticketOntem: 0,
                                    valorcancelamentosOntem: 0,
                                    cancelamentosOntem: 0,
                                    ticketmedioOntem: 0,
                                    margemOntem: 0,
                                    metaOntem: 0,
                                    valorSemana: empresasSemana[index].valortotal,
                                    ticketSemana: empresasSemana[index].ticket.toInt(),
                                    valorcancelamentosSemana: empresasSemana[index].valorcancelamentos,
                                    cancelamentosSemana: empresasSemana[index].cancelamentos,
                                    ticketmedioSemana: empresasSemana[index].ticketmedio,
                                    margemSemana: empresasSemana[index].margem,
                                    metaSemana: empresasSemana[index].meta,
                                    valorMes: empresasMes[index].valortotal,
                                    ticketMes: empresasMes[index].ticket.toInt(),
                                    valorcancelamentosMes: empresasMes[index].valorcancelamentos,
                                    cancelamentosMes: empresasMes[index].cancelamentos,
                                    ticketmedioMes: empresasMes[index].ticketmedio,
                                    margemMes: empresasMes[index].margem,
                                    metaMes: empresasMes[index].meta,
                                    valorMesAnt: empresasMesAnt[index].valortotal,
                                    ticketMesAnt: empresasMesAnt[index].ticket.toInt(),
                                    valorcancelamentosMesAnt: empresasMesAnt[index].valorcancelamentos,
                                    cancelamentosMesAnt: empresasMesAnt[index].cancelamentos,
                                    ticketmedioMesAnt: empresasMesAnt[index].ticketmedio,
                                    margemMesAnt: empresasMesAnt[index].margem,
                                    metaMesAnt: empresasMesAnt[index].meta,
                                  )
                                else
                                  CompanyNameButton(
                                    // url: url,
                                    // token: token,
                                    // login: widget.login,
                                    // image: widget.image,
                                    empresaNome: empresasHoje[index].empresaNome,
                                    valorHoje: empresasHoje[index].valortotal,
                                    ticketHoje: empresasHoje[index].ticket.toInt(),
                                    valorcancelamentosHoje: empresasHoje[index].valorcancelamentos,
                                    cancelamentosHoje: empresasHoje[index].cancelamentos,
                                    ticketmedioHoje: empresasHoje[index].ticketmedio,
                                    margemHoje: empresasHoje[index].margem,
                                    metaHoje: empresasHoje[index].meta,
                                    valorOntem: 0,
                                    ticketOntem: 0,
                                    valorcancelamentosOntem: 0,
                                    cancelamentosOntem: 0,
                                    ticketmedioOntem: 0,
                                    margemOntem: 0,
                                    metaOntem: 0,
                                    valorSemana: 0,
                                    ticketSemana: 0,
                                    valorcancelamentosSemana: 0,
                                    cancelamentosSemana: 0,
                                    ticketmedioSemana: 0,
                                    margemSemana: 0,
                                    metaSemana: 0,
                                    valorMes: 0,
                                    ticketMes: 0,
                                    valorcancelamentosMes: 0,
                                    cancelamentosMes: 0,
                                    ticketmedioMes: 0,
                                    margemMes: 0,
                                    metaMes: 0,
                                    valorMesAnt: empresasMesAnt[index].valortotal,
                                    ticketMesAnt: empresasMesAnt[index].ticket.toInt(),
                                    valorcancelamentosMesAnt: empresasMesAnt[index].valorcancelamentos,
                                    cancelamentosMesAnt: empresasMesAnt[index].cancelamentos,
                                    ticketmedioMesAnt: empresasMesAnt[index].ticketmedio,
                                    margemMesAnt: empresasMesAnt[index].margem,
                                    metaMesAnt: empresasMesAnt[index].meta,
                                  ),
                                if (empresasSemana.isNotEmpty &&
                                    empresasMes.isNotEmpty)
                                  BranchCardContent(
                                    valorHoje: empresasHoje[index].valortotal,
                                    valorOntem: 0,
                                    valorSemana: empresasSemana[index].valortotal,
                                    valorMes: empresasMes[index].valortotal,
                                  )
                                else
                                  BranchCardContent(
                                    valorHoje: empresasHoje[index].valortotal,
                                    valorOntem: 0,
                                    valorSemana: 0,
                                    valorMes: 0,
                                  )
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                },
              ),
              if (empresasHoje.isEmpty)
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: empresasOntem.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          BranchCard(
                            children: [
                              Column(
                                children: [
                                  CompanyNameButton(
                                    // url: url,
                                    // token: token,
                                    // login: widget.login,
                                    // image: widget.image,
                                    empresaNome: empresasOntem[index].empresaNome,
                                    valorHoje: 0,
                                    ticketHoje: 0,
                                    valorcancelamentosHoje: 0,
                                    cancelamentosHoje: 0,
                                    ticketmedioHoje: 0,
                                    margemHoje: 0,
                                    metaHoje: 0,
                                    valorOntem: empresasOntem[index].valortotal,
                                    ticketOntem: empresasOntem[index].ticket.toInt(),
                                    valorcancelamentosOntem: empresasOntem[index].valorcancelamentos,
                                    cancelamentosOntem: empresasOntem[index].cancelamentos,
                                    ticketmedioOntem: empresasOntem[index].ticketmedio,
                                    margemOntem: empresasOntem[index].margem,
                                    metaOntem: empresasOntem[index].meta,
                                    valorSemana: empresasSemana[index].valortotal,
                                    ticketSemana: empresasSemana[index].ticket.toInt(),
                                    valorcancelamentosSemana: empresasSemana[index].valorcancelamentos,
                                    cancelamentosSemana: empresasSemana[index].cancelamentos,
                                    ticketmedioSemana: empresasSemana[index].ticketmedio,
                                    margemSemana: empresasSemana[index].margem,
                                    metaSemana: empresasSemana[index].meta,
                                    valorMes: empresasMes[index].valortotal,
                                    ticketMes: empresasMes[index].ticket.toInt(),
                                    valorcancelamentosMes: empresasMes[index].valorcancelamentos,
                                    cancelamentosMes: empresasMes[index].cancelamentos,
                                    ticketmedioMes: empresasMes[index].ticketmedio,
                                    margemMes: empresasMes[index].margem,
                                    metaMes: empresasMes[index].meta,
                                    valorMesAnt: empresasMesAnt[index].valortotal,
                                    ticketMesAnt: empresasMesAnt[index].ticket.toInt(),
                                    valorcancelamentosMesAnt: empresasMesAnt[index].valorcancelamentos,
                                    cancelamentosMesAnt: empresasMesAnt[index].cancelamentos,
                                    ticketmedioMesAnt: empresasMesAnt[index].ticketmedio,
                                    margemMesAnt: empresasMesAnt[index].margem,
                                    metaMesAnt: empresasMesAnt[index].meta,
                                  ),
                                  BranchCardContent(
                                    valorHoje: 0,
                                    valorOntem: empresasOntem[index].valortotal,
                                    valorSemana: empresasSemana[index].valortotal,
                                    valorMes: empresasMes[index].valortotal,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
              if (empresasHoje.isEmpty && empresasOntem.isEmpty)
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: empresasSemana.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          BranchCard(
                            children: [
                              Column(
                                children: [
                                  CompanyNameButton(
                                    // url: url,
                                    // token: token,
                                    // login: widget.login,
                                    // image: widget.image,
                                    empresaNome: empresasHoje[index].empresaNome,
                                    valorHoje: 0,
                                    ticketHoje: 0,
                                    valorcancelamentosHoje: 0,
                                    cancelamentosHoje: 0,
                                    ticketmedioHoje: 0,
                                    margemHoje: 0,
                                    metaHoje: 0,
                                    valorOntem: 0,
                                    ticketOntem: 0,
                                    valorcancelamentosOntem: 0,
                                    cancelamentosOntem: 0,
                                    ticketmedioOntem: 0,
                                    margemOntem: 0,
                                    metaOntem: 0,
                                    valorSemana: empresasSemana[index].valortotal,
                                    ticketSemana: empresasSemana[index].ticket.toInt(),
                                    valorcancelamentosSemana: empresasSemana[index].valorcancelamentos,
                                    cancelamentosSemana: empresasSemana[index].cancelamentos,
                                    ticketmedioSemana: empresasSemana[index].ticketmedio,
                                    margemSemana: empresasSemana[index].margem,
                                    metaSemana: empresasSemana[index].meta,
                                    valorMes: empresasMes[index].valortotal,
                                    ticketMes: empresasMes[index].ticket.toInt(),
                                    valorcancelamentosMes: empresasMes[index].valorcancelamentos,
                                    cancelamentosMes: empresasMes[index].cancelamentos,
                                    ticketmedioMes: empresasMes[index].ticketmedio,
                                    margemMes: empresasMes[index].margem,
                                    metaMes: empresasMes[index].meta,
                                    valorMesAnt: empresasMesAnt[index].valortotal,
                                    ticketMesAnt: empresasMesAnt[index].ticket.toInt(),
                                    valorcancelamentosMesAnt: empresasMesAnt[index].valorcancelamentos,
                                    cancelamentosMesAnt: empresasMesAnt[index].cancelamentos,
                                    ticketmedioMesAnt: empresasMesAnt[index].ticketmedio,
                                    margemMesAnt: empresasMesAnt[index].margem,
                                    metaMesAnt: empresasMesAnt[index].meta,
                                  ),
                                  BranchCardContent(
                                    valorHoje: 0,
                                    valorOntem: 0,
                                    valorSemana: empresasSemana[index].valortotal,
                                    valorMes: empresasMes[index].valortotal,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
              if (empresasHoje.isEmpty &&
                  empresasOntem.isEmpty &&
                  empresasSemana.isEmpty)
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: empresasMes.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          BranchCard(
                            children: [
                              Column(
                                children: [
                                  CompanyNameButton(
                                    // url: url,
                                    // token: token,
                                    // login: widget.login,
                                    // image: widget.image,
                                    empresaNome: empresasMes[index].empresaNome,
                                    valorHoje: 0,
                                    ticketHoje: 0,
                                    valorcancelamentosHoje: 0,
                                    cancelamentosHoje: 0,
                                    ticketmedioHoje: 0,
                                    margemHoje: 0,
                                    metaHoje: 0,
                                    valorOntem: 0,
                                    ticketOntem: 0,
                                    valorcancelamentosOntem: 0,
                                    cancelamentosOntem: 0,
                                    ticketmedioOntem: 0,
                                    margemOntem: 0,
                                    metaOntem: 0,
                                    valorSemana: 0,
                                    ticketSemana: 0,
                                    valorcancelamentosSemana: 0,
                                    cancelamentosSemana: 0,
                                    ticketmedioSemana: 0,
                                    margemSemana: 0,
                                    metaSemana: 0,
                                    valorMes: empresasMes[index].valortotal,
                                    ticketMes: empresasMes[index].ticket.toInt(),
                                    valorcancelamentosMes: empresasMes[index].valorcancelamentos,
                                    cancelamentosMes: empresasMes[index].cancelamentos,
                                    ticketmedioMes: empresasMes[index].ticketmedio,
                                    margemMes: empresasMes[index].margem,
                                    metaMes: empresasMes[index].meta,
                                    valorMesAnt: empresasMesAnt[index].valortotal,
                                    ticketMesAnt: empresasMesAnt[index].ticket.toInt(),
                                    valorcancelamentosMesAnt: empresasMesAnt[index].valorcancelamentos,
                                    cancelamentosMesAnt: empresasMesAnt[index].cancelamentos,
                                    ticketmedioMesAnt: empresasMesAnt[index].ticketmedio,
                                    margemMesAnt: empresasMesAnt[index].margem,
                                    metaMesAnt: empresasMesAnt[index].meta,
                                  ),
                                  BranchCardContent(
                                    valorHoje: 0,
                                    valorOntem: 0,
                                    valorSemana: 0,
                                    valorMes: empresasMes[index].valortotal,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
              if (empresasHoje.isEmpty &&
                  empresasOntem.isEmpty &&
                  empresasMes.isEmpty &&
                  empresasSemana.isEmpty)
                Center(
                  child: Text('Não há dados de vendas'),
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

  Future<void> _loadSavedUrlBasic() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedUrlBasic = await sharedPreferences.getString('urlBasic') ?? '';
    setState(() {
      urlBasic = savedUrlBasic;
    });
  }

  Future<void> _loadSavedEmail() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedEmail = await sharedPreferences.getString('email') ?? '';
    setState(() {
      email = savedEmail;
    });
  }

  Future<void> loadData() async {
  // Utiliza Future.wait para buscar os dados de forma paralela
  await Future.wait([
    _loadSavedToken(),
    _loadSavedUrl(),
  ]);

  // Após carregar os dados do token e da URL, chama as funções para buscar os dados
  await Future.wait([
    fetchDataToday(),
    fetchDataYesterday(),
    fetchDataWeek(),
    fetchDataMonth(),
    fetchDataPrevMonth(),
    fetchDataSalesMonitor(),
    fetchDataRequests(),
  ]);

  // Todos os dados foram carregados, agora atualiza o estado para parar o carregamento
  setState(() {
    isLoading = false;
    // Verifica se os dados de solicitacoesremotas foram carregados corretamente
    if (solicitacoesremotas != -1) {
      solicitacoesremotas =
          NumberOfRequests(solicitacoesremotas: solicitacoesremotas)
              .solicitacoesremotas;
    }
  });
}


  Future<void> _refreshData() async {
    // Aqui você pode chamar os métodos para recarregar os dados
    // Exemplo: await loadData();
    setState(() {
      isLoading =
          true; // Define isLoading como true para mostrar o indicador de carregamento
    });
    await loadData();
    setState(() {
      isLoading =
          false; // Define isLoading como false para parar o indicador de carregamento
    });
  }

  Future<void> fetchDataToday() async {
    List<CompanySalesMonitor>? fetchedData =
        await DataServiceToday.fetchDataToday(token, url);

    if (fetchedData != null) {
      setState(() {
        empresasHoje = fetchedData;
      });
    }
  }

  Future<void> fetchDataYesterday() async {
    List<CompanySalesMonitor>? fetchedData =
        await DataServiceYesterday.fetchDataYesterday(token, url);

    if (fetchedData != null) {
      setState(() {
        empresasOntem = fetchedData;
      });
    }
  }

  Future<void> fetchDataWeek() async {
    List<CompanySalesMonitor>? fetchedData =
        await DataServiceWeek.fetchDataWeek(token, url);

    if (fetchedData != null) {
      setState(() {
        empresasSemana = fetchedData;
      });
    }
  }

  Future<void> fetchDataMonth() async {
    List<CompanySalesMonitor>? fetchedData =
        await DataServiceMonth.fetchDataMonth(token, url);

    if (fetchedData != null) {
      setState(() {
        empresasMes = fetchedData;
      });
    }
  }

  Future<void> fetchDataPrevMonth() async {
    List<CompanySalesMonitor>? fetchedData =
        await DataServicePrevMonth.fetchDataPrevMonth(token, url);

    if (fetchedData != null) {
      setState(() {
        empresasMesAnt = fetchedData;
      });
    }
  }

  Future<void> fetchDataSalesMonitor() async {
    Map<String, double?>? fetchDataSalesMonitor =
        await DataServiceSalesMonitor.fetchDataSalesMonitor(
            token, url);

    // ignore: unnecessary_null_comparison
    if (fetchDataSalesMonitor != null) {
      setState(() {
        vendadia = fetchDataSalesMonitor['vendadia'] ?? 0.0;
        vendadiaanterior = fetchDataSalesMonitor['vendadiaanterior'] ?? 0.0;
        vendasemana = fetchDataSalesMonitor['vendasemana'] ?? 0.0;
        vendames = fetchDataSalesMonitor['vendames'] ?? 0.0;
      });
    }
  }

  Future<void> fetchDataRequests() async {
    int? fetchedDataRequests = await DataServiceSalesMonitor.fetchDataRequests(
        token, url);

    if (fetchedDataRequests != null) {
      setState(() {
        solicitacoesremotas = fetchedDataRequests;
      });
    }
  }
}
