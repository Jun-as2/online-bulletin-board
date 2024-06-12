import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:online_bulletin_board/model/comment_model.dart';
import 'package:online_bulletin_board/model/post_model.dart';
import 'package:online_bulletin_board/network_utils/comment_data_manager.dart';
import 'package:online_bulletin_board/ui/comment_tile.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.post});

  final PostModel post;

  @override
  State<DetailScreen> createState() => _DetailScreenState(post: post);
}

class _DetailScreenState extends State<DetailScreen> {
  _DetailScreenState({required this.post});

  PostModel post;
  TextEditingController commentController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final DateFormat format = DateFormat('MM-dd HH:mm');

  DateTime parseDate(String dateString) {
    final DateFormat formatter = DateFormat('yy-MM-dd HH:mm:ss');
    return formatter.parse(dateString);
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = parseDate(post.dateTime.toString());
    String date = format.format(dateTime);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Community',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    post.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    date,
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(post.content),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
          FutureBuilder<List<CommentModel>>(
            future: getCommentData(post.postId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SliverToBoxAdapter(
                  child: const Center(),
                );
              } else if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: Center(child: Text('Error: ${snapshot.error}')),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(),
                );
              } else {
                List<CommentModel> comments = snapshot.data!;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: CommentTile(
                          comment: comments[index],
                        ),
                      );
                    },
                    childCount: comments.length,
                  ),
                );
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: commentController,
                maxLines: null,
                maxLength: 300,
                decoration: InputDecoration(
                  hintText: '댓글을 입력하세요...',
                  fillColor: Colors.black45,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  counterText: '',
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () async {
                if (commentController.text.isEmpty) {
                  Fluttertoast.showToast(msg: "댓글을 입력하세요");
                  return;
                }
                User? user = firebaseAuth.currentUser;
                String? idToken = await user?.getIdToken();
                String? postId = post.postId;
                CommentModel commentModel = CommentModel(
                    comment: commentController.text,
                    postId: postId,
                    idToken: idToken);
                setCommentData(commentModel);
                commentController = TextEditingController();
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
