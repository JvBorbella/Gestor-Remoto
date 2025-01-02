import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:project/back/sales_monitor.dart';
// import 'package:project/main.dart';
import 'package:project/notify_service.dart';
// import 'package:project/services/get_service_key.dart';
// import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;

class FirebaseMessagingService {
  final NotifyService _notifyService;

  FirebaseMessagingService(this._notifyService);

  Future<void> initialize() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      badge: true,
      alert: true,
      sound: true,
    );
    getDeviceFirebaseToken();
    _onMessage();
  }

  getDeviceFirebaseToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint('============================');
    debugPrint('TOKEN: $token');
    debugPrint('============================');
  }

//   Future<void> fetchDataInBackground() async {
//   final provider = Provider.of<TokenUrlProvider>(navigatorKey.currentContext!, listen: false);
//   if (provider.token.isNotEmpty && provider.url.isNotEmpty) {
//     var solicitacoesremotas = await DataServiceSalesMonitor.fetchDataRequests(provider.token, provider.url);

//     // Verifique se solicitacoesremotas é maior que zero
//     if (solicitacoesremotas != 0 && solicitacoesremotas != null) {
//       print('Passando aki');
//        _notifyService.showNotification(
//           CustomNotify(
//             id: 1,
//             title: 'Gestor Remoto',
//             body: 'Há $solicitacoesremotas novo(s) pedido(s) de liberação remota.',
//             payload: ''
//           )
//         );
//       print('Notificação enviada: solicitacoesremotas > 0');
//     } else {
//       print('Nenhuma solicitação remota disponível.');
//     }
//   }
// }

  _onMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        _notifyService.showNotification(CustomNotify(
            id: android.hashCode,
            title: notification.title,
            body: '${notification.body} T E S T E',
            payload: ''));
      }
    });
  }

  // _onMessageOpenedApp() {
  //   FirebaseMessaging.onMessageOpenedApp.listen(_goToPageAfterMessage);
  // }

  // _goToPageAfterMessage(message) {
  //   final String route = message.data['route'] ?? '';
  //   if (route.isNotEmpty) {
  //     RouteObserver.navigatorKey?.currentState?.pushNamed(route);
  //   }
  // }

  Future<void> sendFcmNotification(title, String body, String fcmToken) async {
    // Carregue as credenciais da conta de serviço
    final serviceAccountCredentials = ServiceAccountCredentials.fromJson({
      "type": "service_account",
      "project_id": "gestorremoto",
      "private_key_id": "f26a9d85f097efd27c59b782a76cd00e01b4c2c0",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCSxi8wheyvGSCj\nV/resYJy7w8UL1ueR1C4XrrIz/MuKVKwSHjhlVnmr5MO6IXMPKL+Jmfq/jqdd8dE\nVpdcNtWrqPqLT/NKLvaXraLB+ZkH41Af4nJB1MS59rrG7sAHwNVpZXPlj9fSLiEv\nwicfxfWaaHFSp0lAsj9EMRC9g/pVz3HVimkDO+eD45StG9y7CFqEaRb63cyBvWPl\n7kYPth7PzqLQPYTXecaqfjsdVHZbevSmlTrMyZlvQfd4OnVhDsBNNdDlvbBERlJH\n4HUofI0dpjLA0NKMsTug4ZfNSs2dNOp3u+cOkuvi2xW3U/ipEZQ4IdymeKxYApvB\niqGy8xplAgMBAAECggEACcMiymBuAKt0L0kfx4YY/hoGb7pCpsFpjgnG9KpYK17W\nQCFh4Oc1JpHQ/zHaDF6QHMVjLg8gyO55k4MK6DhBd/xyRafYr7t17VrAM5StaAfn\ngWdnYBeNyiyt+aNRpHJf/3WfAsrReQpWbL3GKmfZUR7XQr8bsTDp4lg9G83WbbSX\nvBDH/EBvwuv2L7Mudj1eJQcPnGUpjl7iFGfWqwCMsMAzeABrL1zuxMQMwQNKH24b\n014gO/iuU/Yzes38B1SV0Ps4DJjUy+k6bhYRDD+Lrzi3aYWY9t+f6AO5/3LgY8nj\nJDVsGUkj7Rvvamk1J9gdJfaV80S5l47fSf1nJ7MqAQKBgQDF8244Cq9qDFGJ3+76\n9xgX/UzNTFvtOuzkUJJICPGs0KNpP24sMopuADF399hu+ImknLG0VLRw+V9t0+6M\nmdiFDQNZ+nHMq5Nw754j4QSHISyms6glXyJvSd1FZR1Gsm1TP/aaoQHaUfm4esfx\nddGEbGfbAGaHwx5UKhypz1tNgQKBgQC90NBAaiotR+YTv4dQrgrmeeJm9e9nnTzi\nwobcNTWTVlRDep3xtH3BsMVNcx8rlH8R0Qq4jysL4WMCzKzDaHIgYNkxzkqS6voK\nM6RFC4fESDY00yJOIG031dWhrk7G85KfBe9yrYIynaH2+AhD+1MIGQeXtcVGVY30\n98NpHNXG5QKBgHdLpXkQt3ZpxhoZYqTMlTCf7tEq25u0j19pTz8qZLuJYXHkUDlC\nnDp+01FBhKYcEpep905+XeBX6TL/Lhx9+wb0OLjZPgviuxCs19k3msr1KzurugIL\nu2zmTvurXGFm1ov9WFkH/13bWWvcUvMp1gLAcjaBn0jiRjzixDNyS8wBAoGABkMH\nO7jE322Jx4j/+8diEKxgrajbVv227nwgWs9ejxe/++Hlp/2eUG92ctGja5qgfoP4\n6JHAh8nNrF/4KxIdAbhwMdZuW15pFUES4Dw7JFyFfUSh0xX6xGbHf2fyrVmHsrtN\nZOkYbHcKyszv6N43pQK+X2Dduy5DWpt51NPgsYkCgYBNYB5TjTrKX+4wpmU65b2p\nekWdZUgSJ1fCZRyOutd6JFM7+9iX6oCeqZMvKpsXhaXuhn2WYMsA2xevI1rreZGU\nDd7fLinrPB6N36TC9QysNb+k0IcBsMtE+A9eXB3mfWnmYYnV6F9Huuud2AQ7EbVP\nfdVkBuN0V2jyyUciinyrUg==\n-----END PRIVATE KEY-----\n",
      "client_email": "gr-notify@gestorremoto.iam.gserviceaccount.com",
      "client_id": "104782807444479187769",
      "auth_uri": "htps://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://twww.googleapis.com/robot/v1/metadata/x509/gr-notify%40gestorremoto.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    });

    // Obtenha o token de acesso
    var client = http.Client();
    AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
      serviceAccountCredentials,
      ['https://www.googleapis.com/auth/firebase.messaging'],
      client,
    );

    // Use o token de acesso para enviar a notificação
    var response = await http.post(
      Uri.parse(
          'https://fcm.googleapis.com/v1/projects/gestorremoto/messages:send'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${credentials.accessToken.data}',
      },
      body: jsonEncode({
        'message': {
          'token': fcmToken,
          'notification': {
            'title': title,
            'body': '${body} TESTE',
          },
        },
      }),
    );

    // print(response.body);

    if (response.statusCode == 200) {
      print('Notificação enviada com sucesso!');
    } else {
      print('Falha ao enviar notificação: ${response.body}');
    }
  }
}
