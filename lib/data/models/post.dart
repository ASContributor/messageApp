import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String userId;
  final String username;
  final String message;
  final Timestamp timestamp;

  Post({
    required this.userId,
    required this.username,
    required this.message,
    required this.timestamp,
  });

  factory Post.fromFirestore(Map<String, dynamic> data) {
    return Post(
      userId: data['userId'] ?? '',
      username: data['username'] ?? '',
      message: data['message'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }
}
