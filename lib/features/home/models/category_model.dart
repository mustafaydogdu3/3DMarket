// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  const CategoryModel({
    required this.id,
    required this.categoryFK,
    required this.name,
    required this.imageUrl,
  });

  final String? id;
  final String? categoryFK;
  final String? name;
  final String? imageUrl;

  factory CategoryModel.empty() {
    return const CategoryModel(
      id: '',
      name: '',
      categoryFK: '',
      imageUrl: '',
    );
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      categoryFK: json['categoryFK'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['name'] = name;
    data['categoryFK'] = categoryFK;
    data['imageUrl'] = imageUrl;

    return data;
  }

  CategoryModel copyWith({
    String? id,
    String? name,
    String? categoryFK,
    String? imageUrl,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryFK: categoryFK ?? this.categoryFK,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        categoryFK,
        imageUrl,
      ];
}
