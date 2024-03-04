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
    // TODO: implement initState
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
        body: Container(
          child: ListView(
            children: [
              //Chamando a navbar e os elementos internos dela.
              Navbar(children: [
                //Chamando os elementos internos da navbar
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
              // Spacer para preencher o espaço entre Navbar e RequisitionCard
              Spacer(),
              //Chamando o card que receberá as informações do usuário
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: usuarios.length,
                itemBuilder: (context, index) {
                  return RequisitionCard(
                    children: [
                      Container(
                        //Propriedade Expanded adicionada dentro do card para fazer com que os elementos se distribuam conforme a largura do mesmo.
                        child: Expanded(
                          child: Column(
                            //Alinhamento interno
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //Chamando os elementos para dentro do card
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  //Chamando o código que armazenará as informações do usuário
                                  Informations(
                                    empresaNome: usuarios[index].empresaNome,
                                    usuarioLogin: usuarios[index].usuarioLogin,
                                    imagem: usuarios[index].imagem,
                                    urlBasic: widget.urlBasic,
                                  ),
                                  Delete(
                                    url: widget.url,
                                    token: widget.token,
                                    liberacaoremotaId: usuarios[index].liberacaoremotaId
                                  )
                                ],
                              ),
                              SizedBox(
                                height: Style.ContentInternalSpace,
                              ),
                              //Chamando o texto referente à solicitação
                              Row(
                                //Alinhamento
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  //Propriedade Expanded para que seja realizada a quebra de texto
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
                              //Chamando o button de autorização
                              Row(
                                //Alinhamento
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //Button para autorizar requisição
                                  LiberationButtom(
                                    text: 'Autorizar',
                                    liberacaoremotaId: usuarios[index].liberacaoremotaId,
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
    // Utiliza Future.wait para buscar os dados de forma paralela
    await Future.wait([fetchDatausuarios()]);
    // Todos os dados foram carregados, agora atualiza o estado para parar o carregamento
    setState(() {
      isLoading = false;
      // Verifica se os dados de solicitacoesremotas foram carregados corretamente
      if (usuarios.isEmpty) {
        usuarios == usuarios;
      }
    });
  }

  Future<void> _refreshData() async {
    // Aqui você pode chamar os métodos para recarregar os dados
    // Exemplo: await loadData();
    setState(() {
      isLoading =
          true; // Define isLoading como true para mostrar o indicador de carregamento
    });
    await loadData();
    setState(() {
      isLoading =
          false; // Define isLoading como false para parar o indicador de carregamento
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
