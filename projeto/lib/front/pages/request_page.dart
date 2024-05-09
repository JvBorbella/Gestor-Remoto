import 'package:flutter/material.dart';
import 'package:projeto/back/request_information.dart';
import 'package:projeto/front/components/global/elements/authorization_button.dart';
import 'package:projeto/front/components/global/elements/navbar_button.dart';
import 'package:projeto/front/components/global/structure/navbar.dart';
import 'package:projeto/front/components/global/structure/request_card.dart';
import 'package:projeto/front/components/requests/elements/delete_button.dart';
import 'package:projeto/front/components/requests/elements/informations.dart';
import 'package:projeto/front/components/requests/elements/text_requests.dart';
import 'package:projeto/front/components/style.dart';
import 'package:projeto/front/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RequestPage extends StatefulWidget {
  final token;
  final String url;
  final String urlBasic;

  const RequestPage({
    Key? key,
    this.token,
    this.url = '',
    this.urlBasic = '',
  }) : super(key: key);

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  late BuildContext modalContext;
  List<RequestInformation> requests = [];
  bool isLoading = true;

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
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: requests.isEmpty
              ? Column(
                  children: [
                    Navbar(children: [
                      NavbarButton(
                        destination: HomePage(),
                        Icons: Icons.arrow_back_ios_new,
                      ),
                    ], text: 'Solicitações'),
                    Expanded(
                        child: Center(
                      child: Text(
                        'Não há mais solicitações!',
                        style: TextStyle(
                          color: Style.quarantineColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ))
                  ],
                )
              : ListView(
                  children: [
                    Navbar(children: [
                      NavbarButton(
                        destination: HomePage(
                            // url: widget.url,
                            // token: widget.token,
                            ),
                        Icons: Icons.arrow_back_ios_new,
                      ),
                    ], text: 'Solicitações'),
                    SizedBox(
                      height: Style.height_10(context),
                    ),
                    Spacer(),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: requests.length,
                      itemBuilder: (context, index) {
                        TextEditingController _textController =
                            TextEditingController();
                        _textController.text = '';

                        void _openModalAuth(BuildContext context) {
                          //Código para abrir modal
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              modalContext = context;
                              return Container(
                                //Configurações de tamanho e espaçamento do modal
                                height: Style.ModalSize(context),
                                // width: double.maxFinite,
                                // padding:
                                //     EdgeInsets.all(Style.PaddingModal(context)),
                                child: Container(
                                  //Tamanho e espaçamento interno do modal
                                  height: Style.InternalModalSize(context),
                                  margin: EdgeInsets.only(
                                      left: Style.ModalMargin(context),
                                      right: Style.ModalMargin(context)),
                                  padding: EdgeInsets.all(
                                      Style.InternalModalPadding(context)),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Style.ModalBorderRadius(context))),
                                  child: Column(
                                    //Conteúdo interno do modal
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Deseja continuar com a liberação?',
                                            overflow: TextOverflow.clip, // corta o texto no limite da largura
                                            softWrap: true, // permite a quebra de linha conforme necessário
                                            style: TextStyle(
                                              fontSize:
                                                  Style.TextExitConfirmation(
                                                      context),
                                              color: Style.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Style.height_30(context),
                                      ),
                                      Row(
                                        //Espaçamento entre os Buttons
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          //Buttom de sair
                                          TextButton(
                                            onPressed: () async {
                                              if (_textController
                                                  .text.isEmpty) {
                                                await AcceptRequest
                                                    .acceptrequest(
                                                  context,
                                                  widget.url,
                                                  widget.urlBasic,
                                                  widget.token,
                                                  requests[index]
                                                      .liberacaoremotaId,
                                                  _textController.text,
                                                );
                                              }
                                              await AcceptRequest.acceptrequest(
                                                context,
                                                widget.url,
                                                widget.urlBasic,
                                                widget.token,
                                                requests[index]
                                                    .liberacaoremotaId,
                                                _textController.text,
                                              );
                                            },
                                            child: Container(
                                              height: Style.ButtonExitHeight(
                                                  context),
                                              padding: EdgeInsets.all(
                                                  Style.ButtonExitPadding(
                                                      context)),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(Style
                                                          .ButtonExitBorderRadius(
                                                              context)),
                                                  color: Style.primaryColor),
                                              child: Text(
                                                'Autorizar',
                                                style: TextStyle(
                                                  color: Style.tertiaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      Style.TextButtonExitSize(
                                                          context),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          //Buttom para fechar o modal
                                          TextButton(
                                            onPressed: () {
                                              _closeModal();
                                            },
                                            child: Container(
                                              // width: Style.ButtonCancelWidth(
                                              //     context),
                                              height: Style.ButtonCancelHeight(
                                                  context),
                                              padding: EdgeInsets.all(
                                                  Style.ButtonCancelPadding(
                                                      context)),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(Style
                                                        .ButtonExitBorderRadius(
                                                            context)),
                                                border: Border.all(
                                                    width: Style
                                                        .WidthBorderImageContainer(
                                                            context),
                                                    color:
                                                        Style.secondaryColor),
                                                color: Style.tertiaryColor,
                                              ),
                                              child: Text(
                                                'Cancelar',
                                                style: TextStyle(
                                                  color: Style.secondaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      Style.TextButtonExitSize(
                                                          context),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }

                        void _openModalReject(BuildContext context) {
                          //Código para abrir modal
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              modalContext = context;
                              return Container(
                                //Configurações de tamanho e espaçamento do modal
                                height: Style.ModalSize(context),
                                // width: double.maxFinite,
                                // padding:
                                //     EdgeInsets.all(Style.PaddingModal(context)),
                                child: Container(
                                  //Tamanho e espaçamento interno do modal
                                  height: Style.InternalModalSize(context),
                                  margin: EdgeInsets.only(
                                      left: Style.ModalMargin(context),
                                      right: Style.ModalMargin(context)),
                                  padding: EdgeInsets.all(
                                      Style.InternalModalPadding(context)),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Style.ModalBorderRadius(context))),
                                  child: Column(
                                    //Conteúdo interno do modal
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Deseja continuar com a rejeição?',
                                            overflow: TextOverflow.clip, // corta o texto no limite da largura
                                            softWrap: true, // permite a quebra de linha conforme necessário
                                            style: TextStyle(
                                              fontSize:
                                                  Style.TextExitConfirmation(
                                                      context),
                                              color: Style.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: Style.height_30(context),
                                      ),
                                      Row(
                                        //Espaçamento entre os Buttons
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          //Buttom de sair
                                          TextButton(
                                            onPressed: () async {
                                              await RejectRequest.rejectrequest(
                                                context,
                                                url,
                                                urlBasic,
                                                token,
                                                requests[index]
                                                    .liberacaoremotaId,
                                                _textController.text,
                                              );
                                            }, // Usando o valor
                                            child: Container(
                                              height: Style.ButtonExitHeight(
                                                  context),
                                              padding: EdgeInsets.all(
                                                  Style.ButtonExitPadding(
                                                      context)),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(Style
                                                          .ButtonExitBorderRadius(
                                                              context)),
                                                  color: Style.primaryColor),
                                              child: Text(
                                                'Não Autorizar',
                                                style: TextStyle(
                                                  color: Style.tertiaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      Style.TextButtonExitSize(
                                                          context),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                          //Buttom para fechar o modal
                                          TextButton(
                                            onPressed: () {
                                              _closeModal();
                                            },
                                            child: Container(
                                              // width: Style.ButtonCancelWidth(
                                              //     context),
                                              height: Style.ButtonCancelHeight(
                                                  context),
                                              padding: EdgeInsets.all(
                                                  Style.ButtonCancelPadding(
                                                      context)),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(Style
                                                        .ButtonExitBorderRadius(
                                                            context)),
                                                border: Border.all(
                                                    width: Style
                                                        .WidthBorderImageContainer(
                                                            context),
                                                    color:
                                                        Style.secondaryColor),
                                                color: Style.tertiaryColor,
                                              ),
                                              child: Text(
                                                'Cancelar',
                                                style: TextStyle(
                                                  color: Style.secondaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      Style.TextButtonExitSize(
                                                          context),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }

                        return RequestCard(
                          children: [
                            Container(
                              child: Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Informations(
                                              empresaNome:
                                                  requests[index].empresaNome,
                                              usuarioLogin:
                                                  requests[index].usuarioLogin,
                                              imagem: requests[index].imagem,
                                              urlBasic: urlBasic,
                                            ),
                                            DeleteButton(onPressed: () async {
                                              _openModalReject(context);
                                            } // Usando o valor
                                                )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Style.height_10(context),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: TextSolicitacion(
                                            text: requests[index].mensagem,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Style.height_10(context),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              label: Text('Resposta'),
                                              floatingLabelAlignment:
                                                  FloatingLabelAlignment.center,
                                            ),
                                            controller: _textController,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Style.height_30(context),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AuthorizationButton(
                                            text: 'Autorizar',
                                            onPressed: () async {
                                              _openModalAuth(context);
                                            } // Usando o valor do controlador específico
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  void _closeModal() {
    //Função para fechar o modal
    Navigator.of(modalContext).pop();
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
    await fetchData();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _refreshData() async {
    setState(() {
      isLoading = true;
      requests.clear(); // Limpa a lista de usuários antes de recarregar
    });
    await loadData();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchData() async {
    List<RequestInformation>? fetchedDataRequests =
        await DataService.fetchData(widget.token, widget.url);

    if (fetchedDataRequests != null) {
      setState(() {
        requests = fetchedDataRequests;
      });
    }
  }
}
