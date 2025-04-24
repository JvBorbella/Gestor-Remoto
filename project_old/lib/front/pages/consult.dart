import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:project/Front/components/Login_Config/Elements/action_button.dart';
import 'package:project/Front/components/Login_Config/Elements/input.dart';
import 'package:project/Front/components/style.dart';
import 'package:project/Front/components/global/elements/navbar_button.dart';
import 'package:project/Front/components/global/structure/navbar.dart';
import 'package:project/Front/pages/home_page.dart';
import 'package:project/back/sales_info_functions/company_sales_monitor.dart';
import 'package:project/back/customer_info_functions/credit_consult.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConsultPage extends StatefulWidget {
  const ConsultPage({super.key});

  @override
  State<ConsultPage> createState() => _ConsultPageState();
}

class _ConsultPageState extends State<ConsultPage> {
  List<CompanySalesMonitor> empresasHoje = [];
  List<CompanySalesMonitor> empresasOntem = [];
  List<CompanySalesMonitor> empresasSemana = [];
  List<CompanySalesMonitor> empresasMes = [];
  List<CompanySalesMonitor> empresasMesAnt = [];

  String token = '';
  String urlBasic = '';
  String url = '';
  String empresaid = '';

  String selectedOptionChild = '';

  final _cpfController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
            child: Scaffold(
              body: Column(
                children: [
                  Navbar(
                    text: 'Consultar Créditos',
                    children: [
                      NavbarButton(
                        destination: HomePage(),
                        Icons: Icons.arrow_back_ios_new_rounded,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(Style.height_12(context)),
                            child: Input(
                              text: 'Informe o CPF do cliente',
                              type: TextInputType.number,
                              controller: _cpfController,
                              inputFormatters: [
                                MaskedInputFormatter(
                                    '000.000.000-00'), // Máscara de CPF
                              ],
                            ),
                          ),
                          ActionButton(
                            text: 'Consultar',
                            height: Style.ActionButtonSize(context),
                            onPressed: () async {
                              await DataServiceCreditConsult
                                  .fetchDataCreditConsult(context, token,
                                      urlBasic, empresaid, _cpfController.text);
                            },
                          ),
                          SizedBox(
                            height: Style.height_10(context),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'Créditos disponíveis: ',
                                  style: TextStyle(
                                    fontSize: Style.height_10(context),
                                    color: Style.primaryColor,
                                  ),
                                ),
                              ),
                              Text(
                                '',
                                style: TextStyle(
                                  fontSize: Style.height_10(context),
                                  color: Style.secondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            onWillPop: () async {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()));
              return true;
            }));
  }

  Future<void> _loadSavedUrlBasic() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedUrlBasic = await sharedPreferences.getString('urlBasic') ?? '';
    setState(() {
      urlBasic = savedUrlBasic;
    });
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

  Future<void> _loadSavedEmpresa() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedEmpresa = await sharedPreferences.getString('empresa_id') ?? '';
    setState(() {
      empresaid = savedEmpresa;
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

  Future<void> loadData() async {
    // Utiliza Future.wait para buscar os dados de forma paralela
    await Future.wait([
      _loadSavedToken(),
      _loadSavedUrl(),
      _loadSavedUrlBasic(),
      _loadSavedEmpresa()
    ]);
    await Future.wait([fetchDataToday()]);
  }
}
