import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'dart:async';

class OfflineSyncManager {
  static final OfflineSyncManager _instance = OfflineSyncManager._internal();
  factory OfflineSyncManager() => _instance;
  OfflineSyncManager._internal();

  late Box offlineBox;
  late StreamSubscription _subscription;

  Future<void> init() async {
    offlineBox = Hive.box('offlineBox');
    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        syncData();
      }
    });
  }

  void dispose() {
    _subscription.cancel();
  }

  Future<void> saveOffline(String key, dynamic value) async {
    await offlineBox.put(key, value);
  }

  Future<void> syncData() async {
    // Iterate over offlineBox and send data to server
    for (var key in offlineBox.keys) {
      var value = offlineBox.get(key);
      // TODO: Send value to server
      // If success:
      await offlineBox.delete(key);
    }
  }
}
