import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/back/product/stock_consult.dart';
import 'package:project/back/sales_info_functions/company_list.dart';
import 'package:project/front/components/global/elements/navbar_button.dart';
import 'package:project/front/components/global/structure/navbar.dart';
import 'package:project/front/components/global/structure/request_card.dart';
import 'package:project/front/components/nfe/structure/primary_card.dart';
import 'package:project/front/components/style.dart';
import 'package:project/front/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EstoquePage extends StatefulWidget {
  const EstoquePage({super.key});

  @override
  State<EstoquePage> createState() => _EstoquePageState();
}

final searchController = TextEditingController();
bool flagClear = false;

class _EstoquePageState extends State<EstoquePage> {
  String urlBasic = '';
  String empresa_id = '';
  List<StockConsult> stock = [];
  Map<String, List<StockConsult>> groupedStock = {};
  List<CompanyList> company = [];
  bool isLoading = true;
  bool loadStock = false;

  String empresaid = '';
  String empresa_nome = '';
  String empresa_codigo = '';

  NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'pt_BR', symbol: '');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    print(empresa_id);
  }

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
              body: stock.isEmpty
                  ? Column(
                      children: [
                        Navbar(text: 'Consulta Estoque', children: [
                          NavbarButton(
                            Icons: Icons.arrow_back_ios_new_rounded,
                            //volta: 'volta',
                            destination: HomePage(),
                          ),
                          SizedBox(
                            height: Style.height_15(context),
                          ),
                        ]),
                        Container(
                          padding: EdgeInsets.all(Style.height_15(context)),
                          child: TextField(
                            onSubmitted: (value) async {
                              setState(() {
                                loadStock = true;
                              });
                              await fetchDataStock();
                            },
                            controller: searchController,
                            style:
                                TextStyle(fontSize: Style.height_15(context)),
                            enabled: true,
                            onChanged: (searchController) {
                              print(searchController);
                              if (searchController == '') {
                                setState(() {
                                  flagClear = false;
                                });
                              } else {
                                setState(() {
                                  flagClear = true;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: IconButton(
                                padding:
                                    EdgeInsets.all(Style.height_2(context)),
                                onPressed: () async {
                                  setState(() {
                                    loadStock = true;
                                  });
                                  await fetchDataStock();
                                },
                                icon: Icon(Icons.search),
                                color: Style.primaryColor,
                                iconSize: Style.height_30(context),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  searchController.clear();
                                  setState(() {
                                    flagClear = false;
                                  });
                                },
                                icon: Icon(Icons.backspace_rounded),
                                color: flagClear == true
                                    ? Style.errorColor
                                    : Colors.transparent,
                                iconSize: Style.height_15(context),
                              ),
                              hintText: 'Pesquise pelo código do produto',
                              hintStyle: TextStyle(
                                  fontSize: Style.height_15(context),
                                  color: Style.quarantineColor),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset("assets/images/robot.png"),
                                  SizedBox(
                                    height: Style.height_5(context),
                                  ),
                                  if (loadStock == false)
                                    Text(
                                      'Busque pelo código do produto',
                                      style: TextStyle(
                                          color: Style.primaryColor,
                                          fontSize: Style.height_15(context)),
                                      textAlign: TextAlign.center,
                                    )
                                  else
                                    Container(
                                      width: Style.width_100(context),
                                      child: LinearProgressIndicator(
                                        color: Style.primaryColor,
                                        minHeight: Style.height_2(context),
                                        year2023: false,
                                      ),
                                    )
                                ]),
                          ),
                        )
                      ],
                    )
                  : ListView(
                      children: [
                        Navbar(text: 'Consulta Estoque', children: [
                          NavbarButton(
                            Icons: Icons.arrow_back_ios_new_rounded,
                            //volta: 'volta',
                            destination: HomePage(),
                          ),
                          SizedBox(
                            height: Style.height_15(context),
                          ),
                        ]),
                        Container(
                          padding: EdgeInsets.all(Style.height_12(context)),
                          child: TextField(
                            onSubmitted: (value) async {
                              await fetchDataStock();
                            },
                            controller: searchController,
                            enabled: true,
                            style:
                                TextStyle(fontSize: Style.height_15(context)),
                            onChanged: (searchController) {
                              print(searchController);
                              if (searchController == '') {
                                setState(() {
                                  flagClear = false;
                                });
                              } else {
                                setState(() {
                                  flagClear = true;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: IconButton(
                                padding:
                                    EdgeInsets.all(Style.height_2(context)),
                                onPressed: () async {
                                  await fetchDataStock();
                                },
                                icon: Icon(Icons.search),
                                color: Style.primaryColor,
                                iconSize: Style.height_30(context),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  searchController.clear();
                                  setState(() {
                                    flagClear = false;
                                  });
                                },
                                icon: Icon(Icons.backspace_rounded),
                                color: flagClear == true
                                    ? Style.errorColor
                                    : Colors.transparent,
                                iconSize: Style.height_15(context),
                              ),
                              hintText: 'Pesquise pelo código do produto',
                              hintStyle: TextStyle(
                                  fontSize: Style.height_15(context),
                                  color: Style.quarantineColor),
                            ),
                          ),
                        ),
                        RequestCard(children: [
                          Container(
                              width: Style.width_250(context),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // stock.first.imagem_url == null
                                      //     ?
                                      Image.asset(
                                        'assets/images/product/Barcode.png',
                                        fit: BoxFit.cover,
                                      )
                                      // : Image.network(
                                      //     'https://storagearchive.s3.sa-east-1.amazonaws.com/ideiatech/products/thumb/683aab3e-cd62-4b70-8da3-aefe7c719393.png',
                                      //     fit: BoxFit
                                      //         .contain, // ou BoxFit.contain, BoxFit.fill, etc., dependendo do layout desejado
                                      //   )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Cód. - ${stock!.first.codigo}',
                                            style: TextStyle(
                                                color: Style.primaryColor,
                                                fontSize:
                                                    Style.height_10(context),
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.start,
                                            softWrap: true,
                                            overflow: TextOverflow.clip,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: Style.width_150(context),
                                            child: Text(
                                              'Desc. - ${stock!.first.nome}',
                                              style: TextStyle(
                                                  color: Style.primaryColor,
                                                  fontSize:
                                                      Style.height_10(context),
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left,
                                              softWrap: true,
                                              overflow: TextOverflow.clip,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Pr.Venda - ${currencyFormat.format(stock!.first.tpreco01)}',
                                            style: TextStyle(
                                                color: Style.primaryColor,
                                                fontSize:
                                                    Style.height_10(context),
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                            softWrap: true,
                                            overflow: TextOverflow.clip,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Pr. Custo - ${currencyFormat.format(stock!.first.tcusto01)}',
                                            style: TextStyle(
                                                color: Style.primaryColor,
                                                fontSize:
                                                    Style.height_10(context),
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                            softWrap: true,
                                            overflow: TextOverflow.clip,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Un. - ${stock.first.abreviacao}',
                                            style: TextStyle(
                                                color: Style.primaryColor,
                                                fontSize:
                                                    Style.height_10(context),
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                            softWrap: true,
                                            overflow: TextOverflow.clip,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            width: Style.width_150(context),
                                            child: Text(
                                              'Gp. Trib. - ${stock.first.nome_3}',
                                              style: TextStyle(
                                                  color: Style.primaryColor,
                                                  fontSize:
                                                      Style.height_10(context),
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left,
                                              softWrap: true,
                                              overflow: TextOverflow.clip,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Peso Líq. - ${stock!.first.pesoliquido}',
                                            style: TextStyle(
                                                color: Style.primaryColor,
                                                fontSize:
                                                    Style.height_10(context),
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                            softWrap: true,
                                            overflow: TextOverflow.clip,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ))
                        ]),
                        SizedBox(
                          height: Style.height_5(context),
                        ),
                        Container(
                          padding: EdgeInsets.all(Style.height_15(context)),
                          margin:
                              EdgeInsets.only(bottom: Style.height_20(context)),
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
                                      buildMenuItems(company),
                                  onSelected: (value) async {
                                    if (value != '') {
                                      setState(() {
                                        empresa_id = value;
                                        // Busca o nome da empresa correspondente ao ID selecionado
                                        final selectedCompany =
                                            company.firstWhere(
                                          (company) =>
                                              company.empresa_id == value,
                                        );
                                        empresa_nome =
                                            selectedCompany?.empresa_nome ??
                                                ''; // Atualiza o nome
                                        empresa_codigo =
                                            selectedCompany?.empresa_codigo ??
                                                ''; // Atualiza o nome
                                      });
                                      fetchDataStock();
                                    } else {
                                      setState(() {
                                        empresa_id = '';
                                        empresa_nome = '';
                                        empresa_codigo = '';
                                      });
                                      fetchDataStock();
                                    }
                                  },
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.filter_list_outlined,
                                          color: Style.primaryColor,
                                          size: Style.height_20(context),
                                        ),
                                        SizedBox(
                                          width: Style.height_5(context),
                                        ),
                                        Text(
                                          empresa_nome.isEmpty
                                              ? 'Filtro de empresa'
                                              : '',
                                          style: TextStyle(
                                              fontSize:
                                                  Style.height_12(context)),
                                        ),
                                        Container(
                                          width: Style.width_180(context),
                                          child: Text(
                                            '${empresa_codigo} ${empresa_nome}',
                                            style: TextStyle(
                                              color: Style.secondaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                                  Style.height_12(context),
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
                          height: Style.height_5(context),
                        ),
                        ..._buildGroupedCards(),
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

  Future<void> _loadSavedEmpresa() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedEmpresa = await sharedPreferences.getString('empresa_id') ?? '';
    setState(() {
      empresa_id = savedEmpresa;
    });
  }

  Future<void> fetchDataStock({bool? ascending}) async {
    List<StockConsult>? fetchedData =
        await DataServiceStockConsult.fetchDataStockConsult(
      context,
      urlBasic,
      empresa_id,
      searchController.text,
    );

    if (fetchedData != null) {
      setState(() {
        stock = fetchedData;
      });
    }
    setState(() {
      loadStock = false;
    });
  }

  Future<void> loadData() async {
    await Future.wait([
      _loadSavedUrlBasic(),
      _loadSavedEmpresa(),
    ]);
    await Future.wait([fetchDataCompany()]);

    searchController.clear();

    // if (urlBasic.isNotEmpty) {
    //   await Future.wait([fetchDataStock()]);
    // }
    // Todos os dados foram carregados, agora atualiza o estado para parar o carregamento
    setState(() {
      isLoading = false;
    });
  }

  /// Agrupa e constrói os PrimaryCards
  List<Widget> _buildGroupedCards() {
    final Map<String, List<StockConsult>> grouped = {};

    for (var item in stock!) {
      grouped.putIfAbsent(item.empresa_codigo!, () => []).add(item);
    }

    return grouped.entries.map((entry) {
      final empresa = entry.key;
      final items = entry.value;
      final empresaNome = items.first.empresa_nome;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              'Empresa - ${empresa}, ${empresaNome}',
              style: TextStyle(
                  color: Style.primaryColor,
                  fontSize: Style.height_12(context),
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              softWrap: true,
              overflow: TextOverflow.clip,
            ),
          ),
          PrimaryCard(children: [
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      // height: Style.height_150(context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: items.map((item) {
                          return Container(
                            alignment: Alignment.topLeft,
                            width: Style.width_180(context),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${item.codigo_2} - ${item.nome_2}',
                                  style: TextStyle(
                                      color: Style.tertiaryColor,
                                      fontSize: Style.height_12(context),
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                  overflow: TextOverflow.clip,
                                ),
                                Text(
                                  'Qntd. Em estoque: ${item.quantidade}',
                                  style: TextStyle(
                                    color: Style.tertiaryColor,
                                    fontSize: Style.height_10(context),
                                    //fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                  overflow: TextOverflow.clip,
                                ),
                                SizedBox(
                                  height: Style.height_10(context),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Est. Mínimo',
                          style: TextStyle(
                            color: Style.tertiaryColor,
                            fontSize: Style.height_10(context),
                            //fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                        Text(
                          '${items.first.estoqueminimo}',
                          style: TextStyle(
                              color: Style.tertiaryColor,
                              fontSize: Style.height_10(context),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(
                          height: Style.height_2(context),
                        ),
                        Text(
                          'Ponto de Pedido',
                          style: TextStyle(
                            color: Style.tertiaryColor,
                            fontSize: Style.height_10(context),
                            //fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                        Text(
                          '${items.first.estoquepontopedido}',
                          style: TextStyle(
                              color: Style.tertiaryColor,
                              fontSize: Style.height_10(context),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(
                          height: Style.height_2(context),
                        ),
                        Text(
                          'Est. Máximo',
                          style: TextStyle(
                            color: Style.tertiaryColor,
                            fontSize: Style.height_10(context),
                            //fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                        Text(
                          '${items.first.estoquemaximo}',
                          style: TextStyle(
                              color: Style.tertiaryColor,
                              fontSize: Style.height_10(context),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(
                          height: Style.height_2(context),
                        ),
                        Text(
                          'Dt. Últ. Venda',
                          style: TextStyle(
                            color: Style.tertiaryColor,
                            fontSize: Style.height_10(context),
                            //fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                        Text(
                          items.first.dataultimavenda == null
                              ? ''
                              : '${DateFormat('dd/MM/yyyy').format(items.first.dataultimavenda)}',
                          style: TextStyle(
                              color: Style.tertiaryColor,
                              fontSize: Style.height_10(context),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                        SizedBox(
                          height: Style.height_2(context),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          items.first.classificacaoabc!.isNotEmpty
                              ? 'Classificação - ${items.first.classificacaoabc}'
                              : 'Sem classificação',
                          style: TextStyle(
                              color: Style.tertiaryColor,
                              fontSize: Style.height_12(context),
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                          softWrap: true,
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ]),
          SizedBox(height: 12),
        ],
      );
    }).toList();
  }

  Future<void> fetchDataCompany({bool? ascending}) async {
    List<CompanyList>? fetchedData = await DataServiceCompany.fetchDataCompany(
      context,
      urlBasic,
    );

    if (fetchedData != null) {
      setState(() {
        company = fetchedData;
        isLoading = false;
      });
    }
  }

  List<PopupMenuItem<String>> buildMenuItems(List<CompanyList> companyList) {
    List<PopupMenuItem<String>> staticItems = [
      PopupMenuItem(
          enabled: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: Style.height_5(context)),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Style.height_5(context)),
                    color: Style.errorColor),
                child: IconButton(
                  onPressed: () {
                    _closeModal();
                  },
                  icon:
                      Image.asset('assets/images/icon_remove/icon_remove.png'),
                  style: ButtonStyle(
                      iconColor: WidgetStatePropertyAll(Style.tertiaryColor)),
                ),
              ),
            ],
          )),
      PopupMenuItem<String>(
        value: '',
        child: Text('Todos'),
      ), // Divisor
    ];
    const PopupMenuDivider();

    List<PopupMenuItem<String>> dynamicItems = companyList.map((companys) {
      return PopupMenuItem<String>(
        value: companys.empresa_id,
        child: Text(('${companys.empresa_codigo} - ${companys.empresa_nome}')
            .toString()),
        key: Key(companys.empresa_nome.toString()),
      );
    }).toList();

    const PopupMenuDivider();

    return staticItems + dynamicItems;
  }

  void _closeModal() {
    //Função para fechar o modal
    Navigator.of(context).pop();
  }
}
