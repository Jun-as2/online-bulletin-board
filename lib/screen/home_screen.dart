import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_bulletin_board/model/post_model.dart';
import 'package:online_bulletin_board/network_utils/post_data_manager.dart';
import 'package:online_bulletin_board/screen/add_post_screen.dart';
import 'package:online_bulletin_board/screen/sign_in_screen.dart';
import 'package:online_bulletin_board/ui/post_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> posts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(),
        body: FutureBuilder<List<PostModel>>(
          future: getPostData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error : ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('게시글이 없습니다'),
              );
            } else {
              List<PostModel> posts = snapshot.data!;
              return Expanded(
                  child: RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          return PostTile(post: posts[index]);
                        },
                      )));
            }
          },
        ));
  }

  AppBar customAppBar() {
    return AppBar(
      backgroundColor: Colors.black12,
      leading: IconButton(
        icon: const Icon(Icons.logout_outlined),
        onPressed: () {
          FirebaseAuth firebaseAuth = FirebaseAuth.instance;
          firebaseAuth.signOut();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignInScreen(),
              ));
        },
      ),
      title: const Text(
        'Community',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPostScreen(),
                  )).then(
                (value) {
                  setState(() {});
                },
              );
            },
            icon: Icon(Icons.add)),
      ],
    );
  }

  Future<void> _onRefresh() async {
    setState(() {});
  }
}
