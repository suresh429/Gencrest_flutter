import 'package:hive/hive.dart';

class LocalStorage {
  static final _box = Hive.box('offlineBox');

  static List getQueuedPosts() {
    try {
      return _box.get('queue', defaultValue: []) as List;
    } catch (e) {
      return [];
    }
  }

  static void queuePost(Map<String, dynamic> data) {
    try {
      final queue = getQueuedPosts();
      queue.add(data);
      _box.put('queue', queue);
    } catch (e) {
      // Optionally log error
    }
  }

  static void clearQueue() {
    try {
      _box.put('queue', []);
    } catch (e) {
      // Optionally log error
    }
  }
}
