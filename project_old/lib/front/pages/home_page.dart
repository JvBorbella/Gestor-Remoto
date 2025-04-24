import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:project/Front/components/global/structure/navbar.dart';
import 'package:project/back/sales_info_functions/company_sales_monitor.dart';
import 'package:project/back/sales_info_functions/sales_monitor.dart';
import 'package:project/front/components/global/structure/request_card.dart';
import 'package:project/front/components/home/elements/content_verification.dart';
import 'package:project/front/components/home/elements/drawer_button.dart';
import 'package:project/front/components/home/structure/total_values_card.dart';
import 'package:project/front/components/request_home/elements/number_of_requests.dart';
import 'package:project/front/components/request_home/elements/request_button.dart';
import 'package:project/front/components/request_home/structure/conditional_text_card_requests.dart';
import 'package:project/front/components/style.dart';
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
  bool isLoading = true;
  NumberFormat currencyFormat = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
  String token = '';
  String login = '';
  String image = '';
  String url = '';
  String urlBasic = '';
  String email = '';
  String selectedOptionChild = '';
  String cond_pgto = 'dinheiro';

  @override
  void initState() {
    super.initState();
    getNotification();
    loadData();
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
    Navigator.of(context).pop();
  }

  bool valor = false;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: Container(
              height: Style.CircularProgressIndicatorWidth(context),
              width: Style.CircularProgressIndicatorWidth(context),
              child: CircularProgressIndicator(
                strokeWidth: Style.CircularProgressIndicatorSize(context),
              )),
        ),
      );
    }

    return SafeArea(
        child: WillPopScope(
            child: Scaffold(
              drawer: Drawer(
                child: CustomDrawer(),
                width: MediaQuery.of(context).size.width * 0.9,
              ),
              body: RefreshIndicator(
                onRefresh: () => _refreshData(),
                strokeWidth: Style.CircularProgressIndicatorSize(context),
                child: ListView(
                  children: [
                    Navbar(
                      children: [
                        DrawerButton(
                          style: ButtonStyle(
                              iconSize: WidgetStatePropertyAll(
                                  Style.SizeDrawerButton(context)),
                              iconColor:
                                  WidgetStatePropertyAll(Style.tertiaryColor),
                              padding: WidgetStatePropertyAll(EdgeInsets.all(
                                  Style.PaddingDrawerButton(context)))),
                        ),
                        // ModalButton(),
                      ],
                      text: 'Página inicial',
                    ),
                    SizedBox(
                      height: Style.height_10(context),
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
                            height: Style.height_10(context),
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
                                    children: (vendasemana + vendadia),
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
                                    children: (vendames + vendadia),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Style.height_20(context),
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
                              width: Style.height_2(context),
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
                                          fontSize: Style.TextRequests(context),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: Style.height_2(context),
                                    ),
                                    NumberOfRequests(
                                        solicitacoesremotas:
                                            solicitacoesremotas),
                                  ],
                                ),
                                SizedBox(
                                  height: Style.height_7(context),
                                ),
                                Row(
                                  children: [
                                    ConditionalTextCardRequests(
                                      solicitacoesremotas: solicitacoesremotas,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Style.height_30(context),
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
                      height: Style.height_10(context),
                    ),
                    Container(
                      padding: EdgeInsets.all(Style.height_15(context)),
                      margin: EdgeInsets.only(bottom: Style.height_20(context)),
                      decoration: BoxDecoration(
                        color: Style.defaultColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: Style.height_30(context),
                            child: PopupMenuButton<String>(
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                PopupMenuItem(
                                    enabled: false,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: Style.height_5(context)),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Style.height_5(context)),
                                              color: Style.errorColor),
                                          child: IconButton(
                                            onPressed: () {
                                              _closeModal();
                                            },
                                            icon: Image.asset(
                                                'assets/images/icon_remove/icon_remove.png'),
                                            style: ButtonStyle(
                                                iconColor:
                                                    WidgetStatePropertyAll(
                                                        Style.tertiaryColor)),
                                          ),
                                        ),
                                      ],
                                    )),
                                PopupMenuDivider(
                                  height: Style.height_1(context),
                                ),
                                const PopupMenuItem<String>(
                                  labelTextStyle: WidgetStatePropertyAll(
                                      TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Poppins-Medium',
                                          color: Style.primaryColor)),
                                  value: 'Empresa',
                                  child: Text(
                                    'Empresa',
                                  ),
                                ),
                                PopupMenuDivider(
                                  height: Style.height_1(context),
                                ),
                                const PopupMenuItem<String>(
                                  labelTextStyle: WidgetStatePropertyAll(
                                      TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Poppins-Medium',
                                          color: Style.primaryColor)),
                                  value: 'Maiores vendas de hoje',
                                  child: Text(
                                    'Maiores vendas de hoje',
                                  ),
                                ),
                                PopupMenuDivider(
                                  height: Style.height_1(context),
                                ),
                                const PopupMenuItem<String>(
                                  labelTextStyle: WidgetStatePropertyAll(
                                      TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Poppins-Medium',
                                          color: Style.primaryColor)),
                                  value: 'Menores vendas de hoje',
                                  child: Text('Menores vendas de hoje'),
                                ),
                                PopupMenuDivider(
                                  height: Style.height_1(context),
                                ),
                                const PopupMenuItem<String>(
                                  labelTextStyle: WidgetStatePropertyAll(
                                      TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Poppins-Medium',
                                          color: Style.primaryColor)),
                                  value: 'Maiores vendas de ontem',
                                  child: Text('Maiores vendas de ontem'),
                                ),
                                PopupMenuDivider(
                                  height: Style.height_1(context),
                                ),
                                const PopupMenuItem<String>(
                                  labelTextStyle: WidgetStatePropertyAll(
                                      TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Poppins-Medium',
                                          color: Style.primaryColor)),
                                  value: 'Menores vendas de ontem',
                                  child: Text('Menores vendas de ontem'),
                                ),
                                PopupMenuDivider(
                                  height: Style.height_1(context),
                                ),
                                const PopupMenuItem<String>(
                                  labelTextStyle: WidgetStatePropertyAll(
                                      TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Poppins-Medium',
                                          color: Style.primaryColor)),
                                  value: 'Maiores vendas da semana',
                                  child: Text('Maiores vendas da semana'),
                                ),
                                PopupMenuDivider(
                                  height: Style.height_1(context),
                                ),
                                const PopupMenuItem<String>(
                                  labelTextStyle: WidgetStatePropertyAll(
                                      TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Poppins-Medium',
                                          color: Style.primaryColor)),
                                  value: 'Menores vendas da semana',
                                  child: Text('Menores vendas da semana'),
                                ),
                                PopupMenuDivider(
                                  height: Style.height_1(context),
                                ),
                                const PopupMenuItem<String>(
                                  labelTextStyle: WidgetStatePropertyAll(
                                      TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Poppins-Medium',
                                          color: Style.primaryColor)),
                                  value: 'Maiores vendas do mês',
                                  child: Text('Maiores vendas do mês'),
                                ),
                                PopupMenuDivider(
                                  height: Style.height_1(context),
                                ),
                                const PopupMenuItem<String>(
                                  labelTextStyle: WidgetStatePropertyAll(
                                      TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'Poppins-Medium',
                                          color: Style.primaryColor)),
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
                                } else if (value ==
                                    'Maiores vendas da semana') {
                                  await fetchDataWeek(ascending: false);
                                } else if (value ==
                                    'Menores vendas da semana') {
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
                                      style: TextStyle(
                                          fontSize: Style.height_12(context)),
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
                    SizedBox(
                      height: Style.height_10(context),
                    ),
                    ContentVerification(
                      empresasHoje: empresasHoje,
                      empresasOntem: empresasOntem,
                      empresasSemana: empresasSemana,
                      empresasMes: empresasMes,
                      empresasMesAnt: empresasMesAnt,
                    )
                  ],
                ),
              ),
            ),
            onWillPop: () async {
              return false;
            }));
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
    await Future.wait([
      _loadSavedToken(),
      _loadSavedUrl(),
    ]);

    if (token.isNotEmpty && url.isNotEmpty) {
      await Future.wait([
        fetchDataToday(),
        fetchDataYesterday(),
        fetchDataWeek(),
        fetchDataMonth(),
        fetchDataPrevMonth(),
        fetchDataSalesMonitor(),
        fetchDataRequests(),
      ]);
    }
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
    setState(() {
      isLoading =
          true; // Define isLoading como true para mostrar o indicador de carregamento
    });
    selectedOptionChild = '';
    await loadData();
    setState(() {
      isLoading =
          false; // Define isLoading como false para parar o indicador de carregamento
    });
  }

  Future<void> fetchDataToday({bool? ascending}) async {
    List<CompanySalesMonitor>? fetchedData =
        await DataServiceToday.fetchDataToday(token, url, ascending: ascending);

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

  Future<void> fetchDataSalesMonitor() async {
    Map<String, double?>? fetchDataSalesMonitor =
        await DataServiceSalesMonitor.fetchDataSalesMonitor(token, url);
    if (fetchDataSalesMonitor.isNotEmpty) {
      setState(() {
        vendadia = fetchDataSalesMonitor['vendadia'] ?? 0.0;
        vendadiaanterior = fetchDataSalesMonitor['vendadiaanterior'] ?? 0.0;
        vendasemana = fetchDataSalesMonitor['vendasemana'] ?? 0.0;
        vendames = fetchDataSalesMonitor['vendames'] ?? 0.0;
      });
      // DataServicePayments.fetchDataPayments(context, urlBasic);
      // DataServicePaymentValues.fetchDataPaymentValues(
      //   context,
      //   urlBasic,
      //   cond_pgto,
      // );
    }
  }

  Future<void> fetchDataRequests() async {
    int? fetchedDataRequests =
        await DataServiceSalesMonitor.fetchDataRequests(token, url);
    if (fetchedDataRequests != null) {
      setState(() {
        solicitacoesremotas = fetchedDataRequests;
      });
      if (solicitacoesremotas > 0) {
        // showNotification();
      }
    }
  }

  Future<void> getNotification() async {
    if (solicitacoesremotas > 0) {
      // showNotification();
    } else {}
  }
}
