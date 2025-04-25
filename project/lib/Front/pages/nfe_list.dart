import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/Front/components/Login_Config/Elements/action_button.dart';
import 'package:project/Front/components/global/elements/calendar.dart';
import 'package:project/Front/components/global/elements/navbar_button.dart';
import 'package:project/Front/components/global/structure/navbar.dart';
import 'package:project/Front/components/style.dart';
import 'package:project/Front/pages/home_page.dart';
import 'package:project/Front/pages/nfe_details.dart';
import 'package:project/back/nfe_info_functions/payment_nfe.dart';
import 'package:project/back/sales_info_functions/company_list.dart';
import 'package:project/back/nfe_info_functions/nfe.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NfeList extends StatefulWidget {
  final selectDate;
  final flagDay;
  final flagPeriodic;
  final empresa_id;
  final empresa_nome;
  final codTipoNfe;
  final searchcontroller;

  const NfeList(
      {Key? key,
      this.selectDate,
      this.flagDay,
      this.flagPeriodic,
      this.empresa_id,
      this.empresa_nome,
      this.codTipoNfe,
      this.searchcontroller});

  @override
  State<NfeList> createState() => _NfeListState();
}

class _NfeListState extends State<NfeList> {
  bool isLoading = true;
  bool loadingNFeList = true;

  String urlBasic = '';
  String empresa_id = '';
  String empresa_nome = '';
  String codTipoNfe = '';
  String tipoNfe = '';
  String searchcontroller = '';

  NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'pt_BR', symbol: '');

  DateTime selectedDate = DateTime.now();
  int flagDay = 0;
  int flagPeriodic = 0;

  List<Nfe> nfe = [];
  List<CompanyList> company = [];
  List<DateTime?> selectDates = [DateTime.now()];

  final searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.selectDate != null) {
      setState(() {
        selectedDate = widget.selectDate;
      });
    }
    if (widget.flagDay != null) {
      setState(() {
        flagDay = widget.flagDay;
      });
    }
    if (widget.flagPeriodic != null) {
      setState(() {
        flagPeriodic = widget.flagPeriodic;
      });
    }
    if (widget.empresa_id != null) {
      setState(() {
        empresa_id = widget.empresa_id;
      });
    }
    if (widget.empresa_nome != null) {
      setState(() {
        empresa_nome = widget.empresa_nome;
      });
    }
    if (widget.codTipoNfe != null) {
      setState(() {
        codTipoNfe = widget.codTipoNfe;
      });
    }
    if (widget.searchcontroller != null) {
      setState(() {
        searchController.text = widget.searchcontroller;
      });
    }
    loadData();
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
                body: Column(
              children: [
                Navbar(text: 'Lista de Notas', children: [
                  NavbarButton(
                      destination: HomePage(),
                      Icons: Icons.arrow_back_ios_new_outlined)
                ]),
                SizedBox(
                  height: Style.height_10(context),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: Style.height_250(context),
                      padding: EdgeInsets.all(Style.height_12(context)),
                      child: SearchBar(
                        onSubmitted: (value) async {
                          loadingNFeList = true;
                          await fetchDataNFe(); // Chama a função de pesquisa ao pressionar "Enter"
                        },
                        controller: searchController,
                        textStyle: WidgetStatePropertyAll(
                            TextStyle(fontSize: Style.height_10(context))),
                        enabled: true,
                        leading: IconButton(
                          onPressed: () async {
                            var concat = selectDates.length == 2
                                ? "BETWEEN%20'${selectDates.map((date) => DateFormat('yyyy-MM-dd').format(date!)).join("'%20AND%20'").toString()}'"
                                : "LIKE%20'${selectDates.map((date) => DateFormat('yyyy-MM-dd').format(date!)).join("")}%25'";
                            await DataServiceNfe.fetchDataNfe(
                                context,
                                urlBasic,
                                empresa_id,
                                // selectedDate.year.toString(),
                                // selectedDate.month.toString(),
                                // selectedDate.day.toString(),
                                concat,
                                // flagDay,
                                // flagPeriodic,
                                _onProductAdded,
                                searchController.text,
                                codTipoNfe);

                            loadingNFeList = true;

                            setState(() {
                              fetchDataNFe();
                            });
                          },
                          icon: Icon(Icons.search),
                          color: Style.primaryColor,
                          iconSize: Style.height_30(context),
                        ),
                        hintText: 'Pesquise pelo Nº da nota',
                        hintStyle: WidgetStatePropertyAll(TextStyle(
                            fontSize: Style.height_10(context),
                            color: Style.quarantineColor)),
                        backgroundColor:
                            WidgetStatePropertyAll(Style.disabledColor),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: Style.height_15(context)),
                      width: Style.width_50(context),
                      child: IconButton(
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (context, setModalState) {
                                    return AlertDialog(
                                        content: Container(
                                      height: Style.height_300(context),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: Style.height_5(
                                                        context)),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Style.height_5(
                                                                context)),
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
                                                              Style
                                                                  .tertiaryColor)),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: Style.height_20(context),
                                          ),
                                          Container(
                                              alignment: Alignment.center,
                                              child: PopupMenuButton<String>(
                                                itemBuilder:
                                                    (BuildContext context) =>
                                                        buildMenuItems(company),
                                                onSelected: (value) async {
                                                  if (value != '') {
                                                    setState(() {
                                                      empresa_id = value;
                                                      // Busca o nome da empresa correspondente ao ID selecionado
                                                      final selectedCompany =
                                                          company.firstWhere(
                                                        (company) =>
                                                            company
                                                                .empresa_id ==
                                                            value,
                                                      );
                                                      empresa_nome = selectedCompany
                                                              ?.empresa_nome ??
                                                          ''; // Atualiza o nome
                                                    });
                                                    setModalState(() {
                                                      empresa_id = value;
                                                      // Busca o nome da empresa correspondente ao ID selecionado
                                                      final selectedCompany =
                                                          company.firstWhere(
                                                        (company) =>
                                                            company
                                                                .empresa_id ==
                                                            value,
                                                      );
                                                      empresa_nome = selectedCompany
                                                              ?.empresa_nome ??
                                                          ''; // Atualiza o nome
                                                    });
                                                  } else {
                                                    setModalState(() {
                                                      empresa_id = '';
                                                      empresa_nome = '';
                                                    });
                                                    setState(() {
                                                      empresa_id = '';
                                                      empresa_nome = '';
                                                    });
                                                  }
                                                },
                                                child: Text(
                                                  'Empresa',
                                                  style: TextStyle(
                                                    color: Style.secondaryColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Style.height_20(
                                                        context),
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow
                                                      .clip, // corta o texto no limite da largura
                                                  softWrap:
                                                      true, // permite a quebra de linha conforme necessário
                                                ),
                                              )),
                                          Text(
                                            empresa_nome,
                                            style: TextStyle(
                                                color: Style.secondaryColor,
                                                fontSize:
                                                    Style.height_8(context)),
                                          ),
                                          SizedBox(
                                            height: Style.height_20(context),
                                          ),
                                          Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  final selectedDates =
                                                      await showCalendarDialog(
                                                          context);
                                                  var concat = selectDates
                                                              .length ==
                                                          2
                                                      ? "BETWEEN%20'${selectDates.map((date) => DateFormat('yyyy-MM-dd').format(date!)).join("'%20AND%20'").toString()}'"
                                                      : "LIKE%20'${selectDates.map((date) => DateFormat('yyyy-MM-dd').format(date!)).join("")}%25'";
                                                  if (selectedDates != null) {
                                                    setModalState(() {
                                                      selectDates =
                                                          selectedDates;
                                                    });
                                                    setState(() {
                                                      selectDates =
                                                          selectedDates;
                                                    });
                                                  }
                                                },
                                                child: Text(
                                                  'Data/Período',
                                                  style: TextStyle(
                                                    color: Style.secondaryColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Style.height_20(
                                                        context),
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow
                                                      .clip, // corta o texto no limite da largura
                                                  softWrap:
                                                      true, // permite a quebra de linha conforme necessário
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  selectDates.isNotEmpty
                                                      ? selectDates
                                                          .map((date) =>
                                                              DateFormat(
                                                                      'dd/MM/yyyy')
                                                                  .format(
                                                                      date!))
                                                          .join(' - ')
                                                      : 'Selecione uma ou mais datas',
                                                  style: TextStyle(
                                                      fontSize: Style.height_8(
                                                          context),
                                                      color:
                                                          Style.secondaryColor),
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: Style.height_30(context),
                                          ),
                                          Container(
                                              alignment: Alignment.center,
                                              child: PopupMenuButton<String>(
                                                itemBuilder:
                                                    (BuildContext context) =>
                                                        CodRetornoMenuItems(),
                                                onSelected: (value) async {
                                                  if (value != '') {
                                                    setState(() {
                                                      codTipoNfe = value;
                                                      if (codTipoNfe == '100') {
                                                        setModalState(() {
                                                          tipoNfe =
                                                              'Autorizadas';
                                                        });
                                                        setState(() {
                                                          tipoNfe =
                                                              'Autorizadas';
                                                        });
                                                      } else if (codTipoNfe ==
                                                          '101') {
                                                        setModalState(() {
                                                          tipoNfe =
                                                              'Canceladas';
                                                        });
                                                        setState(() {
                                                          tipoNfe =
                                                              'Canceladas';
                                                        });
                                                      } else if (codTipoNfe ==
                                                          '110') {
                                                        setModalState(() {
                                                          tipoNfe =
                                                              'Uso Denegado';
                                                        });
                                                        setState(() {
                                                          tipoNfe =
                                                              'Uso Denegado';
                                                        });
                                                      } else if (codTipoNfe ==
                                                          'open') {
                                                        setModalState(() {
                                                          tipoNfe = 'Em aberto';
                                                        });
                                                        setState(() {
                                                          tipoNfe = 'Em aberto';
                                                        });
                                                      } else if (codTipoNfe ==
                                                          '') {
                                                        setModalState(() {
                                                          tipoNfe = '';
                                                        });
                                                        setState(() {
                                                          tipoNfe = '';
                                                        });
                                                      }
                                                    });
                                                  } else {
                                                    setState(() {
                                                      codTipoNfe = '';
                                                      tipoNfe = '';
                                                    });
                                                  }
                                                },
                                                child: Text(
                                                  // empresa_nome.isEmpty
                                                  //     ? 'Empresa'
                                                  //     : empresa_nome,
                                                  'Status da NFe',
                                                  style: TextStyle(
                                                    color: Style.secondaryColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Style.height_20(
                                                        context),
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow
                                                      .clip, // corta o texto no limite da largura
                                                  softWrap:
                                                      true, // permite a quebra de linha conforme necessário
                                                ),
                                              )),
                                          Text(
                                            tipoNfe,
                                            style: TextStyle(
                                                color: Style.secondaryColor,
                                                fontSize:
                                                    Style.height_8(context)),
                                          ),
                                          SizedBox(
                                            height: Style.height_10(context),
                                          ),
                                          Container(
                                            child: GestureDetector(
                                                onTap: () async {
                                                  setState(() {
                                                    loadingNFeList = true;
                                                  });
                                                  setModalState(
                                                    () {
                                                      _closeModal();
                                                      fetchDataNFe();
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  width:
                                                      Style.width_150(context),
                                                  alignment: Alignment.center,
                                                  padding: EdgeInsets.all(
                                                      Style.height_8(context)),
                                                  decoration: BoxDecoration(
                                                    color: Style.primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Style.height_10(
                                                                context)),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      // Icon(Icons.load),
                                                      Text(
                                                        'Atualizar',
                                                        style: TextStyle(
                                                            color: Style
                                                                .tertiaryColor,
                                                            fontSize:
                                                                Style.height_20(
                                                                    context),
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                          )
                                        ],
                                      ),
                                    ));
                                  },
                                );
                              });
                        },
                        icon: Icon(Icons.filter_list_alt),
                        color: Style.secondaryColor,
                        iconSize: Style.height_20(context),
                      ),
                    ),
                  ],
                ),
                if (loadingNFeList)
                  Expanded(
                    // height: Style.height_400(context),
                    child: Center(
                      child: Container(
                          height: Style.CircularProgressIndicatorWidth(context),
                          width: Style.CircularProgressIndicatorWidth(context),
                          child: CircularProgressIndicator(
                            strokeWidth:
                                Style.CircularProgressIndicatorSize(context),
                          )),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount: nfe.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NfeDetails(
                                  selectDate: selectedDate,
                                  flagDay: flagDay,
                                  flagPeriodic: flagPeriodic,
                                  empresa_id: empresa_id,
                                  empresa_nome: empresa_nome,
                                  codTipoNfe: codTipoNfe,
                                  searchcontroller: searchController.text,
                                  documentonfe_id: nfe[index].documentonfe_id,
                                  num_doc: nfe[index].num_doc,
                                  chv_nfe: nfe[index].chv_nfe,
                                  serie: nfe[index].serie,
                                  dt_doc: nfe[index].dt_doc,
                                  dt_e_s: nfe[index].dt_e_s,
                                  vl_doc: nfe[index].vl_doc,
                                  vl_desc: nfe[index].vl_desc,
                                  vl_merc: nfe[index].vl_merc,
                                  vl_frete: nfe[index].vl_frete,
                                  vl_bc_icms: nfe[index].vl_bc_icms,
                                  vl_icms: nfe[index].vl_icms,
                                  vl_bc_icms_st: nfe[index].vl_bc_icms_st,
                                  vl_icms_st: nfe[index].vl_icms_st,
                                  vl_ipi: nfe[index].vl_ipi,
                                  vl_cofins: nfe[index].vl_cofins,
                                  vl_pis_st: nfe[index].vl_pis_st,
                                  vl_pis: nfe[index].vl_pis,
                                  vl_cofins_st: nfe[index].vl_cofins_st,
                                  vl_ii: nfe[index].vl_ii,
                                  vl_out_da: nfe[index].vl_out_da,
                                  vl_seg: nfe[index].vl_seg,
                                  vl_icmsfecp: nfe[index].vl_icmsfecp,
                                  vl_icmsfecp_st: nfe[index].vl_icmsfecp_st,
                                  desc_nat_op: nfe[index].desc_nat_op,
                                  cod_mod: nfe[index].cod_mod,
                                  em_razaosocial: nfe[index].em_razaosocial,
                                  em_cnpj: nfe[index].em_cnpj,
                                  em_cpf: nfe[index].em_cpf,
                                  em_ie: nfe[index].em_ie,
                                  em_fone: nfe[index].em_fone,
                                  em_end: nfe[index].em_end,
                                  em_num: nfe[index].em_num,
                                  em_bairro: nfe[index].em_bairro,
                                  em_mun: nfe[index].em_mun,
                                  em_uf: nfe[index].em_uf,
                                  em_cep: nfe[index].em_cep,
                                  dest_razaosocial: nfe[index].dest_razaosocial,
                                  dest_cnpj: nfe[index].dest_cnpj,
                                  dest_cpf: nfe[index].dest_cpf,
                                  dest_end: nfe[index].dest_end,
                                  dest_num: nfe[index].dest_num,
                                  dest_cep: nfe[index].dest_cep,
                                  dest_bairro: nfe[index].dest_bairro,
                                  dest_mun: nfe[index].dest_mun,
                                  dest_fone: nfe[index].dest_fone,
                                  dest_ie: nfe[index].dest_ie,
                                  dest_uf: nfe[index].dest_uf,
                                  trans_razaosocial: nfe[index].trans_razaosocial,
                                  trans_cnpj: nfe[index].trans_cnpj,
                                  trans_cpf: nfe[index].trans_cpf,
                                  trans_ie: nfe[index].trans_ie,
                                  trans_fone: nfe[index].trans_fone,
                                  trans_end: nfe[index].trans_end,
                                  trans_num: nfe[index].trans_num,
                                  trans_mun: nfe[index].trans_mun,
                                  trans_uf: nfe[index].trans_uf,
                                  trans_cep: nfe[index].trans_cep,
                                  trans_placa: nfe[index].trans_placa,
                                  trans_placa_uf: nfe[index].trans_placa_uf,
                                  quant_volume: nfe[index].quant_volume,
                                  peso_liq: nfe[index].peso_liq,
                                  peso_bruto: nfe[index].peso_bruto,
                                  marca: nfe[index].marca,
                                  especie: nfe[index].especie,
                                  codigorastreio: nfe[index].codigorastreio,
                                  ind_frete: nfe[index].ind_frete,
                                  codigoretorno: nfe[index].codigoretorno,
                                  descricaoretorno: nfe[index].descricaoretorno,
                                  finalidade: nfe[index].finalidade,

                                  empresa_codigo: nfe[index].empresa_codigo,
                                  empresaNome: nfe[index].empresa_nome,
                                  mensagem: nfe[index].mensagem,

                                  xmldistribuicao: nfe[index].xmldistribuicao,
                                  //datahoraaut: nfe[index].datahoraaut,
                                ), 
                              ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(Style.height_8(context)),
                              decoration: BoxDecoration(
                                  border: Border.symmetric(
                                      horizontal: BorderSide(
                                          width: 1,
                                          color: Style.quarantineColor))),
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Número',
                                              style: TextStyle(
                                                  fontSize:
                                                      Style.height_8(context),
                                                  color: Style.quarantineColor),
                                            ),
                                            Text(
                                              (nfe[index].num_doc).toString(),
                                              style: TextStyle(
                                                  fontSize:
                                                      Style.height_12(context),
                                                  color: Style.primaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: Style.height_5(context),
                                            ),
                                            Text(
                                              'Status',
                                              style: TextStyle(
                                                  fontSize:
                                                      Style.height_8(context),
                                                  color: Style.quarantineColor),
                                            ),
                                            Text(
                                              (nfe[index].codigoretorno)
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize:
                                                      Style.height_12(context),
                                                  color: Style.primaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Série',
                                              style: TextStyle(
                                                  fontSize:
                                                      Style.height_8(context),
                                                  color: Style.quarantineColor),
                                            ),
                                            Text(
                                              (nfe[index].serie).toString(),
                                              style: TextStyle(
                                                  fontSize:
                                                      Style.height_12(context),
                                                  color: Style.primaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: Style.height_5(context),
                                            ),
                                            Text(
                                              'Retorno',
                                              style: TextStyle(
                                                  fontSize:
                                                      Style.height_8(context),
                                                  color: Style.quarantineColor),
                                            ),
                                            Container(
                                              width: Style.width_200(context),
                                              child: Text(
                                                (nfe[index].descricaoretorno)
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: Style.height_12(
                                                        context),
                                                    color: Style.primaryColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                softWrap: true,
                                                overflow: TextOverflow.clip,
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Data',
                                              style: TextStyle(
                                                  fontSize:
                                                      Style.height_8(context),
                                                  color: Style.quarantineColor),
                                            ),
                                            Text(
                                              DateFormat('dd/MM/yyyy').format(
                                                  DateTime.parse(
                                                      (nfe[index].dt_doc)
                                                          .toString())),
                                              style: TextStyle(
                                                  fontSize:
                                                      Style.height_12(context),
                                                  color: Style.primaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: Style.height_5(context),
                                            ),
                                            Text(
                                              'Valor',
                                              style: TextStyle(
                                                  fontSize:
                                                      Style.height_8(context),
                                                  color: Style.quarantineColor),
                                            ),
                                            Text(
                                              currencyFormat
                                                  .format(nfe[index].vl_doc)
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize:
                                                      Style.height_12(context),
                                                  color: Style.primaryColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  )
              ],
            )
                // ListView(
                //   children: [

                //     // SizedBox(
                //     //   height: Style.height_10(context),
                //     // ),
                //     // Container(
                //     //     decoration: BoxDecoration(
                //     //       color: Style.defaultColor,
                //     //       boxShadow: [
                //     //         BoxShadow(
                //     //           color: Colors.grey.withOpacity(0.15),
                //     //           spreadRadius: 5,
                //     //           blurRadius: 7,
                //     //           offset: Offset(0, 3),
                //     //         ),
                //     //       ],
                //     //     ),
                //     //     padding: EdgeInsets.all(Style.height_8(context)),
                //     //     child: Row(
                //     //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     //       crossAxisAlignment: CrossAxisAlignment.center,
                //     //       children: [],
                //     //     )),

                //   ],
                // ),
                ),
            onWillPop: () async {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
              return true;
            }));
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
        child: Text((companys.empresa_nome).toString()),
        key: Key(companys.empresa_nome.toString()),
      );
    }).toList();

    return staticItems + dynamicItems;
  }

  List<PopupMenuItem<String>> CodRetornoMenuItems() {
    List<PopupMenuItem<String>> staticItemsAll = [
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
    List<PopupMenuItem<String>> staticItems100 = [
      PopupMenuItem<String>(
        value: '100',
        child: Text('Autorizadas'),
      ),
    ];
    const PopupMenuDivider();
    List<PopupMenuItem<String>> staticItems101 = [
      PopupMenuItem<String>(
        value: '101',
        child: Text('Canceladas'),
      ),
    ];
    const PopupMenuDivider();
    List<PopupMenuItem<String>> staticItems110 = [
      PopupMenuItem<String>(
        value: '110',
        child: Text('Uso Denegado'),
      ),
    ];
    const PopupMenuDivider();
    List<PopupMenuItem<String>> staticItemsOpen = [
      PopupMenuItem<String>(
        value: 'open',
        child: Text('Em Aberto'),
      ),
    ];

    return staticItemsAll +
        staticItems100 +
        staticItems101 +
        staticItems110 +
        staticItemsOpen;
  }

  void _closeModal() {
    //Função para fechar o modal
    Navigator.of(context).pop();
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

  Future<void> loadData() async {
    await Future.wait([
      _loadSavedUrlBasic(),
    ]);

    if (urlBasic.isNotEmpty) {
      await Future.wait([fetchDataNFe()]);
      await Future.wait([fetchDataCompany()]);
    }
    // Todos os dados foram carregados, agora atualiza o estado para parar o carregamento
    setState(() {
      isLoading = false;
    });
  }

  void _onProductAdded() {
    setState(() {});
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

  Future<void> fetchDataNFe({bool? ascending}) async {
    var concat = '';
    print(selectDates.map((date) => DateFormat('yyyy-MM-dd').format(date!)));
    print('A'+DateFormat('(yyyy-MM-dd)').format(DateTime.now()));
    if (selectDates.length == 1 &&
        DateFormat('yyyy-MM-dd').format(selectDates.first!) ==
        DateFormat('yyyy-MM-dd').format(DateTime.now())) {
      setState(() {
        concat =
            "=%20'${selectDates.map((date) => DateFormat('yyyy-MM-dd').format(date!)).join("")}'";
      });
    } else if (selectDates.length == 1 &&
        selectDates != DateFormat('yyyy-MM-dd').format(DateTime.now())) {
      setState(() {
        concat =
            "LIKE%20'${selectDates.map((date) => DateFormat('yyyy-MM-dd').format(date!)).join("")}%25'";
      });
    } else if (selectDates.length == 2) {
      setState(() {
        concat =
            "BETWEEN%20'${selectDates.map((date) => DateFormat('yyyy-MM-dd').format(date!)).join("'%20AND%20'").toString()}'";
      });
    }
    // var concat = selectDates.length == 2
    //     ? "BETWEEN%20'${selectDates.map((date) => DateFormat('yyyy-MM-dd').format(date!)).join("'%20AND%20'").toString()}'"
    //     : "LIKE%20'${selectDates.map((date) => DateFormat('yyyy-MM-dd').format(date!)).join("")}%25'";
    List<Nfe>? fetchedData = await DataServiceNfe.fetchDataNfe(
        context,
        urlBasic,
        empresa_id,
        concat,
        _onProductAdded,
        searchController.text,
        codTipoNfe);

    if (fetchedData != null) {
      setState(() {
        nfe = fetchedData;
        // loadingPieChart = false;
        isLoading = false;
      });
    }
    setState(() {
      loadingNFeList = false;
    });
  }
}
