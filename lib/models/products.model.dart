class Product {
  int id;
  String name;
  String description;
  dynamic price;
  String image;
  String? category;
  String? rating;
  int? countInStock;
  String? createdAt = DateTime.now().toIso8601String();
  String? updatedAt;
  int sellerId;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    this.category,
    required this.sellerId,
    this.rating,
    this.countInStock,
    this.updatedAt,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'category': category,
      'rating': rating,
      'countInStock': countInStock,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'sellerId': sellerId,
    };
  }

  // factory Product.fromJson(Map<String, dynamic> json) {
  //   return Product(
  //     id: json['_id'],
  //     name: json['name'],
  //     description: json['description'],
  //     price: json['price'],
  //     image: json['image'],
  //     category: json['category'],
  //     brand: json['brand'],
  //     rating: json['rating'],
  //     numReviews: json['numReviews'],
  //     countInStock: json['countInStock'],
  //     dateCreated: json['dateCreated'],
  //     dateUpdated: json['dateUpdated'],
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     '_id': id,
  //     'name': name,
  //     'description': description,
  //     'price': price,
  //     'image': image,
  //     'category': category,
  //     'brand': brand,
  //     'rating': rating,
  //     'numReviews': numReviews,
  //     'countInStock': countInStock,
  //     'dateCreated': dateCreated,
  //     'dateUpdated': dateUpdated,
  //   };
  // }
}
