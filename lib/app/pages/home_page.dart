import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/data_controller.dart';
import '../data/models/post_model.dart';

class HomePage extends StatelessWidget {
  final _controller = Get.find<DataController>();
  final _titleCtrl = TextEditingController();
  final _bodyCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offline Sync with GetX')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _titleCtrl, decoration: InputDecoration(labelText: 'Title')),
            SizedBox(height: 8),
            TextField(controller: _bodyCtrl, decoration: InputDecoration(labelText: 'Body')),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final model = PostModel(
                  title: _titleCtrl.text,
                  body: _bodyCtrl.text,
                );
                _controller.addPost(model);
                _titleCtrl.clear();
                _bodyCtrl.clear();
              },
              child: Text('Submit'),
            ),
            SizedBox(height: 16),
            Obx(() => _controller.isOnline.value
                ? Text("Status: Online", style: TextStyle(color: Colors.green))
                : Text("Status: Offline", style: TextStyle(color: Colors.red))),
            Divider(),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: _controller.posts.length,
                itemBuilder: (_, index) {
                  final post = _controller.posts[index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.body),
                  );
                },
              )),
            )
          ],
        ),
      ),
    );
  }
}
