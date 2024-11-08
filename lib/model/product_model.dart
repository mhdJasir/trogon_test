class ProductModel {
  final int productId;
  final String name;
  final String description;
  final double price;
  final String unit;
  final String image;
  final int discount;
  final bool availability;
  final String brand;
  final String category;
  final double rating;
  final List<Review>? reviews;

  ProductModel({
    required this.productId,
    required this.name,
    required this.description,
    required this.price,
    required this.unit,
    required this.image,
    required this.discount,
    required this.availability,
    required this.brand,
    required this.category,
    required this.rating,
    this.reviews,
  });

  ProductModel copyWith({
    int? productId,
    String? name,
    String? description,
    double? price,
    String? unit,
    String? image,
    int? discount,
    bool? availability,
    String? brand,
    String? category,
    double? rating,
    List<Review>? reviews,
  }) =>
      ProductModel(
        productId: productId ?? this.productId,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        unit: unit ?? this.unit,
        image: image ?? this.image,
        discount: discount ?? this.discount,
        availability: availability ?? this.availability,
        brand: brand ?? this.brand,
        category: category ?? this.category,
        rating: rating ?? this.rating,
        reviews: reviews ?? this.reviews,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        productId: json["product_id"],
        name: json["name"],
        description: json["description"],
        price: json["price"]?.toDouble(),
        unit: json["unit"],
        image: json["image"],
        discount: json["discount"],
        availability: json["availability"],
        brand: json["brand"],
        category: json["category"],
        rating: json["rating"]?.toDouble(),
        reviews: json["reviews"] == null
            ? []
            : List<Review>.from(
                json["reviews"]!.map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "name": name,
        "description": description,
        "price": price,
        "unit": unit,
        "image": image,
        "discount": discount,
        "availability": availability,
        "brand": brand,
        "category": category,
        "rating": rating,
        "reviews": reviews == null
            ? []
            : List<dynamic>.from(reviews!.map((x) => x.toJson())),
      };
}

class Review {
  final int userId;
  final int rating;
  final String comment;

  Review({
    required this.userId,
    required this.rating,
    required this.comment,
  });

  Review copyWith({
    int? userId,
    int? rating,
    String? comment,
  }) =>
      Review(
        userId: userId ?? this.userId,
        rating: rating ?? this.rating,
        comment: comment ?? this.comment,
      );

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        userId: json["user_id"],
        rating: json["rating"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "rating": rating,
        "comment": comment,
      };
}
