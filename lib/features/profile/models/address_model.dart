// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class AddressModel extends Equatable {
  const AddressModel({
    required this.id,
    required this.userFK,
    required this.title,
    required this.name,
    required this.phoneNumber,
    required this.streetDetails,
    required this.zipcode,
    required this.state,
    required this.city,
    required this.isDefault,
  });

  final String? id;
  final String? userFK;
  final String? title;
  final String? name;
  final String? phoneNumber;
  final String? streetDetails;
  final String? zipcode;
  final String? state;
  final String? city;
  final bool isDefault;

  factory AddressModel.empty() {
    return const AddressModel(
      id: '',
      userFK: '',
      title: '',
      name: '',
      phoneNumber: '',
      streetDetails: '',
      zipcode: '',
      state: '',
      city: '',
      isDefault: false,
    );
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'],
      userFK: json['userFK'],
      title: json['title'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      streetDetails: json['streetDetails'],
      zipcode: json['zipcode'],
      state: json['state'],
      city: json['city'],
      isDefault: json['isDefault'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['userFK'] = userFK;
    data['title'] = title;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['streetDetails'] = streetDetails;
    data['zipcode'] = zipcode;
    data['state'] = state;
    data['city'] = city;
    data['isDefault'] = isDefault;

    return data;
  }

  AddressModel copyWith({
    String? id,
    String? userFK,
    String? title,
    String? name,
    String? phoneNumber,
    String? streetDetails,
    String? zipcode,
    String? state,
    String? city,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      userFK: userFK ?? this.userFK,
      title: title ?? this.title,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      streetDetails: streetDetails ?? this.streetDetails,
      zipcode: zipcode ?? this.zipcode,
      state: state ?? this.state,
      city: city ?? this.city,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  List<Object?> get props => [
        userFK,
        title,
        name,
        phoneNumber,
        streetDetails,
        zipcode,
        state,
        city,
      ];
}
