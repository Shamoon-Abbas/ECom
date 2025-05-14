import 'dart:ui';

import 'package:flutter/material.dart';

class AppWidget{

  static TextStyle boldTextFieldStyle(){
    return TextStyle(
      color: Colors.black,
      fontSize: 32,
      fontWeight: FontWeight.bold
    );
  }

  static TextStyle lightTextFieldStyle(){
    return TextStyle(
      color: Colors.black54,
      fontSize: 22,
      fontWeight: FontWeight.w500
    );
  }

  static TextStyle semiBoldTextFieldStyle(){
    return TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold
    );
  }


}