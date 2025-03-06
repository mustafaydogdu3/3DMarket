import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../models/interest_model.dart';

class InterestService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Singleton pattern
  static final InterestService _instance = InterestService._internal();
  factory InterestService() => _instance;
  InterestService._internal();

  Future<List<InterestModel>> getInterests() async {
    try {
      final snapshot = await _firestore.collection('interests').get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return InterestModel.fromJson({
          'id': data['id'] ?? '',
          'name': data['name'] ?? '',
          'imageUrl': data['imageUrl'] ?? '',
        });
      }).toList();
    } catch (e) {
      throw Exception('Failed to load interests: ${e.toString()}');
    }
  }

  Future<List<InterestModel>> getUserInterests() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not found');

      final userInterestsSnapshot = await _firestore
          .collection('user_interests')
          .where('userFK', isEqualTo: user.uid)
          .get();

      final List<String> interestIds = userInterestsSnapshot.docs
          .map((doc) => doc.data()['interestFK'] as String)
          .toList();

      if (interestIds.isEmpty) return [];

      final interestsSnapshot = await _firestore
          .collection('interests')
          .where(FieldPath.documentId, whereIn: interestIds)
          .get();

      return interestsSnapshot.docs.map((doc) {
        final data = doc.data();
        return InterestModel.fromJson({
          'id': data['id'] ?? '',
          'name': data['name'] ?? '',
          'imageUrl': data['imageUrl'] ?? '',
        });
      }).toList();
    } catch (e) {
      throw Exception('Failed to load user interests: ${e.toString()}');
    }
  }

  Future<void> saveUserInterests(List<InterestModel> selectedInterests) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not found');

      // Delete existing interests
      final existingDocs = await _firestore
          .collection('user_interests')
          .where('userFK', isEqualTo: user.uid)
          .get();

      for (var doc in existingDocs.docs) {
        doc.reference.delete();
      }

      // Add new interests
      for (var interest in selectedInterests) {
        final docRef = _firestore.collection('user_interests').doc();
        docRef.set({
          'id': const Uuid().v4(),
          'userFK': user.uid,
          'interestFK': interest.id,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      throw Exception('Failed to save interests: ${e.toString()}');
    }
  }
}
