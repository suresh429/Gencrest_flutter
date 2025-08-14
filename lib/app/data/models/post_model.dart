class PostModel {
  final String title;
  final String body;

  PostModel({required this.title, required this.body});

  Map<String, dynamic> toJson() => {
    'title': title,
    'body': body,
  };

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    title: json['title'],
    body: json['body'],
  );
}
