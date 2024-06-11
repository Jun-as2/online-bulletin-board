import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:online_bulletin_board/model/post_model.dart';
import 'package:online_bulletin_board/screen/detail_screen.dart';

class PostTile extends StatelessWidget {
  const PostTile({super.key, required this.post});
  final PostModel post;

  @override
  Widget build(BuildContext context) {
    final DateFormat format = DateFormat('MM-dd HH:mm');

    DateTime parseDate(String dateString) {
      final DateFormat formatter = DateFormat('yy-MM-dd HH:mm:ss');
      return formatter.parse(dateString);
    }

    DateTime dateTime = parseDate(post.dateTime.toString());
    String date = format.format(dateTime);

    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(post: post),
              ));
        },
        child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.1, color: Colors.blueGrey.shade100),
            ),
            child: Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      maxLines: 1,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      post.content,
                      maxLines: 1,
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      date,
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )));
  }
}
