import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityService {
  ConnectivityService._privateConstructor();

  static final ConnectivityService _instance = ConnectivityService._privateConstructor();

  static ConnectivityService get instance => _instance;

  void initialize(BuildContext context) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      String message;
      if (result == ConnectivityResult.mobile) {
        message = "Connected to Mobile Network";
      } else if (result == ConnectivityResult.wifi) {
        message = "Connected to WiFi";
      } else {
        message = "No Internet Connection";
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    });
  }
}