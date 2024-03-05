import 'package:flutter/material.dart';
import 'package:projeto/Back/Profiles-Requisitions.dart';
import 'package:projeto/Front/components/Global/Elements/Navbar-Button.dart';
import 'package:projeto/Front/components/Global/Elements/liberation-button.dart';
import 'package:projeto/Front/components/Solicitations/Elements/Text-Solicitacion.dart';
import 'package:projeto/Front/components/Solicitations/Elements/deleteButton.dart';
import 'package:projeto/Front/components/Solicitations/Elements/informations.dart';
import 'package:projeto/Front/components/Global/Estructure/navbar.dart';
import 'package:projeto/Front/components/Global/Estructure/requisition-card.dart';
import 'package:projeto/Front/components/Style.dart';
import 'package:projeto/Front/pages/home.dart';

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
  List<Usuarios> usuarios = [];
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
          child: usuarios.isEmpty
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
                      itemCount: usuarios.length,
                      itemBuilder: (context, index) {
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Informations(
                                              empresaNome:
                                                  usuarios[index].empresaNome,
                                              usuarioLogin:
                                                  usuarios[index].usuarioLogin,
                                              imagem: usuarios[index].imagem,
                                              urlBasic: widget.urlBasic,
                                            ),
                                            Delete(
                                                url: widget.url,
                                                token: widget.token,
                                                liberacaoremotaId:
                                                    usuarios[index]
                                                        .liberacaoremotaId)
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
                                            text: usuarios[index].mensagem,
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
                                        LiberationButtom(
                                          text: 'Autorizar',
                                          liberacaoremotaId:
                                              usuarios[index].liberacaoremotaId,
                                          url: widget.url,
                                          token: widget.token,
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
    await fetchDatausuarios();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _refreshData() async {
    setState(() {
      isLoading = true;
      usuarios.clear(); // Limpa a lista de usuários antes de recarregar
    });
    await loadData();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchDatausuarios() async {
    List<Usuarios>? fetchedDataUsuarios =
        await DataServiceUsuarios.fetchDataUsuarios(widget.token, widget.url);

    if (fetchedDataUsuarios != null) {
      setState(() {
        usuarios = fetchedDataUsuarios;
      });
    }
  }
}
