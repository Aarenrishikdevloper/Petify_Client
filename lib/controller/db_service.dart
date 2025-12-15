import 'package:dio/dio.dart';
import 'package:mobile/constants/constants.dart';
import 'package:mobile/models/Cartmodel.dart';
import 'package:mobile/models/Categorymodel.dart';
import 'package:mobile/models/feedbackmodel.dart';
import 'package:mobile/models/medicalmodel.dart';
import 'package:mobile/models/product_model.dart';
import 'package:mobile/models/promomodel.dart';
import 'package:mobile/models/userPetModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DbService {
  final Dio _dio = Dio();
  final String baseUrl = "http://192.168.235.84:3000";
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
  Stream<List<UserPetsModel>>getUserPets()async*{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String?token = prefs.getString('access_token');
      if(token == null){
        return ;
      }

      final response = await _dio.get('$baseUrl/getuserpets',options: Options(
        headers: {
          "Authorization": "Bearer $token"
        }
      ));
      print(response);
      List<UserPetsModel>pets = UserPetsModel.fromJsonList(
        List<Map<String,dynamic>>.from(response.data["data"])
      );
      yield pets;
    }catch(e){
      print(e);
      if(e is DioException && e.response!.statusCode == 404){
        yield [];
      }else{
        throw Exception("Failed to load pets: $e");
      }
    }
  }
  Future<UserPetsModel>addpet(UserPetsModel pet) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String?token = prefs.getString('access_token');
      final response = await _dio.post(
          "$baseUrl/add-pet",
          data: {
            "name": pet.name,
            "species": pet.species,
            "breed": pet.breed,
            "age": pet.age,
            "gender": pet.gender,
          },
          options: Options(
              headers: {
                "Authorization": "Bearer $token"
              }
          )


      );
      return UserPetsModel.fromJson(response.data["data"]);
    }catch(e){
      throw Exception("failed to add pet: $e");
    }
  }
  Future<UserPetsModel>updatePet(String petId, UserPetsModel pet)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String?token = prefs.getString('access_token');

    try{
       print(pet);
      final response = await _dio.patch(
          "$baseUrl/petupdate/$petId",
          data: {
            "name": pet.name,
            "species": pet.species,
            "breed": pet.breed,
            "age": pet.age,
            "gender": pet.gender,
          },
          options: Options(
              headers: {
                "Authorization": "Bearer $token"
              }
          )


      );
      print(response);
      return UserPetsModel.fromJson(response.data["data"]);
    }catch(e){
      throw Exception("failed to updatepet $e");
    }
  }
  Future<void>delePet(String petId)async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String?token = prefs.getString('access_token');

      await _dio.delete('$baseUrl/deletepet/$petId',
             options: Options(
                 headers: {
                   "Authorization": "Bearer $token"
                 }
             )

         );
    }catch(e){
      throw Exception("failed to delete pet $e");
    }
  }
  Stream<List<MedicalRecord>>getMedicals(String petId)async*{
   

    try{
      final response = await _dio.get("$baseUrl/getmedicals/$petId");
      List <MedicalRecord>medicaals = MedicalRecord.fromJsonList(List<Map<String,dynamic>>.from(response.data['data'])).toList();
      yield medicaals;


    }catch(e){
      throw Exception("Something Went Wrong: $e");
    }

  }
  Stream<void>addToCart(String productId, int qty)async*{
     try{
       SharedPreferences prefs = await SharedPreferences.getInstance();
       String?token = prefs.getString('access_token');
        final response =  await _dio.post("$baseUrl/cart",
             data:{
                "productId":productId,
                 "qty":qty,
             },
             options:Options(
                headers:{
                  "Authorization": "Bearer $token"

                }
             )

          );
        final message = "Added to cart";

          yield message;
     }catch(e){
         throw Exception("Something Went Wrong");
     }
  }   
  Stream<List<CartItem>>getUserCart()async*{
     try{
       SharedPreferences prefs = await SharedPreferences.getInstance();
       String?token = prefs.getString('access_token');
        final response = await _dio.get("$baseUrl/getcart",options: Options(headers: {
          "Authorization": "Bearer $token"

        }) );
        yield CartItem.fromJsonList(response.data["data"]);
     }catch(e){
        yield [];
        throw Exception("Failed to fetch Cart, $e");
     }
  }
  Future<void> deleteItemFromcart(String id)async{
      try{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String?token = prefs.getString('access_token');
        await _dio.delete('$baseUrl/deletecart/$id',options:Options(
          headers: {
            "Authorization": "Bearer $token"
          }
        ));

      }catch(e){
        throw Exception("Failed to delte item from cart; $e");
      }
  }
  Future<void> reduceProductQunatity(String cartId)async{
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String?token = prefs.getString('access_token');
       await _dio.patch("$baseUrl/decrease/$cartId",options:Options(
         headers: {
           "Authorization": "Bearer $token"
         }
       ) );

    }catch(e){
      throw Exception("Failed to reduce quantity; $e");
    }

  }
  Stream<List<Category>> readCategories()async*{
     try{
        final response = await _dio.get("$baseUrl/category");
         List<Map<String,dynamic>> categoriesJson = List<Map<String,dynamic>>.from(response.data["data"]);
         yield Category.fromJsonList(categoriesJson);
     }catch(e){
       throw Exception("failed to fetch categories: $e");
     }
  }  
  Future<void> addFeedback( String feedback)async{
     try{
       SharedPreferences prefs = await SharedPreferences.getInstance();
       String?token = prefs.getString('access_token');
       final response = await _dio.post("$baseUrl/create-feedback",data:{
          "feedback":feedback,
          "time":DateTime.now().toIso8601String(),
       },
        options: Options(

           headers: {
           "Authorization": "Bearer $token"
           }
       )
       );
       print(response);

     }catch(e){
       throw Exception("Something Went Wrong: $e");
     }
  }   
  Stream<List<Feedbackmodel>>getFeedbacks()async*{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String?token = prefs.getString('access_token');
    try{
      final res = await _dio.get('$baseUrl/feedback',options: Options(
        headers: {
          "Authorization": "Bearer $token"
        }
      ));
      List<Feedbackmodel>feedbacks = Feedbackmodel.fromJsonList(
        List<Map<String,dynamic>>.from(res.data["data"])
      );
      yield feedbacks;
    }catch(e){
      if(e is DioException && e.response?.statusCode == 500){
        yield[];
      }else{
        print("Error fetching feedbacks: $e");
      }
    }
  }   
  Future<void>deletefeedback(String feedbackId)async{
     try{
       SharedPreferences prefs = await SharedPreferences.getInstance();
       String?token = prefs.getString('access_token');
       await _dio.delete("$baseUrl/deletefeedback/$feedbackId",options: Options(
           headers: {
             "Authorization": "Bearer $token"
           }
       ));
     }catch(e){
       throw Exception("failed to delete feedback: $e");
     }
  }
}   
