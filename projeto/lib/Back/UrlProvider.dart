import 'package:flutter/material.dart';

class UrlProvider extends ChangeNotifier {
  String _url = '';
  String _token = '';

  String get url => _url;
  String get token => _token;

  void setUrl(String newUrl) {
    _url = newUrl;
    notifyListeners();
  }

  void setToken(String newToken) {
    _token = newToken;
    notifyListeners();
  }
}
