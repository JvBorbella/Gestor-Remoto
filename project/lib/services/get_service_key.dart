// import 'package:googleapis_auth/auth_io.dart';

// class GetServiceKey {
//   Future<String> getServerKeyToken() async {
//     final scopes = [
//       'https://www.googleapis.com/auth/userinfo.email',
//       'https://www.googleapis.com/auth/firebase.database',
//       'https://www.googleapis.com/auth/firebase.messaging',
//     ];

//     final client = await clientViaServiceAccount(
//       ServiceAccountCredentials.fromJson({
//         "type": "service_account",
//         "project_id": "gestor-remoto",
//         "private_key_id": "12f37549352989f4e262b2c1747383ec2f3d88ee",
//         "private_key":
//             "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDhIndWUUq+JNuQ\ntw2KsXylWVs8LKiu19xwhvyK10h7n1bNgKEfKUquXmyQ2OeckvO2NOULL3mh6945\n0L4fjgJt45FbiQ+kj0hcwc5dhdtbQYKc1x6s17GMNb6sBCrBf3I8nILdpRU7kqdR\nRPFrZuAwx/5MMHX5FHxmsR4hr1jvlpEbOcWJut97uPCGXnvRjB5RoPPecv23hMkp\ntNi7zrDzUOpKgLk6H1wIx/iNS3HQaU5gRHLI/qduXCANYca6enS+COVTlBw/+sBV\nxdWdaXoM9JFniiFoMg0NgNHgKNYDvhlMyt0Sr1OIbAWkqGhopNtCzfeQf+NcOE/R\nnYOXCxcZAgMBAAECggEAYozD0HUlUravpll7BAtNlNPYrC6gaGj1hgyQ3/X9NKA7\nTxnPbeSVXF7ZB07rlA5/wHLHEG5nwAmP7Z8Cmq1/QrsrFfaZcl+GPZRY0XeW3gt/\nMUi5lM+WWNnt7T6luK4hQ4b/giaRdNJti5WyWGFgIfppxtAv1CizjABcQEKRm85q\n5o/knkGDHtA5SZiq4rrG5I8l48DtioxW9KSozsO2JJ8ZaWov2ZuDHAuqJQkZtSBY\nloIz7RE9cn9FuSJFdpWz5vvlq8RcvTGRP0LjQiyn50V8QXlpy0COmebnhK9+O27e\nBX8kbsfhR41Kftj+GWznH0VOYFkwSh8n9HtT1J4iQQKBgQDyGmYPRVAIIFmPHcJa\nxsSEU8EF1QNibsDDLCxEUkGdqTC4w/qdowIlllpNjqP5n287BAoBU0XqxK8ACUuG\nkvUnejblD3DBZQl7bN5iMMXBC4Ab1R86MWDfq7TqySHyAmGdY5Mfte3WR1yHVe2g\noh7+1bqes4thDghaogBhxgzuWwKBgQDuDrkOPBTgfeUXODDc+nPZGvKKWi/qkOxF\n8iaDrUI3VoAoT87Xc5qZwK5vBZ8OjUOgXP0ZOtnpCIKBB5XDbj0bCW0WVAomcSjS\n0ryYW8rlhGe4ePPedovXn0jR/4yBGxZLwY0IMj20g5uKMUlMrgKAOdmvnxChZsAA\nbtW9lksymwKBgQDg4nyi+rNYmRQXyIDcaX3pnRLTJAa8zDvqD4IfBHlGxf4n4oNN\nIjnASGUhXbobCWn828efa4aqiIA1/GxXWPK39OJA65LFUeD48Suw8bT/mHsrX1Be\ncbeWjJzE6ofJkUSzOedTsV53iFn+rGbKq003UbjD6esyACLqbUkFiT5BuQKBgQDQ\nggDAYQuAHYTcs5DI3G0/yYSKfbfeYhUwponpZ4XJ5m/V3yEyQMU2yjd+cpQAMOb8\nvLXKtWtL2vJDhZs9U38eAUGU/wLs7Mxu67nYUP4DzdbzEq23Omn98DveA1DTfCAp\nNlwKw8acJ3HCtqyXBwqVuRXb5xyv4clmF64Koms25QKBgQDtq0UBRMgMp6EYy+SB\neahRMCofy6eQnSe8uROSOIfxQndzzKHNahPEgLb+0qhpkbdM/KaTEzTGQQRRk2jh\ncv7kGniH2xCiZrj8gV4XBrTKP2NNFhs5sFsfHmBl2Bq4FuBCSkb6NenQo2/cWwOK\ngKa85sVICoCNDbE9mz4nOv66xg==\n-----END PRIVATE KEY-----\n",
//         "client_email":
//             "firebase-adminsdk-a8xmj@gestor-remoto.iam.gserviceaccount.com",
//         "client_id": "105423041321853613667",
//         "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//         "token_uri": "https://oauth2.googleapis.com/token",
//         "auth_provider_x509_cert_url":
//             "https://www.googleapis.com/oauth2/v1/certs",
//         "client_x509_cert_url":
//             "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-a8xmj%40gestor-remoto.iam.gserviceaccount.com",
//         "universe_domain": "googleapis.com"
//       }),
//         // Obtenha o token de acesso
//   var client = http.Client();
//   AccessCredentials credentials = await auth.obtainAccessCredentialsViaServiceAccount(
//     serviceAccountCredentials,
//     ['https://www.googleapis.com/auth/firebase.messaging'],
//     client,
//   );
//     );
//     final accessServerKey = client.credentials.accessToken.data;
//     return accessServerKey;
//   }
// }
