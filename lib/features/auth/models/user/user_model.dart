class UserModel {
  UserModel({
    required this.name,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.id,
  });
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? address;

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['address'] = address;
    data['id'] = id;
    return data;
  }
}
