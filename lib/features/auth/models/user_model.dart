// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.email,
    required this.phoneNumber,
    required this.gender,
  });

  final String? id;
  final String? name;
  final String? photoUrl;
  final String? email;
  final String? phoneNumber;
  final String? gender;

  factory UserModel.empty() {
    return const UserModel(
      id: '',
      name: '',
      photoUrl: '',
      email: '',
      phoneNumber: '',
      gender: '',
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      photoUrl: json['photoUrl'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['name'] = name;
    data['photoUrl'] = photoUrl;
    data['email'] = email;
    data['phoneNumber'] = phoneNumber;
    data['gender'] = gender;

    return data;
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? photoUrl,
    String? email,
    String? phoneNumber,
    String? gender,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      gender: gender ?? this.gender,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        photoUrl,
        email,
        phoneNumber,
        gender,
      ];
}
