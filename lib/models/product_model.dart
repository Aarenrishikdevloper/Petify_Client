class Product {
  final String id;
  final String name;
  final String description;
  final String image;
  final int oldPrice;
  final int newPrice;
  final String category;
  final int maxQuantity;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.oldPrice,
    required this.newPrice,
    required this.category,
    required this.maxQuantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["_id"],
      name: json["name"],
      description: json["description"],
      image: json["image"],
      oldPrice: json["oldPrice"],
      newPrice: json["newPrice"],
      category: json["category"],
      maxQuantity: json["maxQuantity"],
    );
  }
  static List<Product> fromJsonList(List<dynamic>jsonlist){
    return jsonlist.map((json)=>Product.fromJson(json)).toList();
  }
}
