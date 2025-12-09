import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mobile/constants/constants.dart';
import 'package:mobile/controller/db_service.dart';
import 'package:mobile/models/userPetModel.dart';

class Userpetprovider extends ChangeNotifier{
  List<UserPetsModel> _userpets = [];
  final DbService dbservice = DbService();
  StreamSubscription<List<UserPetsModel>>? _petsSubscription;
  bool isLoading = true;
  List<UserPetsModel> get userPets => _userpets;
  Future<void>fetchUserPets()async{
    try{
      isLoading = true;

        notifyListeners();

      _petsSubscription = dbservice.getUserPets().asBroadcastStream().listen((pets){
        print(pets);
         _userpets = pets;
         isLoading = false;

           notifyListeners();

      });
    }catch(e){
      print(e);
      isLoading = false;



        notifyListeners();

    }
  }
  Future<void>addpet(UserPetsModel pet)async{
    try{
      await dbservice.addpet(pet);
      await fetchUserPets();
    }catch(e){
      print("error updating pet: $e");
    }
  }
  Future<void> updatePet(String petId,UserPetsModel pet)async{
    try{
       await dbservice.updatePet(petId, pet);
       await fetchUserPets();
    }catch(e){
       print("Error deleting pet: $e");
    }
  }
  Future<void> delepet(String petId)async{
    try{
      await dbservice.delePet(petId);
      await fetchUserPets();
    }catch(e){
      print("error deleting pet: $e");
    }
  }
}
