// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SliderModel extends Equatable {
  const SliderModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.imageUrl,
  });

  final String? id;
  final String? title;
  final String? subTitle;
  final String? imageUrl;

  factory SliderModel.empty() {
    return const SliderModel(
      id: '',
      subTitle: '',
      title: '',
      imageUrl: '',
    );
  }

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      id: json['id'],
      subTitle: json['subTitle'],
      title: json['title'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['subTitle'] = subTitle;
    data['title'] = title;
    data['imageUrl'] = imageUrl;

    return data;
  }

  SliderModel copyWith({
    String? id,
    String? subTitle,
    String? title,
    String? imageUrl,
  }) {
    return SliderModel(
      id: id ?? this.id,
      subTitle: subTitle ?? this.subTitle,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [
        id,
        subTitle,
        title,
        imageUrl,
      ];
}
