import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/controller/db_service.dart';
import 'package:mobile/models/feedbackmodel.dart';

class Feedbackprovider extends ChangeNotifier {

  final DbService dbService = DbService();
  List<Feedbackmodel> _feedbacks = [];
  StreamSubscription<List<Feedbackmodel>>? _feedbacksubscriber ;
  bool isLoading = false;
  List<Feedbackmodel>get feedback => _feedbacks;
  Future<void>fetchFeedbacks()async{
    try{
       isLoading = true;
       notifyListeners();
       _feedbacksubscriber = dbService.getFeedbacks().asBroadcastStream().listen((feedback){
         _feedbacks = feedback;
         isLoading = false;
         notifyListeners();
       });
    }catch(e){
       print("Error fetching feedback: $e");
       isLoading = false;
       notifyListeners();
    }
  }
  Future<void> addFeedback(String feedback)async{
    try{
       await dbService.addFeedback(feedback);
       fetchFeedbacks();
    }catch(e){
      print("Error adding feedback: $e");
    }
  }
  Future<void> deletefeedback(String feedbackId)async{
    try{
      await dbService.deletefeedback(feedbackId);
      fetchFeedbacks();
    }catch(e){
      print("Error adding feedback: $e");
    }
  }
  Future<void> cancelProvider()async{
    _feedbacksubscriber?.cancel();
    _feedbacksubscriber = null;
    _feedbacks = [];
    notifyListeners();
  }
}