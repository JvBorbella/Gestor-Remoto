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
          child: CircularProgressIndicator(),
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
                        destination: HomePage(
                          // url: widget.url,
                          // token: widget.token,
                        ),
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
                      height: Style.ContentInternalSpace,
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
                                              await RejectRequest.rejectrequest(
                                                context,
                                                url,
                                                token,
                                                requests[index]
                                                    .liberacaoremotaId,
                                                _textController.text,
                                              );
                                            } // Usando o valor
                                                )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Style.ContentInternalSpace,
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
                                      height: 10,
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
                                      height: Style.ContentInternalButtonSpace,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AuthorizationButton(
                                            text: 'Autorizar',
                                            onPressed: () async {
                                              if (_textController
                                                  .text.isEmpty) {
                                                await AcceptRequest
                                                    .acceptrequest(
                                                  context,
                                                  widget.url,
                                                  widget.token,
                                                  requests[index]
                                                      .liberacaoremotaId,
                                                  _textController.text,
                                                );
                                              }
                                              await AcceptRequest.acceptrequest(
                                                context,
                                                widget.url,
                                                widget.token,
                                                requests[index]
                                                    .liberacaoremotaId,
                                                _textController.text,
                                              );
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
