import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:async';

class OfflineSyncManager {
  static final OfflineSyncManager _instance = OfflineSyncManager._internal();
  factory OfflineSyncManager() => _instance;
  OfflineSyncManager._internal();

  Box? _offlineBox;
  StreamSubscription? _subscription;

  Future<void> init() async {
    try {
      // Try to get existing box first
      _offlineBox = Hive.box('offlineBox');
    } catch (e) {
      // If box doesn't exist, open it
      try {
        _offlineBox = await Hive.openBox('offlineBox');
      } catch (e) {
        debugPrint('Error initializing offline box: $e');
        return;
      }
    }

    // Initialize connectivity listener
    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        syncData();
      }
    });
  }

  void dispose() {
    _subscription?.cancel();
  }

  Future<void> saveOffline(String key, dynamic value) async {
    try {
      await _offlineBox?.put(key, value);
    } catch (e) {
      debugPrint('Error saving offline data: $e');
    }
  }

  Future<void> syncData() async {
    // Iterate over offlineBox and send data to server
    for (var key in _offlineBox!.keys) {
      var value = _offlineBox!.get(key);
      // TODO: Send value to server
      // If success:
      await _offlineBox!.delete(key);
    }
  }
}
