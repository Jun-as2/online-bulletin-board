class CommentModel {
  String? comment;
  String? postId;
  String? idToken;
  String? dateTime;

  CommentModel(
      {required this.comment,
      required this.postId,
      required this.idToken,
      this.dateTime}) {
    dateTime = DateTime.now().toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'comment': comment,
      'postId': postId,
      'idToken': idToken,
      'dateTime': dateTime,
    };
  }
}
