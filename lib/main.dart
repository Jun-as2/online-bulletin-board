import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_bulletin_board/firebase_options.dart';
import 'package:online_bulletin_board/screen/home_screen.dart';
import 'package:online_bulletin_board/screen/sign_in_screen.dart';
import 'package:online_bulletin_board/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MainApp(
    appTheme: AppTheme(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.appTheme});

  final AppTheme appTheme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme.dark,
      home: StreamBuilder<User?>(
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData) {
            return HomeScreen();
          } else {
            return SignInScreen();
          }
        },
        stream: FirebaseAuth.instance.authStateChanges(),
      ),
    );
  }
}
