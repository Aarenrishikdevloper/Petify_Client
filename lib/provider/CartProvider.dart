import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/controller/db_service.dart';
import 'package:mobile/models/Cartmodel.dart';

class  Cartprovider extends ChangeNotifier {
  final DbService dbService = DbService();
  StreamSubscription<List<CartItem>>? _cartSubscription;
  bool isLoading = true;
  List<CartItem> _carts =[];
  List<CartItem> get carts => _carts;
  int totalCost = 0;
  int totalQuantity = 0;
  Future<String> addToCart(String productId, int qty)async{
     try{
        await for(var _ in dbService.addToCart(productId, qty) ){
          readCartdaTa();
        }
        return "Added to cart Sucessfully";
     }catch(e){
       return "Error adding to Cart";
     }
  }
  Future<void>readCartdaTa()async{
     isLoading = true;
     notifyListeners();
     try{
         _cartSubscription = dbService.getUserCart().listen((cartlist){
            _carts = cartlist;
            addCost(cartlist);
            calculateQuantityList();
            isLoading = false;
            notifyListeners();
         });
     }catch(e){
       print(e);
        isLoading = false;
        notifyListeners();
     }
  }
  Future<void>deleteItem(String id)async{
    try{
       await dbService.deleteItemFromcart(id);
       readCartdaTa();
    }catch(e){
       print(e);
    }
  }
  void addCost(List<CartItem>carts)async{
     totalCost =0;
     for(int i =0; i < carts.length; i++){
       totalCost += carts[i].quantity * carts[i].product.newPrice;
       notifyListeners();
     }
  }
  void calculateQuantityList(){
    totalQuantity = 0;
    for(int i = 0; i < carts.length; i++){
       totalQuantity += carts[i].quantity;
    }
    notifyListeners();
  }
  Future<void>decreaseQuantity(String cartid)async{
     try{
       await dbService.reduceProductQunatity(cartid);
       readCartdaTa();
     }catch(e){
       throw Exception("Something Went wrong: $e");
     }
  }
  Future<void> cancelProvider()async{
    _cartSubscription?.cancel();
    _cartSubscription = null;
    _carts = [];
    notifyListeners();
  }
}