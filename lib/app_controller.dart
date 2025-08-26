import 'package:flutter/material.dart';

class AppController  extends ChangeNotifier{
  
  static AppController instance = AppController();
  bool isDartMode = false;

  get isDartTheme => null;
  
  changeTheme(){
    isDartMode = !isDartMode;
    notifyListeners();
  }
}