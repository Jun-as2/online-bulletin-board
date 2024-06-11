import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:online_bulletin_board/model/comment_model.dart';

Future<List<CommentModel>> getCommentData(String? curPostId) async {
  List<CommentModel> comments = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  await firestore.collection('comment').get().then(
    (value) {
      for (var doc in value.docs) {
        var data = doc.data();
        CommentModel comment = CommentModel(
          idToken: data['idToken'],
          comment: data['comment'],
          postId: data['postId'],
          dateTime: data['dateTime'],
        );
        if (curPostId == comment.postId) comments.add(comment);
      }
    },
  );

  DateTime parseDate(String dateString) {
    final DateFormat formatter = DateFormat('yy-MM-dd HH:mm:ss');
    return formatter.parse(dateString);
  }

  comments.sort((a, b) {
    DateTime aDateTime = parseDate(a.dateTime.toString());
    DateTime bDateTime = parseDate(b.dateTime.toString());
    return aDateTime.compareTo(bDateTime);
  });
  return comments;
}

Future<void> setCommentData(CommentModel commentModel) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firestore.collection('comment').doc().set(commentModel.toJson());
}
