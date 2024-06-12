import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_bulletin_board/model/comment_model.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({super.key, required this.comment});
  final CommentModel comment;

  @override
  Widget build(BuildContext context) {
    final DateFormat format = DateFormat('MM-dd HH:mm');

    DateTime parseDate(String dateString) {
      final DateFormat formatter = DateFormat('yy-MM-dd HH:mm:ss');
      return formatter.parse(dateString);
    }

    DateTime dateTime = parseDate(comment.dateTime.toString());
    String date = format.format(dateTime);
    return Container(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment.comment.toString(),
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              date,
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
