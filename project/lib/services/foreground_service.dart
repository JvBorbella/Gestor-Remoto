// import 'dart:async';
// import 'package:flutter_foreground_task/flutter_foreground_task.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:project/notify_service.dart';
// import 'package:project/services/firebase_messaging_service.dart';
// import 'package:project/back/sales_info_functions/sales_monitor.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> startForegroundService() async {
//   bool isRunning = await FlutterForegroundTask.isRunningService;
//   print('[DEBUG] Serviço já está rodando? $isRunning');

//   if (!isRunning) {
//     print('[DEBUG] Iniciando serviço em foreground...');
//     await FlutterForegroundTask.startService(
//       notificationTitle: 'Monitoramento Ativo',
//       notificationText: 'O app está monitorando solicitações...',
//       callback: startCallback,
//     );
//     startCallback();
//     print('[DEBUG] Serviço iniciado com sucesso!');
//   } else {
//     print('[DEBUG] Serviço já estava em execução.');
//   }
// }

// void startCallback() {
//   print('[DEBUG] startCallback() foi chamado!');
//   FlutterForegroundTask.setTaskHandler(MyForegroundTaskHandler());
// }

// class MyForegroundTaskHandler extends TaskHandler {
//   Timer? _timer;

//   @override
//   Future<void> onStart(DateTime timestamp, TaskStarter taskStarter) async {
//     print('[Foreground Service] Iniciando...');

//     // Inicializa o sistema de notificações apenas uma vez
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: DarwinInitializationSettings(),
//     );

//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);

//     // Inicia a verificação periódica
//     _timer = Timer.periodic(Duration(minutes: 1), (timer) async {
//       await checkSolicitations();
//     });
//   }

//   @override
//   Future<void> onDestroy(DateTime timestamp) async {
//     _timer?.cancel();
//     print('[Foreground Service] Parando serviço...');
//   }

//   @override
//   void onRepeatEvent(DateTime timestamp) async {
//     print('[Foreground Service] Evento recorrente...');
//     await checkSolicitations();
//   }

//   Future<void> checkSolicitations() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String token = prefs.getString('token') ?? '';
//     String url = prefs.getString('url') ?? '';

//     print('[Foreground Service] Token obtido: $token');
//     print('[Foreground Service] URL obtida: $url');

//     if (token.isNotEmpty && url.isNotEmpty) {
//       var solicitacoesremotas =
//           await DataServiceSalesMonitor.fetchDataRequests(token, url);

//       print(
//           '[Foreground Service] Quantidade de solicitações: $solicitacoesremotas');

//       if (solicitacoesremotas != null && solicitacoesremotas > 0) {
//         final fcmToken = await FirebaseMessaging.instance.getToken();

//         if (fcmToken != null) {
//           await prefs.setString('fcmtoken', fcmToken);
//           print('[Foreground Service] FCM Token atualizado: $fcmToken');

//           flutterLocalNotificationsPlugin.show(
//             0,
//             'Novas Solicitações',
//             'Há $solicitacoesremotas novo(s) pedido(s) de liberação remota.',
//             NotificationDetails(
//               android: AndroidNotificationDetails(
//                 'channel_id',
//                 'channel_name',
//                 importance: Importance.max,
//                 priority: Priority.high,
//               ),
//               iOS: DarwinNotificationDetails(
//                 presentAlert: true,
//                 presentBadge: true,
//                 presentSound: true,
//               ),
//             ),
//           );

//           final firebaseMessagingService =
//               FirebaseMessagingService(NotifyService());
//           await firebaseMessagingService.sendFcmNotification(
//             "Novas Solicitações",
//             "Há $solicitacoesremotas novo(s) pedido(s) de liberação remota.",
//             fcmToken,
//           );
//         } else {
//           print('[Foreground Service] Erro: FCM Token é nulo!');
//         }
//       }
//     }
//   }
// }
