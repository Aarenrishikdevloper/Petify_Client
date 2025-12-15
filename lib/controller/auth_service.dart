import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://192.168.100.84:3000"));

  Future<void> _storedUserDetails(Map<String, dynamic>userDetails) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(userDetails);
    await prefs.setString('name', userDetails['name']);
    await prefs.setString('email', userDetails['email']);
    await prefs.setString('phone', userDetails['phone']);
    await prefs.setString('address', userDetails['address']);
    await prefs.setString('user_id', userDetails['user_id']);
  }

  bool isValidEmail(String email) {
    final RegExp emailRegExp = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }

  Future<String> createAccountWithEmail(String name, String email,
      String password, String confirmPassword) async {
    if (!isValidEmail(email)) {
      return "Invalid Email";
    }
    if (password != confirmPassword) {
      return "Password do not match";
    }
    try {
      Response response = await _dio.post('/register', data: {
        'name': name,
        'email': email,
        'password': password,

      });
      String token = response.data['token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("access_token", token);
      final user = response.data['user'];
      Map<String, dynamic> userDetails = {
        'name': user['name'] ?? "Unknown",
        'email': user['email'] ?? '',
        'phone': user["phone"] ?? '',
        'address': user["address"] ?? '',
        'user_id': user["_id"] ?? '',

      };
      print(userDetails);
      await _storedUserDetails(userDetails);
      return "Account Created";
    } catch (e) {
      if(e is DioException && e.response?.statusCode == 400){
        return "User already exist";
      }
      return "Something Went Wrong";
    }
  }

  Future<Map<String, dynamic>?> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String?token = prefs.getString('access_token');
    String?userId = prefs.getString('user_id');
    if (token == null || userId == null) {
      return null;
    }
    try {
      String?name = prefs.getString('name');
      String?email = prefs.getString('email');
      String?phone = prefs.getString('phone');
      String?address = prefs.getString('address');
      String?token = prefs.getString('access_token');
      print(token);
      print(name);
      print(email);
      return {
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'user_id': userId
      };
    } catch (e) {
      return null;
    }
  }
 Future<String>login(String email, String password)async{
    print(email);
    if(!isValidEmail(email)){
      print(email);
      return"Invalid Email";
    }
    try{
      Response response = await _dio.post('/login', data:{'email':email, 'password':password});
      String token = response.data['token'];
      print(token);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("access_token", token);
      final user = response.data['user'];
      print(user);
      Map<String, dynamic> userDetails = {
        'name': user['name'] ?? "Unknown",
        'email': user['email'] ?? '',
        'phone': user["phone"] ?? '',
        'address': user["address"] ?? '',
        'user_id': user["_id"] ?? '',

      };
      await _storedUserDetails(userDetails);
      return "Login Successful";
    }catch(e){
      print(e);
      if(e is DioException && e.response?.statusCode == 401){
         return "Wrong Email or Password";
      }
      return "Something Went Wrong";
    }

 }
  Future<String>updateUser(String name, String address,String phone)async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String?token = prefs.getString('access_token');
      if (token == null) {
        return "User not logged in";
      }
      Response response = await _dio.put("/updateUser",data:{
        "name":name,
        "address":address,
        "phone":phone
      },
        options: Options(
          headers: {
            "Authorization":"Bearer $token"
          }

        )
      );
      if(response.statusCode == 200){
        await prefs.setString('phone', phone);
        await prefs.setString('address', address);
        await prefs.setString('name', name);

        return "User Updated successfully";
      }else{
        return "Failure to update user";
      }
    }catch(e){
      print(e);
         return e.toString();
    }
  }
  Future<void> logout() async{
    SharedPreferences prefs =  await SharedPreferences.getInstance();
   await prefs.remove('name');
    await prefs.remove('email');
    await prefs.remove('phone');
    await prefs.remove('address');
    await prefs.remove('access_token');
    await  prefs.remove('user_id');
  }

}
