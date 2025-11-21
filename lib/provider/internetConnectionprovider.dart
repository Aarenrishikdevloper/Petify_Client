import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class Internetconnectionprovider extends ChangeNotifier {
  bool _isconnected = false;
  bool get isConnectToInternet => _isconnected;
  StreamSubscription ? _internetStreamSubscription;
  Internetconnectionprovider(){
    _internetStreamSubscription = InternetConnection().onStatusChange.listen((event){
        switch(event){
          case InternetStatus.connected:
            _isconnected =  true;
            break;
          case InternetStatus.disconnected:
            _isconnected = false;
            break;


        }
        notifyListeners();
    });
  }
  @override
  void dispose() {
    _internetStreamSubscription?.cancel();
    // TODO: implement dispose
    super.dispose();
  }
}