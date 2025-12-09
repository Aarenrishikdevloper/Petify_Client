

import 'dart:convert';

import 'package:mobile/models/product_model.dart';

class CartItem {
  final String id;
  final String userId;
  final Product product;
  final int quantity;
  final int v; // Represents the '__v' field

  CartItem({
    required this.id,
    required this.userId,
    required this.product,
    required this.quantity,
    required this.v,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['_id'] as String,
      userId: json['user_id'] as String,
      product: Product.fromJson(json['product'] as Map<String, dynamic>),
      quantity: json['quantity'] as int,
      v: json['__v'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user_id': userId,
      'product': product.toJson(),
      'quantity': quantity,
      '__v': v,
    };
  }
  static List<CartItem> fromJsonList(List<dynamic>jsonList){
    return jsonList.map((json)=>CartItem.fromJson(json)).toList();
  }
}