  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ourlib/models/usermodel.dart';

import '../models/bookmodel.dart';
String id='';
  List<Map>bar=[];
  late List<bookmodel> reuse = [];
  late List<bookmodel> booksearch = [];
  late List<bookmodel> buysearch = [];
  late List<bookmodel> libbooks = [];
late bool onbord;
 bool buyorsel=false;
 usermodel? libmodel;
Widget textbo({
  required Color c1,//=Colors.amberAccent,
  required Color c2,//=Colors.teal,
  required double fsize,
  required double stw,
  required FontStyle fstayle,
  required String text,

  FontWeight fwe=FontWeight.bold,
})=> Stack(
    children: [
      Text(
        text,

        style: TextStyle(
          fontSize: fsize,
          fontWeight: fwe,
          //color: Colors.teal,
          fontStyle: fstayle,
          letterSpacing: 5.0,
          foreground: Paint()..style=PaintingStyle.stroke
            ..strokeWidth=stw
            ..color=c1,
          //Colors.amberAccent,

        ),
      ),
       Text(
         text,
        style: TextStyle(
          fontSize: fsize,
          fontWeight: fwe,
          color: c2,
          fontStyle:fstayle,
          letterSpacing: 5.0,
        ),
      ),
    ]
);
Widget textform({
    required TextEditingController controller,
    required String hint,
    required String label,
 // required Function() validate,
  })  =>TextFormField(
  controller: controller,
 // validator: validate(),
  keyboardType: TextInputType.text,
  decoration: InputDecoration(
    prefixIcon: Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 12.0),
      child: FaIcon(
        FontAwesomeIcons.user,
        color: Colors.grey,

      ),
    ),
    hintText: hint,
    label: Text(label),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
  ),
);


Widget emailform({
  required TextEditingController controller,
  required String hint,
  required String label,
 required Function() validate,
  })=>TextFormField(
  controller: controller,
  validator: validate(),
  keyboardType: TextInputType.emailAddress,
  decoration: InputDecoration(
    prefixIcon: Icon(
      Icons.email_outlined,
    ),
    hintText: hint,
    label: Text(label),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
  ),
);