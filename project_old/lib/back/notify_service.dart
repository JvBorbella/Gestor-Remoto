import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotifyServices {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotifyServices() {
    // Inicializa as configurações do plugin
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher'); // Substitua pelo ícone do aplicativo

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Future<void> showNotification({required String title, required String body}) async {
  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //       AndroidInitializationSettings('ic_launcher'); 
  //   var androidDetails = const AndroidNotificationDetails(
  //     'channel_id', // Substitua pelo seu channel_id
  //     'channel_name', // Substitua pelo nome do canal
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     // icon: 'ic_launcher_icon', // Nome do ícone sem a extensão
  //     ticker: 'ticker',
  //   );

  //   var notificationDetails = NotificationDetails(android: androidDetails);

  //   await flutterLocalNotificationsPlugin.show(
  //     0, // ID da notificação
  //     title, // Título dinâmico
  //     '${body}t e s t e', // Corpo dinâmico
  //     notificationDetails,
  //   );
  // }
}

