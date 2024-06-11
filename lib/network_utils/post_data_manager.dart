import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:online_bulletin_board/model/post_model.dart';

Future<List<PostModel>> getPostData() async {
  List<PostModel> posts = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  await firestore.collection('post').get().then(
    (value) {
      for (var doc in value.docs) {
        var data = doc.data();
        PostModel post = PostModel(
            idToken: data['idToken'],
            content: data['content'],
            postId: data['postId'],
            dateTime: data['dateTime'],
            title: data['title']);
        posts.add(post);
      }
    },
  );
  final DateFormat format = DateFormat('MM-dd HH:mm');

  DateTime parseDate(String dateString) {
    final DateFormat formatter = DateFormat('yy-MM-dd HH:mm:ss');
    return formatter.parse(dateString);
  }

  posts.sort((a, b) {
    DateTime aDateTime = parseDate(a.dateTime.toString());
    DateTime bDateTime = parseDate(b.dateTime.toString());
    return bDateTime.compareTo(aDateTime);
  });
  return posts;
}

Future<void> setPostData(PostModel postModel) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firestore.collection('post').doc(postModel.postId).set(postModel.toJson());
}
