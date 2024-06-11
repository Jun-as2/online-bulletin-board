import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:online_bulletin_board/model/post_model.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.post});
  final PostModel post;
  @override
  State<DetailScreen> createState() => _DetailScreenState(post: post);
}

class _DetailScreenState extends State<DetailScreen> {
  _DetailScreenState({required this.post});

  PostModel post;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
