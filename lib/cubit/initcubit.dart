import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ourlib/cubit/initstates.dart';
import 'package:ourlib/models/usermodel.dart';

class initcubit extends Cubit<initstates> {
  initcubit() : super(appinitstate());

  static initcubit get(context) => BlocProvider.of(context);
  bool isbuy = true;
  String er = "";
  late usermodel usmodel;
  late usermodel selmodel;

  void setuserbuyer(val) {
    isbuy = val;
    emit(setbuyerstate());
  }

  void setuserseller(val) {
    isbuy = val;
    emit(setsellerstate());
  }

  IconData suffix = Icons.visibility;
  bool ispass = true;

  void changeicon() {
    ispass = !ispass;
    suffix = ispass ? Icons.visibility : Icons.visibility_off;
    emit(changeiconpasstate());
  }

  Future<void> usersign({
    required String username,
    required String email,
    required String password,
    required String phone,
    required bool isbuy,
  }) async {
    emit(signloadstate());
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((userCredential) async {
      await usercreat(
        email: email,
        password: password,
        isbuy: isbuy,
        phone: phone,
        uid: userCredential.user!.uid,
        username: username,
        location: '',
      );
      emit(signsuccesstate(userCredential.user!.uid));
      Fluttertoast.showToast(
        msg: "Sign Up Successfully",
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
    }).catchError((error) {
      emit(signerrorstate(error.toString()));
    });
  }

  Future<void> usercreat({
    required username,
    required String email,
    required String password,
    required String uid,
    required String phone,
    required bool isbuy, required String location,
  }) async {
    usmodel = usermodel(
        location: '',
        username: username,
        email: email,
        password: password,
        uid: uid,
        phone: phone,
        isbuy: isbuy);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(usmodel!.toMap())
        .then((value) {
      emit(creatsuccesstate());
    }).catchError((error) {
      emit(createrrorstate(error));
    });
  }

  Future<void> userlogin({
    required String email,
    required String password,
  }) async {
    emit(loginloadstate());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      await gettype(value.user!.uid);

      emit(loginsuccessstate(value.user!.uid));
    }).catchError((error) {
      emit(loginerrorstate(error.toString()));
    });
  }
Future<void> recoverpass({
    required String email,
})async {
    emit(recoverloadstate());
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email)
        .then((value) {
          emit(recoversuccessstate());
    })
        .catchError((error){

      emit(recovererrorstate());
    });
}
  late usertype typ;

  //late bool tt;
  Future<void> gettype(String id,) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((value) async {
      typ = await usertype.fromJson(value.data()!);
      bool tt = await typ.isbuy!;

      emit(getdatasuccessstate(tt, typ.uid));
    }).catchError((error) {
      emit(getdataerrorstate());
    });
  }
    Future<void>getuserdata() async {

      emit(getloadingstate());
      final User? user=await FirebaseAuth.instance.currentUser;
       await FirebaseFirestore.instance.collection('users').doc(user!.uid).get()
          .then((value) async {
            final selmodel = await usermodel.fromJson(value.data()!);
            emit(getsuccessstate(selmodel));
       })
          .catchError((error){
            emit(geterrorstate());
            throw error;
       });



    }
  Future<void> updateuser({
    required String username,
    required String email,
    required String password,
    required String phone,
    required String uid,
    required String location,
    required bool? isbuy,
  })async {
    emit(updateuserloadstate());
    final User? user=await FirebaseAuth.instance.currentUser;
    selmodel = usermodel(
      username: username,
      phone: phone ,
      password: password,
      uid: user!.uid,
      location: location,
      email: email,
      isbuy: isbuy,
    );
    await FirebaseFirestore.instance.collection('users').doc(user.uid)
        .update(selmodel!.toMap()).then((value) {
      emit(updateusersucstate());
      Fluttertoast.showToast(msg: 'update success');
    }).catchError((error){
      emit(updateusererstate());
      Fluttertoast.showToast(msg: 'update error');

    });
  }
  }


