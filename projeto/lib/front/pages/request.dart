import 'package:flutter/material.dart';
import 'package:projeto/back/request_information.dart';
import 'package:projeto/front/components/Global/Elements/navbar_button.dart';
import 'package:projeto/front/components/Global/Elements/button_autorization.dart';
import 'package:projeto/front/components/requests/Elements/text_request.dart';
import 'package:projeto/front/components/requests/Elements/delete_button.dart';
import 'package:projeto/front/components/requests/Elements/informations.dart';
import 'package:projeto/front/components/Global/Estructure/navbar.dart';
import 'package:projeto/front/components/Global/Estructure/request_card.dart';
import 'package:projeto/front/components/Style.dart';
import 'package:projeto/front/pages/home.dart';

class Solicitacion extends StatefulWidget {
  final token;
  final String url;
  final String urlBasic;

  const Solicitacion({
    Key? key,
    this.token,
    this.url = '',
    this.urlBasic = '',
  }) : super(key: key);

  @override
  State<Solicitacion> createState() => _SolicitacionState();
}

class _SolicitacionState extends State<Solicitacion> {
  List<RequestInformation> requests = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
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
                      ButtonNavbar(
                        destination: Home(
                          url: widget.url,
                          token: widget.token,
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
                      ButtonNavbar(
                        destination: Home(
                          url: widget.url,
                          token: widget.token,
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
                        return RequisitionCard(
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
                                              urlBasic: widget.urlBasic,
                                            ),
                                            Delete(onPressed: () async {
                                              await RejectRequest.rejectrequest(
                                                context,
                                                widget.url,
                                                widget.token,
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
                                          // child: Input(
                                          //   text: 'Resposta',
                                          //   type: TextInputType.text,
                                          //   controller:
                                          //       _textController, // Usando um controlador diferente para cada campo de entrada
                                          // ),
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
                                        LiberationButtom(
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
