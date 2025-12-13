class Category {
  final String id;
  final String name;
  final String image;
  final int priority;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.priority,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  // Factory constructor to create a Category from JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      priority: json['priority'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int,
    );
  }

  // Method to convert Category to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'image': image,
      'priority': priority,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }

  // Static method to parse a list of categories
  static List<Category> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Category.fromJson(json)).toList();
  }
}

// Example usage:
//
// // For a single category
// final category = Category.fromJson(jsonData);
//
// // For a list of categories
// final categories = Category.fromJsonList(jsonData['data']);
//
// // If your API returns: { "data": [...] }
// final response = jsonDecode(responseBody);
// final categories = Category.fromJsonList(response['data']);