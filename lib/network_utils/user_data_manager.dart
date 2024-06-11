import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_bulletin_board/model/user_model.dart';

Future<void> setUserData(UserModel userModel) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  await firestore
      .collection('user')
      .doc(userModel.idToken)
      .set(userModel.toJson());
}
