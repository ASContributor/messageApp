import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:message_app/data/models/user.dart';

import '../data/models/post.dart';

class FirestoreService {
  FirestoreService._privateConstructor();

  static final FirestoreService _instance =
      FirestoreService._privateConstructor();

  factory FirestoreService() {
    return _instance;
  }

  static FirestoreService get instance => _instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _currentUser;

  void setCurrentUser(User user) {
    print('Setting current user');
    _currentUser = user;
  }

  void clearCurrentUser() {
    print('Clearing current user');
    _currentUser = null;
  }

  Future<void> savePost(String message) async {
    if (_currentUser == null) {
      throw Exception('User not set');
    }
    final userDetails = await getCurrentUserDetails();
    final username = userDetails?.username ?? 'Anonymous';
    await _firestore.collection('posts').add({
      'userId': _currentUser!.uid,
      'username': username,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Post>> getPosts() {
    return _firestore
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Post.fromFirestore(doc.data()))
            .toList());
  }

  Future<UserDetail?> getCurrentUserDetails() async {
    if (_currentUser != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(_currentUser!.uid).get();
      return UserDetail.fromFirebase(userDoc.data() as Map<String, dynamic>);
    }
    return null;
  }
}
