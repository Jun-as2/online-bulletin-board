class PostModel {
  String? idToken;
  String title;
  String content;
  String? postId;
  String? dateTime;

  PostModel(
      {required this.idToken,
      required this.title,
      required this.content,
      required this.postId,
      this.dateTime}) {
    dateTime ??= DateTime.now().toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'idToken': idToken,
      'title': title,
      'content': content,
      'dateTime': dateTime,
    };
  }
}
