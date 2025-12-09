

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile/controller/auth_service.dart';
import 'package:mobile/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userprovider extends ChangeNotifier {
  String name = "Loading...";
  String email = '';
  String address ='';
  String userId = '';
  String phone = '';
  Userprovider(){
    loadUser();
  }
  final AuthService _authService = AuthService();
  Future<void> loadUser() async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String?token = prefs.getString('access_token');
     print(token);
     if(token == null){
       return ;
     }
     try{
       Map<String,dynamic>?userdata = await _authService.getCurrentUser();
       if(userdata != null){
         UserModel data = UserModel.fromJson(userdata);
         name = data.name;
         email = data.email;
         phone = data.phone;
         address=data.address;
         userId= data.userId;
         notifyListeners();
       }
     }catch(e){
       print(e);
     }
  }
  Future<String>updateUser(String newName, String newAddress, String newPhone)async{
    print(newName);
    print(newAddress);
    print(newPhone);
    try{
       String result = await _authService.updateUser(newName, newAddress, newPhone);
       if(result == "User Updated successfully"){
          name = newName;
          address = newAddress;
          phone = newPhone;
          notifyListeners();
          return result;
       }else{
         return result;
       }
    }catch(e){
      return "Error updating user: e";
    }
  }
}