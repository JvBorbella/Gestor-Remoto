import 'package:flutter/material.dart';
import 'package:projeto/Front/components/Style.dart';
import 'package:projeto/front/components/home/elements/modal_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String token = '';
  String login = '';
  String image = '';
  String url = '';
  String urlBasic = '';
  String email = '';

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

  void _closeDrawer() {
    //Função para fechar o modal
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Drawer(
        // width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Style.primaryColor,
                    ),
                    currentAccountPictureSize:
                        Size(MediaQuery.of(context).size.width * 0.8, 50),
                    currentAccountPicture: Container(
                      // padding: EdgeInsets.only(bottom: 30),
                      alignment: Alignment.topRight,
                      child: IconButton(
                        // padding: EdgeInsets.all(10),
                        onPressed: _closeDrawer,
                        icon: Icon(Icons.close),
                        style: ButtonStyle(
                          iconColor:
                              MaterialStatePropertyAll(Style.tertiaryColor),
                        ),
                      ),
                    ),
                    accountEmail: Row(
                      children: [
                        Container(
                          child: ModalButton(),
                          width: 50,
                        )
                      ],
                    ),
                    accountName: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 70,
                          // decoration: BoxDecoration(shape: BoxShape.circle),
                          child: ClipOval(
                            child: image.isNotEmpty
                                ? Image.network(
                                    urlBasic + image,
                                    alignment: Alignment.center,
                                    fit: BoxFit.fill,
                                    filterQuality: FilterQuality.high,
                                  ) // Exibe a imagem
                                : Image.network(
                                    'https://cdn-icons-png.flaticon.com/512/4519/4519678.png',
                                    color: Style.tertiaryColor,
                                    alignment: Alignment.center,
                                    fit: BoxFit.fill,
                                    filterQuality: FilterQuality.high,
                                  ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Olá, ' + login + '!',
                              style: TextStyle(
                                fontFamily: 'Poppins-Medium',
                              ),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              email,
                              style: TextStyle(
                                fontFamily: 'Poppins-Medium',
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListBody(
              children: [
                Container(
                  // padding: EdgeInsets.only(left: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigator.of(context)
                          //     .push(MaterialPageRoute(
                          //   builder: (context) => HomePage()));
                        },
                        child: Text(
                          'Promoções',
                          style: TextStyle(
                              color: Style.primaryColor,
                              fontSize: 15,
                              fontFamily: 'Poppins-Medium'),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigator.of(context)
                          //     .push(MaterialPageRoute(
                          //   builder: (context) => HomePage()));
                        },
                        child: Text(
                          'Produtos negativos',
                          style: TextStyle(
                              color: Style.primaryColor,
                              fontSize: 15,
                              fontFamily: 'Poppins-Medium'),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigator.of(context)
                          //     .push(MaterialPageRoute(
                          //   builder: (context) => HomePage()));
                        },
                        child: Text(
                          'Funcionários escalados',
                          style: TextStyle(
                              color: Style.primaryColor,
                              fontSize: 15,
                              fontFamily: 'Poppins-Medium'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
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
}
