import 'package:flutter/material.dart';
import 'package:projeto/back/company_sales_monitor.dart';
import 'package:projeto/front/components/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderClass extends StatefulWidget {
  final empresasHoje;
  final empresasOntem;
  final empresasSemana;
  final empresasMes;
  final empresasMesAnt;

  const OrderClass({
    Key? key,
    this.empresasHoje,
    this.empresasOntem,
    this.empresasSemana,
    this.empresasMes,
    this.empresasMesAnt
  });

  @override
  State<OrderClass> createState() => _OrderClassState();
}

class _OrderClassState extends State<OrderClass> {
  String url = '';
  String token = '';
  List<CompanySalesMonitor> empresasHoje = [];
  List<CompanySalesMonitor> empresasOntem = [];
  List<CompanySalesMonitor> empresasSemana = [];
  List<CompanySalesMonitor> empresasMes = [];
  List<CompanySalesMonitor> empresasMesAnt = [];
  String selectedOptionChild = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadSavedUrl();
    _loadSavedToken();
  }

  @override
  build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(Style.height_15(context)),
        margin: EdgeInsets.only(bottom: Style.height_20(context)),
        decoration: BoxDecoration(
          color: Colors.white,
           boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
            border: Border.symmetric(
                horizontal: BorderSide(
                    width: Style.height_05(context),
                    color: Style.quarantineColor))
                    ),
        child: Row(
          children: [
            Container(
              height: Style.height_30(context),
              child: PopupMenuButton<String>(
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'Empresa',
                    child: Text(
                      'Empresa',
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Maiores vendas de hoje',
                    child: Text(
                      'Maiores vendas de hoje',
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Menores vendas de hoje',
                    child: Text('Menores vendas de hoje'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Maiores vendas de ontem',
                    child: Text('Maiores vendas de ontem'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Menores vendas de ontem',
                    child: Text('Menores vendas de ontem'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Maiores vendas da semana',
                    child: Text('Maiores vendas da semana'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Menores vendas da semana',
                    child: Text('Menores vendas da semana'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Maiores vendas do mês',
                    child: Text('Maiores vendas do mês'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Menores vendas do mês',
                    child: Text('Menores vendas do mês'),
                  ),
                ],
                onSelected: (String value) async {
                  if (value == 'Empresa') {
                    await fetchDataToday(ascending: null);
                  } else if (value == 'Maiores vendas de hoje') {
                    await fetchDataToday(ascending: false);
                  } else if (value == 'Menores vendas de hoje') {
                    await fetchDataToday(ascending: true);
                  } else if (value == 'Maiores vendas de ontem') {
                    await fetchDataYesterday(ascending: false);
                  } else if (value == 'Menores vendas de ontem') {
                    await fetchDataYesterday(ascending: true);
                  } else if (value == 'Maiores vendas da semana') {
                    await fetchDataWeek(ascending: false);
                  } else if (value == 'Menores vendas da semana') {
                    await fetchDataWeek(ascending: true);
                  } else if (value == 'Maiores vendas do mês') {
                    await fetchDataMonth(ascending: false);
                  } else if (value == 'Menores vendas do mês') {
                    await fetchDataMonth(ascending: true);
                  }
                  setState(() {
                    selectedOptionChild = value;
                  });
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.filter_list_outlined,
                        color: Style.primaryColor,
                        size: Style.height_20(context),
                      ),
                      SizedBox(
                        width: Style.height_2(context),
                      ),
                      Text(
                        'Ordenado por: ',
                        style: TextStyle(fontSize: Style.height_12(context)),
                      ),
                      Container(
                        // width: 150,
                        child: Text(
                          selectedOptionChild,
                          style: TextStyle(
                            color: Style.secondaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: Style.height_12(context),
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow
                              .clip, // corta o texto no limite da largura
                          softWrap:
                              true, // permite a quebra de linha conforme necessário
                        ),
                      )
                    ]),
              ),
            ),
          ],
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

  Future<void> fetchDataToday({bool? ascending}) async {
    List<CompanySalesMonitor>? fetchedData =
        await DataServiceToday.fetchDataToday(token, url, ascending: ascending);
        
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('saveAscending', ascending.toString());

    if (fetchedData != null) {
      setState(() {
        empresasHoje = fetchedData;

        // Ordena as outras listas de acordo com a ordem das vendas do dia
        empresasOntem.sort((a, b) => empresasHoje
            .indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
            .compareTo(empresasHoje.indexWhere(
                (empresa) => empresa.empresaNome == b.empresaNome)));

        empresasSemana.sort((a, b) => empresasHoje
            .indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
            .compareTo(empresasHoje.indexWhere(
                (empresa) => empresa.empresaNome == b.empresaNome)));

        empresasMes.sort((a, b) => empresasHoje
            .indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
            .compareTo(empresasHoje.indexWhere(
                (empresa) => empresa.empresaNome == b.empresaNome)));

        empresasMesAnt.sort((a, b) => empresasHoje
            .indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
            .compareTo(empresasHoje.indexWhere(
                (empresa) => empresa.empresaNome == b.empresaNome)));
      });
    }
  }

  Future<void> fetchDataYesterday({bool? ascending}) async {
    List<CompanySalesMonitor>? fetchedData =
        await DataServiceYesterday.fetchDataYesterday(token, url,
            ascending: ascending);

    if (fetchedData != null) {
      setState(() {
        empresasOntem = fetchedData;

        // Ordena as outras listas de acordo com a ordem das vendas do dia
        empresasHoje.sort((a, b) => empresasOntem
            .indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
            .compareTo(empresasOntem.indexWhere(
                (empresa) => empresa.empresaNome == b.empresaNome)));

        empresasSemana.sort((a, b) => empresasOntem
            .indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
            .compareTo(empresasOntem.indexWhere(
                (empresa) => empresa.empresaNome == b.empresaNome)));

        empresasMes.sort((a, b) => empresasOntem
            .indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
            .compareTo(empresasOntem.indexWhere(
                (empresa) => empresa.empresaNome == b.empresaNome)));

        empresasMesAnt.sort((a, b) => empresasOntem
            .indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
            .compareTo(empresasOntem.indexWhere(
                (empresa) => empresa.empresaNome == b.empresaNome)));
      });
    }
  }

  Future<void> fetchDataWeek({bool? ascending}) async {
    List<CompanySalesMonitor>? fetchedData =
        await DataServiceWeek.fetchDataWeek(token, url, ascending: ascending);

    if (fetchedData != null) {
      setState(() {
        empresasSemana = fetchedData;

        // Ordena as outras listas de acordo com a ordem das vendas do dia
        empresasHoje.sort((a, b) => empresasSemana
            .indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
            .compareTo(empresasSemana.indexWhere(
                (empresa) => empresa.empresaNome == b.empresaNome)));

        empresasOntem.sort((a, b) => empresasSemana
            .indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
            .compareTo(empresasSemana.indexWhere(
                (empresa) => empresa.empresaNome == b.empresaNome)));

        empresasMes.sort((a, b) => empresasSemana
            .indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
            .compareTo(empresasSemana.indexWhere(
                (empresa) => empresa.empresaNome == b.empresaNome)));

        empresasMesAnt.sort((a, b) => empresasSemana
            .indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
            .compareTo(empresasSemana.indexWhere(
                (empresa) => empresa.empresaNome == b.empresaNome)));
      });
    }
  }

  Future<void> fetchDataMonth({bool? ascending}) async {
    List<CompanySalesMonitor>? fetchedData =
        await DataServiceMonth.fetchDataMonth(token, url, ascending: ascending);

    if (fetchedData != null) {
      setState(() {
        empresasMes = fetchedData;

        // Ordena as outras listas de acordo com a ordem das vendas do dia
        empresasHoje.sort((a, b) => empresasMes
            .indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
            .compareTo(empresasMes.indexWhere(
                (empresa) => empresa.empresaNome == b.empresaNome)));

        empresasOntem.sort((a, b) => empresasMes
            .indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
            .compareTo(empresasMes.indexWhere(
                (empresa) => empresa.empresaNome == b.empresaNome)));

        empresasSemana.sort((a, b) => empresasMes
            .indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
            .compareTo(empresasMes.indexWhere(
                (empresa) => empresa.empresaNome == b.empresaNome)));

        empresasMesAnt.sort((a, b) => empresasMes
            .indexWhere((empresa) => empresa.empresaNome == a.empresaNome)
            .compareTo(empresasMes.indexWhere(
                (empresa) => empresa.empresaNome == b.empresaNome)));
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
  
}
