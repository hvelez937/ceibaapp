class Post {
  int userId;
  int id;
  String title;
  String body;

  Post({
    required this.userId,
    required this.title,
    required this.id,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      title: json['title'],
      id: json['id'],
      body: json['body'],
    );
  }
}
