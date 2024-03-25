import 'package:flutter/material.dart';
import 'package:projeto/back/company_sales_monitor.dart';
import 'package:projeto/front/components/Style.dart';
import 'package:projeto/front/pages/sales.dart';

class TextBUtton extends StatefulWidget {
  final String empresaNome;
  final String url;
  final token;

  final List<MonitorVendasEmpresa> empresasHoje;
  final List<MonitorVendasEmpresa> empresasOntem;
  final List<MonitorVendasEmpresa> empresasSemana;
  final List<MonitorVendasEmpresa> empresasMes;
  final List<MonitorVendasEmpresa> empresasMesAnt;

  const TextBUtton({
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
                                    empresasHoje: widget.empresasHoje,
                                    empresasOntem: widget.empresasOntem,
                                    empresasSemana: widget.empresasSemana,
                                    empresasMes: widget.empresasMes,
                                    empresasMesAnt: widget.empresasMesAnt,
                                    empresaNome: widget.empresaNome,
                                    
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
