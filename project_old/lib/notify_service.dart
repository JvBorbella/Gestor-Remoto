// import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest_all.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

class CustomNotify {
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  CustomNotify({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
}

class NotifyService {
  AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('ic_launcher_icon');
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;

  NotifyService () {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupNotifications();
    print('[NotifyService] Iniciando inicialização...');
  }

  _setupNotifications() async {
    await _requestNotificationPermission(); // Solicitar permissão no Android 13+
    // await _setupTimezone();
    await initializeNotifications();
  }

  // Solicitar permissão para notificações (necessário no Android 13+)
  Future<void> _requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  // Configurar o fuso horário do dispositivo
  // Future<void> _setupTimezone() async {
  //   tz.initializeTimeZones();
  //   final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  //   tz.setLocalLocation(tz.getLocation(timeZoneName!));
  // }

  // Inicializar notificações
  Future<void> initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher_icon');
    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android,
      ),
      // onSelectNotification: _onSelectNotification (caso necessário)
    );
  }

  // Tratar seleção de notificação (caso queira navegar para outra rota)
  Future<void> _onSelectNotification(String? payload) async {
    if (payload != null && payload.isNotEmpty) {
      // Exemplo de navegação, ajuste para suas rotas:
      // Navigator.of(context).pushNamed(payload);
    }
  }

  // Função para exibir notificação
  void showNotification(CustomNotify notification) {
    print('[NotifyService] Exibindo notificação: ${notification.title}');
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    androidDetails = const AndroidNotificationDetails(
      'notifications_1',
      'Notifications',
      channelDescription: 'Solicitações remotas',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
      largeIcon: const DrawableResourceAndroidBitmap('ic_launcher'),
    );
    print('[NotifyService] Notificação exibida.');

    // localNotificationsPlugin.show(
    //   0,
    //   notification.title,
    //   '${notification.body} Teste',
    //   NotificationDetails(
    //     android: androidDetails,
    //   ),
    //   payload: notification.payload,
    // );
  }

  // Caso queira verificar notificações ao abrir o app:
  // checkForNotifications() async {
  //   final details = await localNotificationsPlugin.getNotificationAppLaunchDetails();
  //   if (details != null && details.didNotificationLaunchApp) {
  //     _onSelectNotification(details.payload);
  //   }
  // }
}
