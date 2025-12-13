import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/controller/db_service.dart';
import 'package:mobile/models/Categorymodel.dart';
import 'package:mobile/models/promomodel.dart';

class Storeprovider extends ChangeNotifier {
   List<PromoBannersModel> _promos = [];
   List<PromoBannersModel> _banners = [];
   List<Category> _category = [];
  StreamSubscription<List<PromoBannersModel>>? _promoSubscription;
  StreamSubscription<List<PromoBannersModel>>? _bannerSubscription;
   StreamSubscription<List<Category>>? _categorysubscription;
   final DbService dbservice  = DbService();
  List<PromoBannersModel> get promos => _promos;
   List<PromoBannersModel> get banners => _banners;
   List <Category> get categories => _category;
   bool isLoading = true;
  Storeprovider(){
    fetchPromos();
    fetchBanner();
    fetchCategories();
  }
  Future<void>fetchPromos()async{
    try{
       isLoading = true;
       notifyListeners();
       _promoSubscription = dbservice.readPromos().asBroadcastStream().listen((promos){
         _promos = promos;
         isLoading = false;
         notifyListeners();

       });

    }catch(e){
      print(e);
      isLoading = false;
      notifyListeners();
    }
  }
   Future<void>fetchBanner()async{
     try{
       isLoading = true;
       notifyListeners();
       _promoSubscription = dbservice.readBanners().asBroadcastStream().listen((banners){
         _banners = banners;
         isLoading = false;
         notifyListeners();

       });

     }catch(e){
       print(e);
       isLoading = false;
       notifyListeners();
     }
   }
   Future<void>fetchCategories()async{
     try{
        isLoading = true;
        _categorysubscription = dbservice.readCategories().asBroadcastStream().listen((categories){
           _category.addAll(categories);
           isLoading = false;
           notifyListeners();
        });
     }catch(e){
       print("Error whhile loading data: $e");
       isLoading = false;
       notifyListeners();
     }
   }
  void  cancelProvider() {
    _promoSubscription?.cancel();
    _promoSubscription = null;
    _bannerSubscription?.cancel();
    _bannerSubscription = null;
    _categorysubscription?.cancel();
    _categorysubscription = null;

  }
}