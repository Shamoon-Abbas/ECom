import 'package:flutter/material.dart';

class SnackBarHelper{

  static bool _isShowing=false;

  static void show(BuildContext context,String message,Color c){
    if(_isShowing) return;

    _isShowing=true;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: c,
      content: Text(message,style: TextStyle(
        fontSize: 18
      ),),
      duration: Duration(seconds: 2),
    ));

    Future.delayed(Duration(seconds: 3),(){
      _isShowing=false;
    });

  }

}