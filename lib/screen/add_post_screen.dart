import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_bulletin_board/model/post_model.dart';
import 'package:online_bulletin_board/network_utils/post_data_manager.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController titleContoller = TextEditingController();
  TextEditingController contentContoller = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
              onPressed: () async {
                if (titleContoller.text == null) {
                  Fluttertoast.showToast(msg: "제목을 입력하세요");
                  return;
                }
                if (contentContoller.text == null) {
                  Fluttertoast.showToast(msg: "내용을 입력하세요");
                  return;
                }

                User? user = firebaseAuth.currentUser;
                String? idToken = await user?.getIdToken();
                String? postId = firestore.collection('post').doc().id;
                PostModel postModel = PostModel(
                    idToken: idToken,
                    postId: postId,
                    title: titleContoller.text,
                    content: contentContoller.text);
                setPostData(postModel);

                Navigator.pop(context);
              },
              child: Text(
                '완료',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Form(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              TextFormField(
                controller: titleContoller,
                decoration: const InputDecoration(
                  labelText: '제목',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 500,
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  expands: true,
                  maxLength: 1500,
                  controller: contentContoller,
                  decoration: const InputDecoration(
                    labelText: '내용을 입력하세요.',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                '저희 커뮤니티는 모든 회원이 안전하고 쾌적하게 소통할 수 있는 공간을 제공하기 위해 노력하고 있습니다. 이를 위해, 다음과 같은 게시물은 게시판 정책에 따라 허용되지 않으며, 발견 시 경고 없이 삭제될 수 있음을 알려드립니다\n\n욕설 및 비방: 타인을 비난하거나 모욕하는 언어 사용은 금지됩니다.\n스팸 및 광고: 상업적 광고, 홍보성 게시물, 반복적으로 동일한 내용을 올리는 스팸 게시물은 허용되지 않습니다.\n불법 콘텐츠: 저작권을 침해하는 자료, 불법적인 행위를 조장하는 게시물은 금지됩니다.\n개인정보 유출: 본인 또는 타인의 개인정보(전화번호, 주소, 이메일 등)를 포함한 게시물은 삭제됩니다.\n성인물 및 음란물: 음란물, 성적 콘텐츠, 성인 대상의 게시물은 엄격히 금지됩니다.\n혐오 발언 및 차별: 인종, 성별, 성적 지향, 종교 등을 이유로 한 혐오 발언 및 차별적인 표현은 허용되지 않습니다.\n폭력적 콘텐츠: 폭력적인 이미지나 동영상, 폭력을 조장하는 게시물은 금지됩니다.\n\n위반 시 조치\n위 정책을 위반하는 게시물은 경고 없이 삭제될 수 있으며, 반복적인 위반 시 계정이 정지될 수 있습니다. 커뮤니티의 건강한 소통을 위해 회원 여러분의 협조를 부탁드립니다.',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }
}