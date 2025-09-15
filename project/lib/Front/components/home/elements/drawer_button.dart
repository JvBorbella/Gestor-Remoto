import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:project/Front/pages/nfe_list.dart';
import 'package:project/Front/pages/ocurrences_page.dart';
import 'package:project/Front/pages/sales_graphic.dart';
import 'package:project/back/sales_info_functions/sales_monitor.dart';
import 'package:project/front/components/style.dart';
import 'package:project/front/components/home/elements/modal_button.dart';
import 'package:project/front/pages/consult.dart';
import 'package:project/front/pages/estoque.dart';
import 'package:project/main.dart';
import 'package:project/services/foreground_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
      ),
      dark: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      // overrideMode: AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Adaptive Theme Demo',
        theme: theme,
        darkTheme: darkTheme,
        home: const CustomDrawer(),
      ),
      debugShowFloatingThemeButton: true,
    );
  }
}

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

  String empresaid = '';
  String cpf = '';

  bool flagNotify = true;
  bool _isExpandedConfig = false;
  bool _isExpandedMonit = false;
  bool _isExpandedConsult = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadSavedUrl();
    _loadSavedToken();
    _loadSavedLogin();
    _loadSavedImage();
    _loadSavedUrlBasic();
    _loadSavedEmail();
    _loadSavedFlagNotify();
  }

  void _closeDrawer() {
    //Função para fechar o modal
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: WillPopScope(
            child: Drawer(
                // width: MediaQuery.of(context).size.width * 0.8,
                child: ListView(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        // height: Style.DrawerHeaderSize(context),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary),
                        child: Container(
                          padding: EdgeInsets.all(Style.height_15(context)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: _closeDrawer,
                                    icon: Icon(Icons.close),
                                    iconSize:
                                        Style.IconCloseDrawerSize(context),
                                    alignment: Alignment.topRight,
                                    style: ButtonStyle(
                                      iconColor: WidgetStatePropertyAll(
                                          Style.tertiaryColor),
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height: Style.SalesCardSpace(context),
                              // ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(
                                              left: Style.height_25(context))),
                                      Container(
                                        width: Style.AccountNameWidth(context),
                                        height: Style.AccountNameWidth(context),
                                        // decoration: BoxDecoration(shape: BoxShape.circle),
                                        child: ClipOval(
                                          child: image.isNotEmpty
                                              ? Image.network(
                                                  urlBasic + image,
                                                  alignment:
                                                      Alignment.topCenter,
                                                  fit: BoxFit.cover,
                                                  filterQuality:
                                                      FilterQuality.high,
                                                ) // Exibe a imagem
                                              : Image.asset(
                                                  'assets/images/icon_person/icon_person.png',
                                                  color: Style.tertiaryColor,
                                                  alignment:
                                                      Alignment.topCenter,
                                                  fit: BoxFit.cover,
                                                  filterQuality:
                                                      FilterQuality.high,
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: Style.height_10(context),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Olá, $login!',
                                            style: TextStyle(
                                              fontFamily: 'Poppins-Medium',
                                              fontSize:
                                                  Style.LoginFontSize(context),
                                              color: Style.tertiaryColor,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            email,
                                            style: TextStyle(
                                              fontFamily: 'Poppins-Medium',
                                              fontSize:
                                                  Style.EmailFontSize(context),
                                              color: Style.tertiaryColor,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: Style.ModalButtonSpace(context),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    child: ModalButton(),
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Style.height_5(context),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isExpandedConfig = !_isExpandedConfig;
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: Style.height_10(context)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: Style.height_10(context),
                                    ),
                                    Row(
                                      children: [
                                        if (_isExpandedConfig)
                                          Transform.rotate(
                                            angle:
                                                3.1416, // 180 graus em radianos (π)
                                            child: Icon(
                                              Icons.arrow_drop_down_outlined,
                                              size: Style.height_20(context),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          )
                                        else
                                          Icon(
                                            Icons.arrow_drop_down_outlined,
                                            size: Style.height_20(context),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        SizedBox(
                                          width: Style.width_10(context),
                                        ),
                                        Text(
                                          'Configurações',
                                          style: TextStyle(
                                              fontSize:
                                                  Style.height_15(context),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Style.height_10(context),
                                    ),
                                    AnimatedContainer(
                                      padding: EdgeInsets.only(
                                          left: Style.height_12(context)),
                                      duration: Duration(milliseconds: 300),
                                      // height: _isExpanded
                                      //     ? Style.height_50(context)
                                      //     : 0,
                                      child: Visibility(
                                          visible: _isExpandedConfig,
                                          maintainAnimation: true,
                                          maintainState: true,
                                          maintainSize: false,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Checkbox(
                                                    activeColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                    value: flagNotify,
                                                    onChanged: (value) async {
                                                      setState(() {
                                                        flagNotify = value!;
                                                      });
                                                      SharedPreferences
                                                          sharedPreferences =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      await sharedPreferences
                                                          .setBool('flagNotify',
                                                              flagNotify);
                                                      if (flagNotify == true) {
                                                        // startForegroundService();
                                                        _configureWorkmanager();
                                                      }
                                                    },
                                                  ),
                                                  Text(
                                                    'Ativar Notificações',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      fontSize: Style.height_12(
                                                          context),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Switch(
                                                    trackOutlineColor: MaterialStatePropertyAll(
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .secondary),
                                                    inactiveThumbColor: Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                    activeColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                    value: AdaptiveTheme.of(
                                                                context)
                                                            .mode
                                                            .isDark ??
                                                        false,
                                                    onChanged: (value) {
                                                      if (value) {
                                                        AdaptiveTheme.of(
                                                                context)
                                                            .setDark();
                                                      } else {
                                                        AdaptiveTheme.of(
                                                                context)
                                                            .setLight();
                                                      }
                                                    },
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    'Tema escuro',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                      fontSize: Style.height_12(
                                                          context),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Style.height_15(context),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isExpandedMonit = !_isExpandedMonit;
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: Style.height_10(context)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        if (_isExpandedMonit)
                                          Transform.rotate(
                                            angle:
                                                3.1416, // 180 graus em radianos (π)
                                            child: Icon(
                                              Icons.arrow_drop_down_outlined,
                                              size: Style.height_20(context),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          )
                                        else
                                          Icon(
                                            Icons.arrow_drop_down_outlined,
                                            size: Style.height_20(context),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        SizedBox(
                                          width: Style.width_10(context),
                                        ),
                                        Text(
                                          'Monitores',
                                          style: TextStyle(
                                              fontSize:
                                                  Style.height_15(context),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Style.height_10(context),
                                    ),
                                    AnimatedContainer(
                                      padding: EdgeInsets.only(
                                          left: Style.height_12(context),
                                          top: Style.height_2(context)),
                                      duration: Duration(milliseconds: 1200),
                                      // height: _isExpanded
                                      //     ? Style.height_50(context)
                                      //     : 0,
                                      child: Visibility(
                                          visible: _isExpandedMonit,
                                          maintainAnimation: true,
                                          maintainState: true,
                                          maintainSize: false,
                                          child: Column(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextButton(
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          OcurrencesPage()));
                                                    },
                                                    child: Text(
                                                      'Lista de ocorrências',
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            Style.height_12(
                                                                context),
                                                        fontFamily:
                                                            'Poppins-Medium',
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        Style.height_5(context),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          SalesGraphic()));
                                                    },
                                                    child: Text(
                                                      'Dados de vendas',
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              Style.height_12(
                                                                  context),
                                                          fontFamily:
                                                              'Poppins-Medium'),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        Style.height_5(context),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          NfeList()));
                                                    },
                                                    child: Text(
                                                      'Lista de NFe',
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .secondary,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              Style.height_12(
                                                                  context),
                                                          fontFamily:
                                                              'Poppins-Medium'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Style.height_15(context),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isExpandedConsult = !_isExpandedConsult;
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: Style.height_10(context)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        if (_isExpandedConsult)
                                          Transform.rotate(
                                            angle:
                                                3.1416, // 180 graus em radianos (π)
                                            child: Icon(
                                              Icons.arrow_drop_down_outlined,
                                              size: Style.height_20(context),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          )
                                        else
                                          Icon(
                                            Icons.arrow_drop_down_outlined,
                                            size: Style.height_20(context),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                        SizedBox(
                                          width: Style.width_10(context),
                                        ),
                                        Text(
                                          'Consultas',
                                          style: TextStyle(
                                              fontSize:
                                                  Style.height_15(context),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Style.height_10(context),
                                    ),
                                    AnimatedContainer(
                                      padding: EdgeInsets.only(
                                          left: Style.height_12(context),
                                          top: Style.height_2(context)),
                                      duration: Duration(milliseconds: 1200),
                                      // height: _isExpanded
                                      //     ? Style.height_50(context)
                                      //     : 0,
                                      child: Visibility(
                                          visible: _isExpandedConsult,
                                          maintainAnimation: true,
                                          maintainState: true,
                                          maintainSize: false,
                                          child: Column(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextButton(
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          EstoquePage()));
                                                    },
                                                    child: Text(
                                                      'Consultar Estoque',
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            Style.height_12(
                                                                context),
                                                        fontFamily:
                                                            'Poppins-Medium',
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        Style.height_5(context),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ConsultPage()));
                                                    },
                                                    child: Text(
                                                      'Consultar Crédito',
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .secondary,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize:
                                                            Style.height_12(
                                                                context),
                                                        fontFamily:
                                                            'Poppins-Medium',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
            onWillPop: () async {
              _closeDrawer();
              return true;
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

  Future<void> _loadSavedFlagNotify() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool savedFlagNotify = sharedPreferences.getBool('flagNotify') ??
        true; // Carrega o valor salvo (padrão: true)
    setState(() {
      flagNotify = savedFlagNotify; // Atualiza o estado com o valor salvo
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

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await Firebase.initializeApp(); // Inicializa o Firebase aqui
    print('Chamando workManager');

    // await fetchDataInBackground(NotifyService());
    await _firebaseMessagingBackgroundHandler(RemoteMessage());
    return Future.value(true);
  });
}

void _configureWorkmanager() async {
  await Firebase
      .initializeApp(); // Certifique-se de que o Firebase está inicializado

  await Workmanager().cancelAll();

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false, // Mantenha como true para depuração
  );

  Workmanager().registerPeriodicTask(
      'fetchDataInBackground', 'fetchDataInBackground',
      frequency: Duration(minutes: 15), initialDelay: Duration(minutes: 15));

  print("Workmanager configurado e tarefa registrada.");
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(
      "Mensagem recebida no background title: ${message.notification?.title}");
  print("Mensagem recebida no background body: ${message.notification?.body}");

  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String url = prefs.getString('url') ?? '';
    bool flagNotify = prefs.getBool('flagNotify') ?? true;

    print("Token: $token, URL: $url, FlagNotify: $flagNotify"); // Log adicional

    if (token.isNotEmpty && url.isNotEmpty) {
      if (flagNotify == true) {
        Workmanager().initialize(
          callbackDispatcher,
          isInDebugMode: false, // Mantenha como true para depuração
        );

        var solicitacoesremotas =
            await DataServiceSalesMonitor.fetchDataRequests(token, url);

        // Verifique se solicitacoesremotas é maior que zero
        if (solicitacoesremotas != 0 && solicitacoesremotas != null) {
          final fcmToken = await FirebaseMessaging.instance.getToken();
          await prefs.setString('fcmtoken', fcmToken ?? '');

          print('TOKEN FCM: $fcmToken');
          print('Solicitações remotas: $solicitacoesremotas'); // Log adicional

          // Envie a notificação para o Firebase
          // final firebaseMessagingService = FirebaseMessagingService(NotifyService());
          // await firebaseMessagingService.sendFcmNotification(
          //   "Novas Solicitações",
          //   "Há $solicitacoesremotas novo(s) pedido(s) de liberação remota.",
          //   fcmToken!,
          // );
          // Exibir a notificação local
          flutterLocalNotificationsPlugin.show(
            0,
            'Novas Solicitações',
            'Há $solicitacoesremotas novo(s) pedido(s) de liberação remota.',
            NotificationDetails(
              android: AndroidNotificationDetails(
                'channel_id',
                'channel_name',
                importance: Importance.max,
                priority: Priority.high,
              ),
              iOS: DarwinNotificationDetails(
                presentAlert:
                    true, // Exibe um alerta quando a notificação chega
                presentBadge: true, // Atualiza o badge no ícone do app
                presentSound: true, // Reproduz o som de notificação
              ),
            ),
          );

          print('ENVIANDO NOTIFICAÇÃO');
        } else {
          callbackDispatcher();
          print('Nenhuma solicitação remota disponível.');
        }
      } else {
        await Workmanager().cancelAll();
      }
    } else {
      print('Token ou URL não estão disponíveis.');
    }
  } catch (e) {
    print("Erro no fetchDataInBackground: $e");
  }
}
