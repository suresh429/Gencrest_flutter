import 'dart:async';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../data/api_service.dart';
import '../data/local_storage.dart';
import '../data/models/post_model.dart';

class DataController extends GetxController {
  var isOnline = false.obs;
  var posts = <PostModel>[].obs;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _subscription;

  @override
  void onInit() {
    super.onInit();
    _checkConnectivity();
    _subscription = _connectivity.onConnectivityChanged.listen((status) {
      isOnline.value = status != ConnectivityResult.none;
      if (isOnline.value) _syncOfflineData();
    });
  }

  void _checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    isOnline.value = result != ConnectivityResult.none;
    if (isOnline.value) _syncOfflineData();
  }

  Future<void> addPost(PostModel model) async {
    if (isOnline.value) {
      await ApiService.post('posts', model.toJson());
      fetchPosts();
    } else {
      LocalStorage.queuePost(model.toJson());
    }
  }

  Future<void> _syncOfflineData() async {
    final queue = LocalStorage.getQueuedPosts();
    for (var data in queue) {
      await ApiService.post('posts', data);
    }
    LocalStorage.clearQueue();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    final res = await ApiService.get('posts');
    posts.value = List.from(res.data).map((e) => PostModel.fromJson(e)).toList();
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
