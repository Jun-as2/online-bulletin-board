class UserModel {
  String? username;
  String? idToken;
  String? password;
  String? emailId;

  UserModel(
      {required this.emailId,
      required this.username,
      required this.password,
      required this.idToken}) {}

  Map<String, dynamic> toJson() {
    return {
      'idToken': idToken,
      'username': username,
      'password': password,
      'emailId': emailId,
    };
  }
}
