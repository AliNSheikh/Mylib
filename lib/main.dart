import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ourlib/Shared/cash.dart';
import 'package:ourlib/layout/Loginpage.dart';
import 'package:ourlib/layout/buyer.dart';
import 'package:ourlib/layout/onboard.dart';
import 'package:ourlib/pages/sell/home.dart';
import 'package:ourlib/layout/seller.dart';

import 'Components/reuseable.dart';
import 'cubit/initcubit.dart';
import 'cubit/appcubit.dart';
import 'cubit/initstates.dart';
void main() async {
  var widget;
  WidgetsFlutterBinding.ensureInitialized();
 // Bloc.observer =MyBlocObserver();
  await Firebase.initializeApp();
  await cashhelper.init();
  var onbord=cashhelper.getbool(key: 'onbord');
  var id=cashhelper.getid(key: 'id');
  var buyorsel=cashhelper.getbool(key: 'buyorsel');
  if( await onbord ==true ){
    if(await id!=null){
      if(await buyorsel == true){
        widget=buyer();
      }else{
        widget=seller();
      }
    }else{
      widget=loginpage();
    }
  }
  else{
    widget=onboard();
  };
  runApp(MyApp(
    startwidget: widget,
  ));
  }

 


class MyApp extends StatelessWidget
{
  final Widget startwidget;

   MyApp({required this.startwidget,});



 // get startwidget => widget;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (BuildContext contex) => initcubit(),
        ),
        BlocProvider(create: (BuildContext contex) => appcubit(),),
      ],

          child: BlocConsumer<initcubit, initstates>(
          listener: (context, state) {},
            builder: (context, state){
            return MaterialApp(
              debugShowCheckedModeBanner: false,

              home: startwidget,//seller()
            );
            },
          )
      );
      MaterialApp(
      debugShowCheckedModeBanner: false,

      home: startwidget,
    );
  }
}

