import 'package:dio/dio.dart';
import 'package:mobile/models/product_model.dart';
import 'package:mobile/models/promomodel.dart';

class DbService {
  final Dio _dio = Dio();
  final String baseUrl = "http://192.168.122.1:3000";
  Future<List<Product>>searchProductBYName(String query) async{
    try {
      final response = await _dio.get(
          "$baseUrl/productSearch", queryParameters: {'query': query});

      return Product.fromJsonList(response.data["products"]);
    }catch(e){
      throw Exception("something went Wrong $e");
    }
  }
  Stream<List<PromoBannersModel>>readPromos() async*{
    try{
       final response = await _dio.get('$baseUrl/promo');
       List<Map<String,dynamic>> promosJson = List<Map<String,dynamic>>.from(
         response.data['promo']
       );
       List<PromoBannersModel>promos = PromoBannersModel.fromJsonList(
         promosJson
       );
       yield promos;

    }catch(e){
            throw Exception("failed to fetch promos: $e");
    }
  }
  Stream<List<Product>>readProducts(String category)async*{
    try{
      final response = await _dio.get('$baseUrl/getproducts/$category');
      yield Product.fromJsonList(response.data["products"]);
    }catch(e){
      throw Exception("failed to fetch promos: $e");
    }
  } 
  Stream<List<PromoBannersModel>>readBanners()async*{
    try{
      final response = await _dio.get('${baseUrl}/banner');
      List<Map<String,dynamic>>banenrJson = List<Map<String,dynamic>>.from(response.data['banner']);
      List<PromoBannersModel>banners = PromoBannersModel.fromJsonList(banenrJson);
      yield banners;

    }catch(e){
      throw Exception("failed to fetch banners: $e");
    }
  }
}   
