import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_bulletin_board/screen/add_post_screen.dart';
import 'package:online_bulletin_board/screen/sign_in_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
    );
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
}
