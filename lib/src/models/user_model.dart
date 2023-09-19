//TODO: create user model to use in firebase

class UserModel {
  final String uid;
  final String username;
  final String email;
  final DateTime createAt;
  final DateTime updateAt;

  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    required this.createAt,
    required this.updateAt,
  });

  Map<String, dynamic> userModel() {
    return {
      'id': uid,
      'username': username,
      'email': email,
      'createAt': createAt,
      'updateAt': updateAt,
    };
  }
}
