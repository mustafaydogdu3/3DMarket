class ReviewModel {
  final String? id;
  final String productId;
  final String userId;
  final String heading;
  final String review;
  final double rating;
  final List<String>? imageUrls;

  ReviewModel({
    this.id,
    required this.productId,
    required this.userId,
    required this.heading,
    required this.review,
    required this.rating,
    this.imageUrls,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'userId': userId,
      'heading': heading,
      'review': review,
      'rating': rating,
      'imageUrls': imageUrls,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map, String id) {
    return ReviewModel(
      id: id,
      productId: map['productId'] ?? '',
      userId: map['userId'] ?? '',
      heading: map['heading'] ?? '',
      review: map['review'] ?? '',
      rating: (map['rating'] ?? 0.0).toDouble(),
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
    );
  }
}
