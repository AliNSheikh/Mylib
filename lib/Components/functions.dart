import 'package:flutter/material.dart';
import 'package:ourlib/Shared/cash.dart';
import 'package:ourlib/layout/Loginpage.dart';

import '../animation/slidanimation.dart';
//navigate to new page without return
void navandfin(context, Widget,){
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
      builder: (context) => Widget,
  ),
    (route) {
        return false;
    },
  );
}
void nav(context, Widget,){
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Widget,
    ),
  );
  void navwithanim( Widget){
    Navigator.of(context).push(
        AnimationsRouteltr(
          page: Widget,)

    );
  }
}

/////////////////////////////////////
//contain symbol

bool? consym(String? value){
  RegExp con=RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if( !con.hasMatch(value!)){
    return false;
  }
  return true;
}
/////validate phone
bool? isnum(String? value){
 if( RegExp(r'^-?[0-9]+$').hasMatch(value!)) {
   return true;
 }else{return false;}

}
