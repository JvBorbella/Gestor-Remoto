import 'package:flutter/material.dart';
import 'package:projeto/front/components/Style.dart';
import 'package:projeto/front/pages/sales.dart';

class TextBUtton extends StatefulWidget {
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

  const TextBUtton({
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
  State<TextBUtton> createState() => _TextButtonState();
}

class _TextButtonState extends State<TextBUtton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      //Código do card
      child: Column(
        children: [
          TextButton(
            //Padding 0 para deixar o button alinhado com o card
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            onPressed: () {
              //Redirecionamento executada ao clicar no button
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => Sales(
                          url: widget.url,
                                    token: widget.token,
                                    empresaNome: widget.empresaNome,
                                    valorHoje: widget.valorHoje,
                                    ticketHoje: widget.ticketHoje,
                                    valorcancelamentosHoje: widget.valorcancelamentosHoje,
                                    cancelamentosHoje: widget.cancelamentosHoje,
                                    ticketmedioHoje: widget.ticketmedioHoje,
                                    margemHoje: widget.margemHoje,
                                    metaHoje: widget.metaHoje,
                                    valorOntem: widget.valorOntem,
                                    ticketOntem: widget.ticketOntem,
                                    valorcancelamentosOntem: widget.valorcancelamentosOntem,
                                    cancelamentosOntem: widget.cancelamentosOntem,
                                    ticketmedioOntem: widget.ticketmedioOntem,
                                    margemOntem: widget.margemOntem,
                                    metaOntem: widget.metaOntem,
                                    valorSemana: widget.valorSemana,
                                    ticketSemana: widget.ticketSemana,
                                    valorcancelamentosSemana: widget.valorcancelamentosSemana,
                                    cancelamentosSemana: widget.cancelamentosSemana,
                                    ticketmedioSemana: widget.ticketmedioSemana,
                                    margemSemana: widget.margemSemana,
                                    metaSemana: widget.metaSemana,
                                    valorMes: widget.valorMes,
                                    ticketMes: widget.ticketMes,
                                    valorcancelamentosMes: widget.valorcancelamentosMes,
                                    cancelamentosMes: widget.cancelamentosMes,
                                    ticketmedioMes: widget.ticketmedioMes,
                                    margemMes: widget.margemMes,
                                    metaMes: widget.metaMes,
                                    valorMesAnt: widget.valorMesAnt,
                                    ticketMesAnt: widget.ticketMesAnt,
                                    valorcancelamentosMesAnt: widget.valorcancelamentosMesAnt,
                                    cancelamentosMesAnt: widget.cancelamentosMesAnt,
                                    ticketmedioMesAnt: widget.ticketmedioMesAnt,
                                    margemMesAnt: widget.margemMesAnt,
                                    metaMesAnt: widget.metaMesAnt,
                        )),
              );
            },
            //Aparência do button
            child: Container(
              margin: EdgeInsets.all(8),
              width: MediaQuery.of(context).size.width,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Text(
                //Texto do button está sendo definido na página home.Dart
                widget.empresaNome,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Style.primaryColor),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
