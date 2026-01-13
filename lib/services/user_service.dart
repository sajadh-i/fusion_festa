import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final _users = FirebaseFirestore.instance.collection('users');
  //CREATE USER DATA AT SIGNUP TIME
  Future<void> createUser({
    required String uid,
    required String name,
    required String email,
  }) async {
    await _users.doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email,
      'phone': '',
      'role': 'user',
      'profileImage': '',
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  //CHECK IF USER EXIST
  Future<bool> userExists(String uid) async {
    final doc = await _users.doc(uid).get();
    return doc.exists;
  }

  //GET CURRENT USER DETAILS
  Future<Map<String, dynamic>> getCurrentUserProfile() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await _users.doc(uid).get();
    return doc.data()!;
  }

  Future<String> getUserRole(String uid) async {
    final doc = await _users.doc(uid).get();
    if (!doc.exists) return 'user';
    return doc.data()?['role'] ?? 'user';
  }

  //UPDATING THE EXISTING USER DATA
  Future<void> updateProfile({
    required String name,
    required String phone,
    required String profileImage,
  }) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await _users.doc(uid).update({
      'name': name,
      'phone': phone,
      'profileImage': profileImage,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  //DELETE USER DATA
  Future<void> deleteUserData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await _users.doc(uid).delete();
  }
}
