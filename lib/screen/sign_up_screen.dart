import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_bulletin_board/model/user_model.dart';
import 'package:online_bulletin_board/network_utils/user_data_manager.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordCheckController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> _signUp() async {
    if (usernameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        passwordCheckController.text.isNotEmpty &&
        emailController.text.isNotEmpty) {
      if (passwordController.text == passwordCheckController.text) {
        String? userid;
        try {
          UserCredential userCredential =
              await firebaseAuth.createUserWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text);
          userid = await userCredential.user?.getIdToken();
        } on FirebaseAuthException catch (error) {
          switch (error.code) {
            case "email-already-in-use":
              Fluttertoast.showToast(msg: "이미 가입된 이메일입니다");
              break;
            case "invalid-email":
              Fluttertoast.showToast(msg: "유효하지 않은 이메일입니다");
              break;
            case "weak-pasword":
              Fluttertoast.showToast(msg: "6자리 이상의 비밀번호를 입력하십시오");
              break;
            default:
              Fluttertoast.showToast(msg: "회원가입에 실패하였습니다");
              break;
          }
          return false;
        }
        UserModel userModel = UserModel(
          emailId: emailController.text,
          username: usernameController.text,
          password: passwordController.text,
          idToken: userid,
        );
        setUserData(userModel);
        Fluttertoast.showToast(msg: '회원가입 되었습니다');
      } else {
        Fluttertoast.showToast(msg: '패스워드가 일치하지 않습니다');
      }
    } else {
      Fluttertoast.showToast(msg: '모든 정보를 입력하십시오');
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              const Text(
                'Sign Up',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Create your account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail_outline),
                    labelText: 'email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: usernameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_outline),
                  labelText: 'username',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline),
                  labelText: 'password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: passwordCheckController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.check_outlined),
                  labelText: 'password check',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  bool isSignUp = await _signUp();
                  if (isSignUp == false) {
                    return;
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: Size.fromHeight(50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
