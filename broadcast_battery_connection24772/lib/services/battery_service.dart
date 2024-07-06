import 'dart:async';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class BatteryService {
  BatteryService._privateConstructor();

  static final BatteryService _instance = BatteryService._privateConstructor();

  static BatteryService get instance => _instance;

  final Battery _battery = Battery();
  StreamSubscription<BatteryState>? _batteryStateSubscription;
  bool _isRinging = false;

  void initialize(BuildContext context) {
    _batteryStateSubscription = _battery.onBatteryStateChanged.listen((BatteryState state) async {
      if (state == BatteryState.charging) {
        int batteryLevel = await _battery.batteryLevel;
        if (batteryLevel >= 90 && !_isRinging) {
          _isRinging = true;
          FlutterRingtonePlayer.playNotification();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Battery is at 90% or more and charging")));
        }
      } else {
        _isRinging = false;
        FlutterRingtonePlayer.stop();
      }
    });
  }

  void dispose() {
    _batteryStateSubscription?.cancel();
  }
}