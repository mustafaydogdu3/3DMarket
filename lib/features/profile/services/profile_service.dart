import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

import '../../auth/models/user_model.dart';
import '../models/address_model.dart';

class ProfileService {
  const ProfileService._();

  static ProfileService get instance => const ProfileService._();

  Future<void> saveUserProfile({
    required String name,
    required String email,
    required String phoneNumber,
    required String? gender,
  }) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;

      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: userId)
          .limit(1)
          .get();

      querySnapshot.docs.first.reference.update({
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'gender': gender,
      });
    } catch (e) {
      throw Exception('Failed to save user profile: $e');
    }
  }

  Future<UserModel> getUserProfile() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;

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

  Future<void> addAddress(AddressModel address) async {
    try {
      AddressModel updatedAddress = AddressModel.empty();

      final snap =
          await FirebaseFirestore.instance.collection('addresses').get();

      if (snap.docs.isNotEmpty) {
        if (address.isDefault) {
          for (var doc in snap.docs) {
            await doc.reference.update({
              'isDefault': false,
            });
          }
        }
      } else {
        updatedAddress = address.copyWith(isDefault: true);
      }

      final userId = FirebaseAuth.instance.currentUser?.uid;

      updatedAddress = updatedAddress.copyWith(
        id: const Uuid().v4(),
        userFK: userId,
      );

      await FirebaseFirestore.instance
          .collection('addresses')
          .add(updatedAddress.toJson());
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }

  Future<void> updateAddress(AddressModel address) async {
    try {
      AddressModel updatedAddress = AddressModel.empty();

      final snap =
          await FirebaseFirestore.instance.collection('addresses').get();

      if (snap.docs.isNotEmpty) {
        if (address.isDefault) {
          for (var doc in snap.docs) {
            await doc.reference.update({
              'isDefault': false,
            });
          }
        }
      } else {
        updatedAddress = address.copyWith(isDefault: true);
      }

      final editedAddressSnap = await FirebaseFirestore.instance
          .collection('addresses')
          .where('id', isEqualTo: address.id)
          .get();

      await editedAddressSnap.docs.first.reference
          .update(updatedAddress.toJson());
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }

  Future<AddressModel> getDefaultAddress() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    final snap = await FirebaseFirestore.instance
        .collection('addresses')
        .where('userFK', isEqualTo: userId)
        .where('isDefault', isEqualTo: true)
        .get();

    final defaultAddress = AddressModel.fromJson(snap.docs.first.data());

    return defaultAddress;
  }

  Future<List<AddressModel>> getAddresses() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    final snap = await FirebaseFirestore.instance
        .collection('addresses')
        .where('userFK', isEqualTo: userId)
        .get();

    List<AddressModel> addresses = [];

    for (var doc in snap.docs) {
      final address = AddressModel.fromJson(doc.data());

      addresses.add(address);
    }

    return addresses;
  }

  Future<void> removeAddress(AddressModel address) async {
    final snap = await FirebaseFirestore.instance
        .collection('addresses')
        .where('id', isEqualTo: address.id)
        .get();

    await snap.docs.first.reference.delete();
  }

  Future<void> setAsDefaultAddress(AddressModel address) async {
    final snap = await FirebaseFirestore.instance.collection('addresses').get();

    if (snap.docs.isNotEmpty) {
      for (var doc in snap.docs) {
        await doc.reference.update({
          'isDefault': false,
        });
      }
    }

    final addressSnap = await FirebaseFirestore.instance
        .collection('addresses')
        .where(
          'id',
          isEqualTo: address.id,
        )
        .get();

    await addressSnap.docs.first.reference.update({
      'isDefault': true,
    });
  }
}
