import 'package:equatable/equatable.dart';

class AddressModel extends Equatable {
  AddressModel({
    this.id,
    this.userFK,
    required this.title,
    required this.name,
    required this.phoneNumber,
    required this.streetDetails,
    required this.zipcode,
    required this.state,
    required this.city,
    required this.isDefault,
  });

  String? id;
  String? userFK;
  String? title;
  String? name;
  String? phoneNumber;
  String? streetDetails;
  String? zipcode;
  String? state;
  String? city;
  bool isDefault = false;

  factory AddressModel.empty() {
    return AddressModel(
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

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userFK = json['userFK'];
    title = json['title'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    streetDetails = json['streetDetails'];
    zipcode = json['zipcode'];
    state = json['state'];
    city = json['city'];
    isDefault = json['isDefault'];
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
