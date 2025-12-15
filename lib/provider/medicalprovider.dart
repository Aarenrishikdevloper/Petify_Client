import 'dart:async';
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:mobile/controller/db_service.dart';
import 'package:mobile/models/medicalmodel.dart';
import 'package:mobile/provider/UserpetProvider.dart';
import 'package:provider/provider.dart';

class Medicalprovider extends ChangeNotifier {
  final DbService dbservice = DbService();
  List<MedicalRecord> _medicals = [];
  StreamSubscription<List<MedicalRecord>>? _medicalSubscription;
  Future<void> intializeMedicals(BuildContext context)async{
    final userpetProvider = Provider.of<Userpetprovider>(context, listen:false);
    final userPets = userpetProvider.userPets;
    for(var pet in userPets){
      fetchMedicals(pet.petId);
    }
  }
  bool isLoading = true;
  List<MedicalRecord> get medicals => _medicals;
  Future<void>fetchMedicals(String petId)async{
    try{
      isLoading = true ;
      notifyListeners();
      _medicalSubscription = dbservice.getMedicals(petId).asBroadcastStream().listen((medicals){
        isLoading = false;
        _medicals.addAll(medicals);

        notifyListeners();
      });
    }catch(e){
      print("Error fetching medicals; $e");
      isLoading = false;
      notifyListeners();
    }
  }
  Future<void> cancelProvider()async{
    _medicalSubscription?.cancel();
    _medicalSubscription = null;
    _medicals=[];
    notifyListeners();
  }
}