import 'dart:io';
// import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:project/firebase_options.dart';
import 'package:project/front/pages/splash_page.dart';
// import 'package:project/back/notify_service.dart';
import 'package:project/notify_service.dart';
import 'package:project/services/firebase_messaging_service.dart';
import 'package:provider/provider.dart';
import 'package:project/back/sales_monitor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Gestor Remoto",
      theme: ThemeData(
        textTheme: TextTheme(
          bodySmall: TextStyle(
              fontFamily: 'Poppins-Regular',
              fontSize: MediaQuery.of(context).size.height * 0.012),
          bodyMedium: TextStyle(
              fontFamily: 'Poppins-Regular',
              fontSize: MediaQuery.of(context).size.height * 0.018),
          bodyLarge: TextStyle(
              fontFamily: 'Poppins-Regular',
              fontSize: MediaQuery.of(context).size.width * 0.025),
          labelSmall: TextStyle(
              fontFamily: 'Poppins-Regular',
              fontSize: MediaQuery.of(context).size.height * 0.012),
          labelMedium: TextStyle(
              fontFamily: 'Poppins-Regular',
              fontSize: MediaQuery.of(context).size.height * 0.018),
          labelLarge: TextStyle(
              fontFamily: 'Poppins-Regular',
              fontSize: MediaQuery.of(context).size.height * 0.025),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SplashPage(),
      navigatorKey: navigatorKey, // Define o navigatorKey global
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class TokenUrlProvider with ChangeNotifier {
  String _token = '';
  String _url = '';

  String get token => _token;
  String get url => _url;

  void setToken(String newToken) {
    _token = newToken;
    notifyListeners();
  }

  void setUrl(String newUrl) {
    _url = newUrl;
    notifyListeners();
  }

  Future<void> loadSavedToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedToken = await sharedPreferences.getString('token') ?? '';
    _token = savedToken;
    notifyListeners();
  }

  Future<void> loadSavedUrl() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String savedUrl = await sharedPreferences.getString('url') ?? '';
    _url = savedUrl;
    notifyListeners();
  }
}

// void backgroundFetchHeadlessTask(HeadlessTask task) async {
//   String taskId = task.taskId;
//   bool isTimeout = task.timeout;
//   if (isTimeout) {
//     BackgroundFetch.finish(taskId);
//     return;
//   }

//   // Busque os dados de solicitacoesremotas
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String token = prefs.getString('token') ?? '';
//   String url = prefs.getString('url') ?? '';

//   if (token.isNotEmpty && url.isNotEmpty) {
//     await DataServiceSalesMonitor.fetchDataRequests(token, url);
//     print('Executando tarefa headless com token: $token e url: $url');
//   }

//   // BackgroundFetch.finish(taskId);
// }

@pragma('vm:entry-point')
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Inicializa o serviço de notificações locais
  await NotifyService().initializeNotifications();

  // Configura o Firebase Messaging para lidar com mensagens em background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // // Initialize WorkManager
  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false, // Set to false in production
  );

  // Register periodic task
  await Workmanager().registerPeriodicTask(
    'fetchDataInBackground',
    'fetchDataInBackground',
    frequency: Duration(minutes: 15),
    inputData: {
      'key': 'value',
    },
    constraints: Constraints(
      networkType: NetworkType.connected, // Garante execução somente online
      requiresBatteryNotLow: false, // Permite mesmo com bateria baixa
      requiresCharging: false, // Executa mesmo sem carregamento
      requiresDeviceIdle: false, // Não precisa estar ocioso
    ),
  );

  // Carrega o token e URL do armazenamento local antes de iniciar a aplicação
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String savedToken = prefs.getString('token') ?? '';
  String savedUrl = prefs.getString('url') ?? '';

  // Adiciona o Provider com token e URL recuperados
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TokenUrlProvider()
            ..setToken(savedToken)
            ..setUrl(savedUrl),
        ),
        Provider<NotifyService>(create: (context) => NotifyService()),
        Provider<FirebaseMessagingService>(
            create: (context) =>
                FirebaseMessagingService(context.read<NotifyService>())),
      ],
      child: const MyApp(),
    ),
  );

  _configureWorkmanager();
}

// void _configureBackgroundFetch() {
//   BackgroundFetch.configure(
//     BackgroundFetchConfig(
//       minimumFetchInterval: 15, // Intervalo mínimo de 15 minutos
//       stopOnTerminate: false,   // Continuar após o app ser fechado
//       enableHeadless: true,     // Headless mode habilitado para funcionar quando o app estiver fechado
//       startOnBoot: true,        // Iniciar ao reiniciar o dispositivo
//       requiresCharging: false,  // Permitir mesmo sem carregar o dispositivo
//       requiresDeviceIdle: false, // Executar mesmo com o dispositivo em uso
//     ),
//     (taskId) async {
//       print("[BackgroundFetch] Evento recebido: $taskId");

//       // Obtenha uma instância de NotifyService
//       final notifyService = NotifyService();
//       await fetchDataInBackground(notifyService);

//       BackgroundFetch.finish(taskId);
//     },
//   ).then((int status) {
//     print('BackgroundFetch configurado com status: $status');
//   }).catchError((e) {
//     print('Erro ao configurar BackgroundFetch: $e');
//   });
// }

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    // Inicializa o Firebase no background
    await Firebase.initializeApp();

    debugPrint(
        "Mensagem recebida no background title: ${message.notification?.title}");
    debugPrint(
        "Mensagem recebida no background body: ${message.notification?.body}");

    // Recupera as preferências armazenadas
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String url = prefs.getString('url') ?? '';
    bool flagNotify = prefs.getBool('flagNotify') ?? true;

    debugPrint("Token: $token, URL: $url, FlagNotify: $flagNotify");

    if (token.isNotEmpty && url.isNotEmpty) {
      if (flagNotify) {
        // Inicializa o WorkManager (recomendado inicializar apenas no main.dart)
        Workmanager().initialize(callbackDispatcher, isInDebugMode: false);

        // Busca as solicitações remotas
        var solicitacoesremotas =
            await DataServiceSalesMonitor.fetchDataRequests(token, url);

        // Garante que solicitacoesremotas não seja nulo antes da comparação
        if (solicitacoesremotas != null && solicitacoesremotas > 0) {
          final fcmToken = await FirebaseMessaging.instance.getToken();
          await prefs.setString('fcmtoken', fcmToken ?? '');

          debugPrint('TOKEN FCM: $fcmToken');
          debugPrint('Solicitações remotas: $solicitacoesremotas');

          // Exibe a notificação local no dispositivo
          final FlutterLocalNotificationsPlugin
              flutterLocalNotificationsPlugin =
              FlutterLocalNotificationsPlugin();

          const AndroidInitializationSettings initializationSettingsAndroid =
              AndroidInitializationSettings('@mipmap/ic_launcher_icon');

          final InitializationSettings initializationSettings =
              InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: DarwinInitializationSettings(),
          );

          await flutterLocalNotificationsPlugin
              .initialize(initializationSettings);

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

          debugPrint('Notificação enviada com sucesso!');
        } else {
          debugPrint('Nenhuma solicitação remota disponível.');
        }
      } else {
        // Cancela todas as tarefas do WorkManager se flagNotify for false
        await Workmanager().cancelAll();
        debugPrint('Notificações desativadas pelo usuário.');
      }
    } else {
      debugPrint('Token ou URL não estão disponíveis.');
    }
  } catch (e) {
    debugPrint("Erro no fetchDataInBackground: $e");
  }
}

Future<void> fetchDataInBackground(NotifyService notifyService) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String url = prefs.getString('url') ?? '';

    print("Token: $token, URL: $url"); // Log adicional

    if (token.isNotEmpty && url.isNotEmpty) {
      var solicitacoesremotas =
          await DataServiceSalesMonitor.fetchDataRequests(token, url);

      // Verifique se solicitacoesremotas é maior que zero
      if (solicitacoesremotas != 0 && solicitacoesremotas != null) {
        final fcmToken = await FirebaseMessaging.instance.getToken();
        await prefs.setString('fcmtoken', fcmToken ?? '');

        print('TOKEN FCM: $fcmToken');
        print('Solicitações remotas: $solicitacoesremotas'); // Log adicional

        // Envie a notificação para o Firebase
        final firebaseMessagingService =
            FirebaseMessagingService(notifyService);
        await firebaseMessagingService.sendFcmNotification(
          "Novas Solicitações",
          "Há $solicitacoesremotas novo(s) pedido(s) de liberação remota.",
          fcmToken!,
        );
        print('ENVIANDO NOTIFICAÇÃO');

        // print('Notificação enviada com sucesso');
      } else {
        callbackDispatcher();
        print('Nenhuma solicitação remota disponível.');
      }
    } else {
      print('Token ou URL não estão disponíveis.');
    }
  } catch (e) {
    print("Erro no fetchDataInBackground: $e");
  }
}

void setupFirebaseMessagingListeners() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print(
        'Mensagem recebida em primeiro plano: ${message.notification?.title}');
    // fetchDataRequests(); // Chama a função ao receber a notificação
  });
}

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Future<void> fetchDataRequests() async {
//   final provider = Provider.of<TokenUrlProvider>(navigatorKey.currentContext!,
//       listen: false);

//   if (provider.token.isNotEmpty && provider.url.isNotEmpty) {
//     int? solicitacoesremotas = await DataServiceSalesMonitor.fetchDataRequests(
//         provider.token, provider.url);

//     if (solicitacoesremotas != null && solicitacoesremotas > 0) {
//       print('R E S U L T A D O: $solicitacoesremotas');

//       var androidDetails = AndroidNotificationDetails(
//         'channelId',
//         'channelName',
//         importance: Importance.max,
//         priority: Priority.high,
//         ticker: 'ticker',
//       );
//       var generalNotificationDetails =
//           NotificationDetails(android: androidDetails);

//       await flutterLocalNotificationsPlugin.show(
//         0,
//         'Novas solicitações',
//         'Você tem $solicitacoesremotas novas solicitações remotas.',
//         generalNotificationDetails,
//       );
//     } else {
//       print('Nenhuma solicitação remota disponível.');
//     }
//   } else {
//     print('Token ou URL vazios.');
//   }
// }
