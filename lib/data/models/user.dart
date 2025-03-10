import 'package:firebase_auth/firebase_auth.dart';

class UserDetail {
  final String username;
  final String email;
  UserDetail({required this.username, required this.email});

  factory UserDetail.fromFirebase(Map<String, dynamic> user) {
    return UserDetail(
      username: user['username'] ?? '',
      email: user['email'] ?? '',
    );
  }
}
