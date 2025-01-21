import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../auth/models/user/user_model.dart';

class ProfileService {
  Future<void> saveUserProfile({
    required String name,
    required String email,
    required String phoneNumber,
    required String address,
    required String gender,
  }) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId == null) {
        throw Exception("User not logged in");
      }

      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: userId)
          .limit(1)
          .get();

      querySnapshot.docs.first.reference.update({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'address': address,
        'gender': gender,
      });
    } catch (e) {
      throw Exception('Failed to save user profile: $e');
    }
  }

  Future<UserModel> getUserProfile() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        throw Exception("User not logged in");
      }

      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: userId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userMap = querySnapshot.docs.first.data();
        final user = UserModel.fromJson(userMap);
        return user;
      } else {
        throw Exception("User not logged in");
      }
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }
}
