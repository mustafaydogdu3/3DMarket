class InterestModel {
  final String id;
  final String name;
  final String imageUrl;
  bool isSelected;

  InterestModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isSelected = false,
  });

  factory InterestModel.fromJson(Map<String, dynamic> json) {
    return InterestModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  InterestModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    bool? isSelected,
  }) {
    return InterestModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
