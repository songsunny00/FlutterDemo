  
import 'package:flutter/material.dart';
class UserModel with ChangeNotifier{
  int value = 0;

  increment(){
    value++;
    notifyListeners();
  }
}