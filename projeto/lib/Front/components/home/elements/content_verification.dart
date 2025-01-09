import 'package:flutter/material.dart';
import 'package:projeto/back/company_sales_monitor.dart';
import 'package:projeto/front/components/home/elements/branch_card_content.dart';
import 'package:projeto/front/components/home/elements/company_name_button.dart';
import 'package:projeto/front/components/home/structure/branch_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContentVerification extends StatefulWidget {
  final empresasHoje;
  final empresasOntem;
  final empresasSemana;
  final empresasMes;
  final empresasMesAnt;

  const ContentVerification({Key? key, 
  this.empresasHoje, 
  this.empresasOntem,
  this.empresasSemana,
  this.empresasMes,
  this.empresasMesAnt,
  });

  @override
  State<ContentVerification> createState() => _ContentVerificationState();
}

class _ContentVerificationState extends State<ContentVerification> {
  String token = '';
  String url = '';
  List<CompanySalesMonitor> empresasHoje = [];
  List<CompanySalesMonitor> empresasOntem = [];
  List<CompanySalesMonitor> empresasSemana = [];
  List<CompanySalesMonitor> empresasMes = [];
  List<CompanySalesMonitor> empresasMesAnt = [];
   
   @override
  void initState() {
    super.initState();
    _loadSavedUrl();
    _loadSavedToken();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          if (
              widget.empresasHoje.isNotEmpty && 
              widget.empresasOntem.isNotEmpty && 
              widget.empresasSemana.isNotEmpty && 
              widget.empresasMes.isNotEmpty &&
              widget.empresasMesAnt.isNotEmpty
              )
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.empresasHoje.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          BranchCard(
                            children: [
                              Column(
                                children: [
                                  CompanyNameButton(
                                    empresaNome: widget.empresasHoje[index].empresaNome,
                                    valorHoje: widget.empresasHoje[index].valortotal,
                                    ticketHoje: widget.empresasHoje[index].valortotal.toInt(),
                                    valorcancelamentosHoje: widget.empresasHoje[index].valortotal,
                                    cancelamentosHoje: widget.empresasHoje[index].valortotal,
                                    ticketmedioHoje: widget.empresasHoje[index].valortotal,
                                    margemHoje: widget.empresasHoje[index].valortotal,
                                    metaHoje: widget.empresasHoje[index].valortotal,
                                    valorOntem: widget.empresasOntem[index].valortotal,
                                    ticketOntem: widget.empresasOntem[index].ticket.toInt(),
                                    valorcancelamentosOntem: widget.empresasOntem[index].valorcancelamentos,
                                    cancelamentosOntem: widget.empresasOntem[index].cancelamentos,
                                    ticketmedioOntem: widget.empresasOntem[index].ticketmedio,
                                    margemOntem: widget.empresasOntem[index].margem,
                                    metaOntem: widget.empresasOntem[index].meta,
                                    valorSemana: widget.empresasSemana[index].valortotal,
                                    ticketSemana: widget.empresasSemana[index].ticket.toInt(),
                                    valorcancelamentosSemana: widget.empresasSemana[index].valorcancelamentos,
                                    cancelamentosSemana: widget.empresasSemana[index].cancelamentos,
                                    ticketmedioSemana: widget.empresasSemana[index].ticketmedio,
                                    margemSemana: widget.empresasSemana[index].margem,
                                    metaSemana: widget.empresasSemana[index].meta,
                                    valorMes: widget.empresasMes[index].valortotal,
                                    ticketMes: widget.empresasMes[index].ticket.toInt(),
                                    valorcancelamentosMes: widget.empresasMes[index].valorcancelamentos,
                                    cancelamentosMes: widget.empresasMes[index].cancelamentos,
                                    ticketmedioMes: widget.empresasMes[index].ticketmedio,
                                    margemMes: widget.empresasMes[index].margem,
                                    metaMes: widget.empresasMes[index].meta,
                                    valorMesAnt: widget.empresasMesAnt[index].valortotal,
                                    ticketMesAnt: widget.empresasMesAnt[index].ticket.toInt(),
                                    valorcancelamentosMesAnt: widget.empresasMesAnt[index].valorcancelamentos,
                                    cancelamentosMesAnt: widget.empresasMesAnt[index].cancelamentos,
                                    ticketmedioMesAnt: widget.empresasMesAnt[index].ticketmedio,
                                    margemMesAnt: widget.empresasMesAnt[index].margem,
                                    metaMesAnt: widget.empresasMesAnt[index].meta,
                                  ),
                                  BranchCardContent(
                                    valorHoje: widget.empresasHoje[index].valortotal,
                                    valorOntem: widget.empresasOntem[index].valortotal,
                                    valorSemana: widget.empresasSemana[index].valortotal,
                                    valorMes: widget.empresasMes[index].valortotal,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                    if(widget.empresasHoje.isEmpty && widget.empresasMesAnt.isEmpty)
                    ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.empresasOntem.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          BranchCard(
                            children: [
                              Column(
                                children: [
                                  CompanyNameButton(
                                    empresaNome: widget.empresasOntem[index].empresaNome,
                                    valorHoje: 0,
                                    ticketHoje: 0,
                                    valorcancelamentosHoje: 0,
                                    cancelamentosHoje: 0,
                                    ticketmedioHoje: 0,
                                    margemHoje: 0,
                                    metaHoje: 0,
                                    valorOntem: widget.empresasOntem[index].valortotal,
                                    ticketOntem: widget.empresasOntem[index].ticket.toInt(),
                                    valorcancelamentosOntem: widget.empresasOntem[index].valorcancelamentos,
                                    cancelamentosOntem: widget.empresasOntem[index].cancelamentos,
                                    ticketmedioOntem: widget.empresasOntem[index].ticketmedio,
                                    margemOntem: widget.empresasOntem[index].margem,
                                    metaOntem: widget.empresasOntem[index].meta,
                                    valorSemana: widget.empresasSemana[index].valortotal,
                                    ticketSemana: widget.empresasSemana[index].ticket.toInt(),
                                    valorcancelamentosSemana: widget.empresasSemana[index].valorcancelamentos,
                                    cancelamentosSemana: widget.empresasSemana[index].cancelamentos,
                                    ticketmedioSemana: widget.empresasSemana[index].ticketmedio,
                                    margemSemana: widget.empresasSemana[index].margem,
                                    metaSemana: widget.empresasSemana[index].meta,
                                    valorMes: widget.empresasMes[index].valortotal,
                                    ticketMes: widget.empresasMes[index].ticket.toInt(),
                                    valorcancelamentosMes: widget.empresasMes[index].valorcancelamentos,
                                    cancelamentosMes: widget.empresasMes[index].cancelamentos,
                                    ticketmedioMes: widget.empresasMes[index].ticketmedio,
                                    margemMes: widget.empresasMes[index].margem,
                                    metaMes: widget.empresasMes[index].meta,
                                    valorMesAnt: 0,
                                    ticketMesAnt: 0,
                                    valorcancelamentosMesAnt: 0,
                                    cancelamentosMesAnt: 0,
                                    ticketmedioMesAnt: 0,
                                    margemMesAnt: 0,
                                    metaMesAnt: 0,
                                  ),
                                  BranchCardContent(
                                    valorHoje: 0,
                                    valorOntem: widget.empresasOntem[index].valortotal,
                                    valorSemana: widget.empresasSemana[index].valortotal,
                                    valorMes: widget.empresasMes[index].valortotal,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    })
                    else if(widget.empresasHoje.isEmpty)
                    ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.empresasOntem.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          BranchCard(
                            children: [
                              Column(
                                children: [
                                  CompanyNameButton(
                                    empresaNome: widget.empresasOntem[index].empresaNome,
                                    valorHoje: 0,
                                    ticketHoje: 0,
                                    valorcancelamentosHoje: 0,
                                    cancelamentosHoje: 0,
                                    ticketmedioHoje: 0,
                                    margemHoje: 0,
                                    metaHoje: 0,
                                    valorOntem: widget.empresasOntem[index].valortotal,
                                    ticketOntem: widget.empresasOntem[index].ticket.toInt(),
                                    valorcancelamentosOntem: widget.empresasOntem[index].valorcancelamentos,
                                    cancelamentosOntem: widget.empresasOntem[index].cancelamentos,
                                    ticketmedioOntem: widget.empresasOntem[index].ticketmedio,
                                    margemOntem: widget.empresasOntem[index].margem,
                                    metaOntem: widget.empresasOntem[index].meta,
                                    valorSemana: widget.empresasSemana[index].valortotal,
                                    ticketSemana: widget.empresasSemana[index].ticket.toInt(),
                                    valorcancelamentosSemana: widget.empresasSemana[index].valorcancelamentos,
                                    cancelamentosSemana: widget.empresasSemana[index].cancelamentos,
                                    ticketmedioSemana: widget.empresasSemana[index].ticketmedio,
                                    margemSemana: widget.empresasSemana[index].margem,
                                    metaSemana: widget.empresasSemana[index].meta,
                                    valorMes: widget.empresasMes[index].valortotal,
                                    ticketMes: widget.empresasMes[index].ticket.toInt(),
                                    valorcancelamentosMes: widget.empresasMes[index].valorcancelamentos,
                                    cancelamentosMes: widget.empresasMes[index].cancelamentos,
                                    ticketmedioMes: widget.empresasMes[index].ticketmedio,
                                    margemMes: widget.empresasMes[index].margem,
                                    metaMes: widget.empresasMes[index].meta,
                                    valorMesAnt: widget.empresasMesAnt[index].valortotal,
                                    ticketMesAnt: widget.empresasMesAnt[index].ticket.toInt(),
                                    valorcancelamentosMesAnt: widget.empresasMesAnt[index].valorcancelamentos,
                                    cancelamentosMesAnt: widget.empresasMesAnt[index].cancelamentos,
                                    ticketmedioMesAnt: widget.empresasMesAnt[index].ticketmedio,
                                    margemMesAnt: widget.empresasMesAnt[index].margem,
                                    metaMesAnt: widget.empresasMesAnt[index].meta,
                                  ),
                                  BranchCardContent(
                                    valorHoje: 0,
                                    valorOntem: widget.empresasOntem[index].valortotal,
                                    valorSemana: widget.empresasSemana[index].valortotal,
                                    valorMes: widget.empresasMes[index].valortotal,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                    if(widget.empresasHoje.isEmpty && widget.empresasOntem.isEmpty && widget.empresasMesAnt.isEmpty)
                    ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.empresasSemana.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          BranchCard(
                            children: [
                              Column(
                                children: [
                                  CompanyNameButton(
                                    empresaNome: widget.empresasSemana[index].empresaNome,
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
                                    valorSemana: widget.empresasSemana[index].valortotal,
                                    ticketSemana: widget.empresasSemana[index].ticket.toInt(),
                                    valorcancelamentosSemana: widget.empresasSemana[index].valorcancelamentos,
                                    cancelamentosSemana: widget.empresasSemana[index].cancelamentos,
                                    ticketmedioSemana: widget.empresasSemana[index].ticketmedio,
                                    margemSemana: widget.empresasSemana[index].margem,
                                    metaSemana: widget.empresasSemana[index].meta,
                                    valorMes: widget.empresasMes[index].valortotal,
                                    ticketMes: widget.empresasMes[index].ticket.toInt(),
                                    valorcancelamentosMes: widget.empresasMes[index].valorcancelamentos,
                                    cancelamentosMes: widget.empresasMes[index].cancelamentos,
                                    ticketmedioMes: widget.empresasMes[index].ticketmedio,
                                    margemMes: widget.empresasMes[index].margem,
                                    metaMes: widget.empresasMes[index].meta,
                                    valorMesAnt: 0,
                                    ticketMesAnt: 0,
                                    valorcancelamentosMesAnt: 0,
                                    cancelamentosMesAnt: 0,
                                    ticketmedioMesAnt: 0,
                                    margemMesAnt: 0,
                                    metaMesAnt: 0,
                                  ),
                                  BranchCardContent(
                                    valorHoje: 0,
                                    valorOntem: 0,
                                    valorSemana: widget.empresasSemana[index].valortotal,
                                    valorMes: widget.empresasMes[index].valortotal,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    })
                    else if(widget.empresasHoje.isEmpty && widget.empresasOntem.isEmpty)
                    ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.empresasSemana.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          BranchCard(
                            children: [
                              Column(
                                children: [
                                  CompanyNameButton(
                                    empresaNome: widget.empresasSemana[index].empresaNome,
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
                                    valorSemana: widget.empresasSemana[index].valortotal,
                                    ticketSemana: widget.empresasSemana[index].ticket.toInt(),
                                    valorcancelamentosSemana: widget.empresasSemana[index].valorcancelamentos,
                                    cancelamentosSemana: widget.empresasSemana[index].cancelamentos,
                                    ticketmedioSemana: widget.empresasSemana[index].ticketmedio,
                                    margemSemana: widget.empresasSemana[index].margem,
                                    metaSemana: widget.empresasSemana[index].meta,
                                    valorMes: widget.empresasMes[index].valortotal,
                                    ticketMes: widget.empresasMes[index].ticket.toInt(),
                                    valorcancelamentosMes: widget.empresasMes[index].valorcancelamentos,
                                    cancelamentosMes: widget.empresasMes[index].cancelamentos,
                                    ticketmedioMes: widget.empresasMes[index].ticketmedio,
                                    margemMes: widget.empresasMes[index].margem,
                                    metaMes: widget.empresasMes[index].meta,
                                    valorMesAnt: widget.empresasMesAnt[index].valortotal,
                                    ticketMesAnt: widget.empresasMesAnt[index].ticket.toInt(),
                                    valorcancelamentosMesAnt: widget.empresasMesAnt[index].valorcancelamentos,
                                    cancelamentosMesAnt: widget.empresasMesAnt[index].cancelamentos,
                                    ticketmedioMesAnt: widget.empresasMesAnt[index].ticketmedio,
                                    margemMesAnt: widget.empresasMesAnt[index].margem,
                                    metaMesAnt: widget.empresasMesAnt[index].meta,
                                  ),
                                  BranchCardContent(
                                    valorHoje: 0,
                                    valorOntem: 0,
                                    valorSemana: widget.empresasSemana[index].valortotal,
                                    valorMes: widget.empresasMes[index].valortotal,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    })
                    else if(widget.empresasOntem.isEmpty)
                    ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.empresasHoje.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          BranchCard(
                            children: [
                              Column(
                                children: [
                                  CompanyNameButton(
                                    empresaNome: widget.empresasHoje[index].empresaNome,
                                    valorHoje: widget.empresasHoje[index].valortotal,
                                    ticketHoje: widget.empresasHoje[index].valortotal.toInt(),
                                    valorcancelamentosHoje: widget.empresasHoje[index].valortotal,
                                    cancelamentosHoje: widget.empresasHoje[index].valortotal,
                                    ticketmedioHoje: widget.empresasHoje[index].valortotal,
                                    margemHoje: widget.empresasHoje[index].valortotal,
                                    metaHoje: widget.empresasHoje[index].valortotal,
                                    valorOntem: 0,
                                    ticketOntem: 0,
                                    valorcancelamentosOntem: 0,
                                    cancelamentosOntem: 0,
                                    ticketmedioOntem: 0,
                                    margemOntem: 0,
                                    metaOntem: 0,
                                    valorSemana: widget.empresasSemana[index].valortotal,
                                    ticketSemana: widget.empresasSemana[index].ticket.toInt(),
                                    valorcancelamentosSemana: widget.empresasSemana[index].valorcancelamentos,
                                    cancelamentosSemana: widget.empresasSemana[index].cancelamentos,
                                    ticketmedioSemana: widget.empresasSemana[index].ticketmedio,
                                    margemSemana: widget.empresasSemana[index].margem,
                                    metaSemana: widget.empresasSemana[index].meta,
                                    valorMes: widget.empresasMes[index].valortotal,
                                    ticketMes: widget.empresasMes[index].ticket.toInt(),
                                    valorcancelamentosMes: widget.empresasMes[index].valorcancelamentos,
                                    cancelamentosMes: widget.empresasMes[index].cancelamentos,
                                    ticketmedioMes: widget.empresasMes[index].ticketmedio,
                                    margemMes: widget.empresasMes[index].margem,
                                    metaMes: widget.empresasMes[index].meta,
                                    valorMesAnt: widget.empresasMesAnt[index].valortotal,
                                    ticketMesAnt: widget.empresasMesAnt[index].ticket.toInt(),
                                    valorcancelamentosMesAnt: widget.empresasMesAnt[index].valorcancelamentos,
                                    cancelamentosMesAnt: widget.empresasMesAnt[index].cancelamentos,
                                    ticketmedioMesAnt: widget.empresasMesAnt[index].ticketmedio,
                                    margemMesAnt: widget.empresasMesAnt[index].margem,
                                    metaMesAnt: widget.empresasMesAnt[index].meta,
                                  ),
                                  BranchCardContent(
                                    valorHoje: widget.empresasHoje[index].valortotal,
                                    valorOntem: 0,
                                    valorSemana: widget.empresasSemana[index].valortotal,
                                    valorMes: widget.empresasMes[index].valortotal,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                    if(widget.empresasHoje.isEmpty && widget.empresasOntem.isEmpty && widget.empresasSemana.isEmpty && widget.empresasMesAnt.isEmpty)
                    ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.empresasMes.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          BranchCard(
                            children: [
                              Column(
                                children: [
                                  CompanyNameButton(
                                    empresaNome: widget.empresasMes[index].empresaNome,
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
                                    ticketSemana: 0.toInt(),
                                    valorcancelamentosSemana: 0,
                                    cancelamentosSemana: 0,
                                    ticketmedioSemana: 0,
                                    margemSemana: 0,
                                    metaSemana: 0,
                                    valorMes: widget.empresasMes[index].valortotal,
                                    ticketMes: widget.empresasMes[index].ticket.toInt(),
                                    valorcancelamentosMes: widget.empresasMes[index].valorcancelamentos,
                                    cancelamentosMes: widget.empresasMes[index].cancelamentos,
                                    ticketmedioMes: widget.empresasMes[index].ticketmedio,
                                    margemMes: widget.empresasMes[index].margem,
                                    metaMes: widget.empresasMes[index].meta,
                                    valorMesAnt: 0,
                                    ticketMesAnt: 0,
                                    valorcancelamentosMesAnt: 0,
                                    cancelamentosMesAnt: 0,
                                    ticketmedioMesAnt: 0,
                                    margemMesAnt: 0,
                                    metaMesAnt: 0,
                                  ),
                                  BranchCardContent(
                                    valorHoje: 0,
                                    valorOntem: 0,
                                    valorSemana: 0,
                                    valorMes: widget.empresasMes[index].valortotal,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    })
                    else if(widget.empresasHoje.isEmpty && widget.empresasOntem.isEmpty && widget.empresasSemana.isEmpty)
                    ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.empresasMes.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          BranchCard(
                            children: [
                              Column(
                                children: [
                                  CompanyNameButton(
                                    empresaNome: widget.empresasMes[index].empresaNome,
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
                                    ticketSemana: 0.toInt(),
                                    valorcancelamentosSemana: 0,
                                    cancelamentosSemana: 0,
                                    ticketmedioSemana: 0,
                                    margemSemana: 0,
                                    metaSemana: 0,
                                    valorMes: widget.empresasMes[index].valortotal,
                                    ticketMes: widget.empresasMes[index].ticket.toInt(),
                                    valorcancelamentosMes: widget.empresasMes[index].valorcancelamentos,
                                    cancelamentosMes: widget.empresasMes[index].cancelamentos,
                                    ticketmedioMes: widget.empresasMes[index].ticketmedio,
                                    margemMes: widget.empresasMes[index].margem,
                                    metaMes: widget.empresasMes[index].meta,
                                    valorMesAnt: widget.empresasMesAnt[index].valortotal,
                                    ticketMesAnt: widget.empresasMesAnt[index].ticket.toInt(),
                                    valorcancelamentosMesAnt: widget.empresasMesAnt[index].valorcancelamentos,
                                    cancelamentosMesAnt: widget.empresasMesAnt[index].cancelamentos,
                                    ticketmedioMesAnt: widget.empresasMesAnt[index].ticketmedio,
                                    margemMesAnt: widget.empresasMesAnt[index].margem,
                                    metaMesAnt: widget.empresasMesAnt[index].meta,
                                  ),
                                  BranchCardContent(
                                    valorHoje: 0,
                                    valorOntem: 0,
                                    valorSemana: 0,
                                    valorMes: widget.empresasMes[index].valortotal,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    })
                    else if (widget.empresasSemana.isEmpty)
                    ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.empresasHoje.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          BranchCard(
                            children: [
                              Column(
                                children: [
                                  CompanyNameButton(
                                    empresaNome: widget.empresasHoje[index].empresaNome,
                                    valorHoje: widget.empresasHoje[index].valortotal,
                                    ticketHoje: widget.empresasHoje[index].valortotal.toInt(),
                                    valorcancelamentosHoje: widget.empresasHoje[index].valortotal,
                                    cancelamentosHoje: widget.empresasHoje[index].valortotal,
                                    ticketmedioHoje: widget.empresasHoje[index].valortotal,
                                    margemHoje: widget.empresasHoje[index].valortotal,
                                    metaHoje: widget.empresasHoje[index].valortotal,
                                    valorOntem: widget.empresasOntem[index].valortotal,
                                    ticketOntem: widget.empresasOntem[index].ticket.toInt(),
                                    valorcancelamentosOntem: widget.empresasOntem[index].valorcancelamentos,
                                    cancelamentosOntem: widget.empresasOntem[index].cancelamentos,
                                    ticketmedioOntem: widget.empresasOntem[index].ticketmedio,
                                    margemOntem: widget.empresasOntem[index].margem,
                                    metaOntem: widget.empresasOntem[index].meta,
                                    valorSemana: 0,
                                    ticketSemana: 0.toInt(),
                                    valorcancelamentosSemana: 0,
                                    cancelamentosSemana: 0,
                                    ticketmedioSemana: 0,
                                    margemSemana: 0,
                                    metaSemana: 0,
                                    valorMes: widget.empresasMes[index].valortotal,
                                    ticketMes: widget.empresasMes[index].ticket.toInt(),
                                    valorcancelamentosMes: widget.empresasMes[index].valorcancelamentos,
                                    cancelamentosMes: widget.empresasMes[index].cancelamentos,
                                    ticketmedioMes: widget.empresasMes[index].ticketmedio,
                                    margemMes: widget.empresasMes[index].margem,
                                    metaMes: widget.empresasMes[index].meta,
                                    valorMesAnt: widget.empresasMesAnt[index].valortotal,
                                    ticketMesAnt: widget.empresasMesAnt[index].ticket.toInt(),
                                    valorcancelamentosMesAnt: widget.empresasMesAnt[index].valorcancelamentos,
                                    cancelamentosMesAnt: widget.empresasMesAnt[index].cancelamentos,
                                    ticketmedioMesAnt: widget.empresasMesAnt[index].ticketmedio,
                                    margemMesAnt: widget.empresasMesAnt[index].margem,
                                    metaMesAnt: widget.empresasMesAnt[index].meta,
                                  ),
                                  BranchCardContent(
                                    valorHoje: widget.empresasHoje[index].valortotal,
                                    valorOntem: widget.empresasOntem[index].valortotal,
                                    valorSemana: 0,
                                    valorMes: widget.empresasMes[index].valortotal,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
                    if(widget.empresasHoje.isEmpty && widget.empresasOntem.isEmpty && widget.empresasSemana.isEmpty && widget.empresasMes.isEmpty && widget.empresasMesAnt.isEmpty)
                     Center(
                      child: Text('Não há dados de vendas no momento 😞'),
                      )
                      else if(widget.empresasHoje.isEmpty && widget.empresasOntem.isEmpty && widget.empresasSemana.isEmpty && widget.empresasMes.isEmpty)
                     Center(
                      child: Text('Não há dados de vendas no momento 😞'),
                      )
                    else if(widget.empresasMes.isEmpty)
                    ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.empresasHoje.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          BranchCard(
                            children: [
                              Column(
                                children: [
                                  CompanyNameButton(
                                    empresaNome: widget.empresasHoje[index].empresaNome,
                                    valorHoje: widget.empresasHoje[index].valortotal,
                                    ticketHoje: widget.empresasHoje[index].valortotal.toInt(),
                                    valorcancelamentosHoje: widget.empresasHoje[index].valortotal,
                                    cancelamentosHoje: widget.empresasHoje[index].valortotal,
                                    ticketmedioHoje: widget.empresasHoje[index].valortotal,
                                    margemHoje: widget.empresasHoje[index].valortotal,
                                    metaHoje: widget.empresasHoje[index].valortotal,
                                    valorOntem: widget.empresasOntem[index].valortotal,
                                    ticketOntem: widget.empresasOntem[index].ticket.toInt(),
                                    valorcancelamentosOntem: widget.empresasOntem[index].valorcancelamentos,
                                    cancelamentosOntem: widget.empresasOntem[index].cancelamentos,
                                    ticketmedioOntem: widget.empresasOntem[index].ticketmedio,
                                    margemOntem: widget.empresasOntem[index].margem,
                                    metaOntem: widget.empresasOntem[index].meta,
                                    valorSemana: widget.empresasSemana[index].valortotal,
                                    ticketSemana: widget.empresasSemana[index].ticket.toInt(),
                                    valorcancelamentosSemana: widget.empresasSemana[index].valorcancelamentos,
                                    cancelamentosSemana: widget.empresasSemana[index].cancelamentos,
                                    ticketmedioSemana: widget.empresasSemana[index].ticketmedio,
                                    margemSemana: widget.empresasSemana[index].margem,
                                    metaSemana: widget.empresasSemana[index].meta,
                                    valorMes: 0,
                                    ticketMes: 0,
                                    valorcancelamentosMes: 0,
                                    cancelamentosMes: 0,
                                    ticketmedioMes: 0,
                                    margemMes: 0,
                                    metaMes: 0,
                                    valorMesAnt: widget.empresasMesAnt[index].valortotal,
                                    ticketMesAnt: widget.empresasMesAnt[index].ticket.toInt(),
                                    valorcancelamentosMesAnt: widget.empresasMesAnt[index].valorcancelamentos,
                                    cancelamentosMesAnt: widget.empresasMesAnt[index].cancelamentos,
                                    ticketmedioMesAnt: widget.empresasMesAnt[index].ticketmedio,
                                    margemMesAnt: widget.empresasMesAnt[index].margem,
                                    metaMesAnt: widget.empresasMesAnt[index].meta,
                                  ),
                                  BranchCardContent(
                                    valorHoje: widget.empresasHoje[index].valortotal,
                                    valorOntem: widget.empresasOntem[index].valortotal,
                                    valorSemana: widget.empresasSemana[index].valortotal,
                                    valorMes: 0,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    }),
               if(widget.empresasMesAnt.isEmpty)
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.empresasHoje.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          BranchCard(
                            children: [
                              Column(
                                children: [
                                  CompanyNameButton(
                                    empresaNome: widget.empresasHoje[index].empresaNome,
                                    valorHoje: widget.empresasHoje[index].valortotal,
                                    ticketHoje: widget.empresasHoje[index].valortotal.toInt(),
                                    valorcancelamentosHoje: widget.empresasHoje[index].valortotal,
                                    cancelamentosHoje: widget.empresasHoje[index].valortotal,
                                    ticketmedioHoje: widget.empresasHoje[index].valortotal,
                                    margemHoje: widget.empresasHoje[index].valortotal,
                                    metaHoje: widget.empresasHoje[index].valortotal,
                                    valorOntem: widget.empresasOntem[index].valortotal,
                                    ticketOntem: widget.empresasOntem[index].ticket.toInt(),
                                    valorcancelamentosOntem: widget.empresasOntem[index].valorcancelamentos,
                                    cancelamentosOntem: widget.empresasOntem[index].cancelamentos,
                                    ticketmedioOntem: widget.empresasOntem[index].ticketmedio,
                                    margemOntem: widget.empresasOntem[index].margem,
                                    metaOntem: widget.empresasOntem[index].meta,
                                    valorSemana: widget.empresasSemana[index].valortotal,
                                    ticketSemana: widget.empresasSemana[index].ticket.toInt(),
                                    valorcancelamentosSemana: widget.empresasSemana[index].valorcancelamentos,
                                    cancelamentosSemana: widget.empresasSemana[index].cancelamentos,
                                    ticketmedioSemana: widget.empresasSemana[index].ticketmedio,
                                    margemSemana: widget.empresasSemana[index].margem,
                                    metaSemana: widget.empresasSemana[index].meta,
                                    valorMes: widget.empresasMes[index].valortotal,
                                    ticketMes: widget.empresasMes[index].ticket.toInt(),
                                    valorcancelamentosMes: widget.empresasMes[index].valorcancelamentos,
                                    cancelamentosMes: widget.empresasMes[index].cancelamentos,
                                    ticketmedioMes: widget.empresasMes[index].ticketmedio,
                                    margemMes: widget.empresasMes[index].margem,
                                    metaMes: widget.empresasMes[index].meta,
                                    valorMesAnt: 0,
                                    ticketMesAnt: 0,
                                    valorcancelamentosMesAnt: 0,
                                    cancelamentosMesAnt: 0,
                                    ticketmedioMesAnt: 0,
                                    margemMesAnt: 0,
                                    metaMesAnt: 0,
                                  ),
                                  BranchCardContent(
                                    valorHoje: widget.empresasHoje[index].valortotal,
                                    valorOntem: widget.empresasOntem[index].valortotal,
                                    valorSemana: widget.empresasSemana[index].valortotal,
                                    valorMes: widget.empresasMes[index].valortotal,
                                  )
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

  Future<void> fetchDataToday({bool? ascending}) async {
  List<CompanySalesMonitor>? fetchedData = await DataServiceToday.fetchDataToday(token, url, ascending: ascending);

  if (fetchedData != null) {
    setState(() {
      empresasHoje = fetchedData;

      // Ordena as outras listas de acordo com a ordem das vendas do dia
      empresasOntem.sort((a, b) =>
          empresasHoje.indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
          .compareTo(empresasHoje.indexWhere((empresa) => empresa.empresaNome == b.empresaNome)));

      empresasSemana.sort((a, b) =>
          empresasHoje.indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
          .compareTo(empresasHoje.indexWhere((empresa) => empresa.empresaNome == b.empresaNome)));

      empresasMes.sort((a, b) =>
          empresasHoje.indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
          .compareTo(empresasHoje.indexWhere((empresa) => empresa.empresaNome == b.empresaNome)));

      empresasMesAnt.sort((a, b) =>
          empresasHoje.indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
          .compareTo(empresasHoje.indexWhere((empresa) => empresa.empresaNome == b.empresaNome)));
    });
  }
}

  Future<void> fetchDataYesterday({bool? ascending}) async {
    List<CompanySalesMonitor>? fetchedData = await DataServiceYesterday.fetchDataYesterday(token, url, ascending: ascending);

    if (fetchedData != null) {
      setState(() {
        empresasOntem = fetchedData;

        // Ordena as outras listas de acordo com a ordem das vendas do dia
      empresasHoje.sort((a, b) =>
          empresasOntem.indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
          .compareTo(empresasOntem.indexWhere((empresa) => empresa.empresaNome == b.empresaNome)));

      empresasSemana.sort((a, b) =>
          empresasOntem.indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
          .compareTo(empresasOntem.indexWhere((empresa) => empresa.empresaNome == b.empresaNome)));

      empresasMes.sort((a, b) =>
          empresasOntem.indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
          .compareTo(empresasOntem.indexWhere((empresa) => empresa.empresaNome == b.empresaNome)));

      empresasMesAnt.sort((a, b) =>
          empresasOntem.indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
          .compareTo(empresasOntem.indexWhere((empresa) => empresa.empresaNome == b.empresaNome)));
      });
    }
  }

  Future<void> fetchDataWeek({bool? ascending}) async {
    List<CompanySalesMonitor>? fetchedData = await DataServiceWeek.fetchDataWeek(token, url, ascending: ascending);

    if (fetchedData != null) {
      setState(() {
        empresasSemana = fetchedData;

         // Ordena as outras listas de acordo com a ordem das vendas do dia
      empresasHoje.sort((a, b) =>
          empresasSemana.indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
          .compareTo(empresasSemana.indexWhere((empresa) => empresa.empresaNome == b.empresaNome)));

      empresasOntem.sort((a, b) =>
          empresasSemana.indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
          .compareTo(empresasSemana.indexWhere((empresa) => empresa.empresaNome == b.empresaNome)));

      empresasMes.sort((a, b) =>
          empresasSemana.indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
          .compareTo(empresasSemana.indexWhere((empresa) => empresa.empresaNome == b.empresaNome)));

      empresasMesAnt.sort((a, b) =>
          empresasSemana.indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
          .compareTo(empresasSemana.indexWhere((empresa) => empresa.empresaNome == b.empresaNome)));
      }
     );
    }
  }

  Future<void> fetchDataMonth({bool? ascending}) async {
    List<CompanySalesMonitor>? fetchedData = await DataServiceMonth.fetchDataMonth(token, url, ascending: ascending);

    if (fetchedData != null) {
      setState(() {
        empresasMes = fetchedData;

         // Ordena as outras listas de acordo com a ordem das vendas do dia
      empresasHoje.sort((a, b) =>
          empresasMes.indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
          .compareTo(empresasMes.indexWhere((empresa) => empresa.empresaNome == b.empresaNome)));

      empresasOntem.sort((a, b) =>
          empresasMes.indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
          .compareTo(empresasMes.indexWhere((empresa) => empresa.empresaNome == b.empresaNome)));

      empresasSemana.sort((a, b) =>
          empresasMes.indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
          .compareTo(empresasMes.indexWhere((empresa) => empresa.empresaNome == b.empresaNome)));

      empresasMesAnt.sort((a, b) =>
          empresasMes.indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
          .compareTo(empresasMes.indexWhere((empresa) => empresa.empresaNome == b.empresaNome)));
      }
     );
    }
  }

  Future<void> fetchDataPrevMonth() async {
    List<CompanySalesMonitor>? fetchedData = await DataServicePrevMonth.fetchDataPrevMonth(token, url);
    if (fetchedData != null) {
      setState(() {
        empresasMesAnt = fetchedData;
      });
    }
  }
}