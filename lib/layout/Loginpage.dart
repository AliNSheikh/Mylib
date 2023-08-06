import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ourlib/Components/reuseable.dart';
import 'package:ourlib/Shared/cash.dart';
import 'package:ourlib/layout/recoverpass.dart';
import 'package:ourlib/layout/seller.dart';

import '../Components/functions.dart';
import '../animation/slidanimation.dart';
import '../cubit/initcubit.dart';
import '../cubit/initstates.dart';
import 'SignUpPage.dart';
import 'buyer.dart';
class loginpage extends StatelessWidget {
  const loginpage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailcon = TextEditingController();
    var passcon = TextEditingController();

    var formkey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext contex) => initcubit(),
      child: BlocConsumer<initcubit, initstates>(
          listener: (context, state) async {
            if(state is getdatasuccessstate){
              await cashhelper.savedata(key: 'buyorsel', value: state.tt);
              await cashhelper.savedata(key: 'id', value: state.id,);

            }
            if(state is loginsuccessstate){
              if(await initcubit.get(context).typ.isbuy==true){
               Navigator.of(context).pushAndRemoveUntil(scaleanimation(
                 page: buyer()
               ), (route) => false);

              }
              if(await initcubit.get(context).typ.isbuy==false){

                Navigator.of(context).pushAndRemoveUntil(scaleanimation(
                    page: seller()
                ), (route) => false);

              }
              //navandfin(context, mid());
            }
            if(state is loginerrorstate){
              Fluttertoast.showToast(msg: state.error);
            }
          },
          builder: (context, state) {
            return Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white,
                        Colors.white12,
                        Colors.tealAccent,
                      ]),
                ),
                height: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 45.0,
                          ),
                          textbo(
                            c1: Colors.grey,
                            c2: Colors.tealAccent,
                            fsize: 40.0,
                            fstayle: FontStyle.italic,
                            stw: 3.5,
                            text: "LOGIN",
                            fwe: FontWeight.w400,
                          ),
                          Text(
                            'Login Now For Buy Or Sell Books',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.amberAccent,
                              fontStyle: FontStyle.italic,
                              letterSpacing: 2.0,
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),

                          TextFormField(
                  controller: emailcon,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if(value!.isEmpty){
                      return 'Email Address Must Not Be Empty  ';
                    }else if(consym(value!) ==false){

                        return 'Please enter a valid email address';

                    }else{
                      return null;
                    }
                    },

                  decoration: InputDecoration(

                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.all(
                           Radius.circular(30.0),
                         ),

                       ),

                      prefixIcon: Icon(
                        Icons.email_outlined,
                      ),
                      hintText: "Enter Your Email",
                      label: Text('Email Address'),



                  ),


                ),
                          SizedBox(
                            height: 25.0,
                          ),
                          TextFormField(
                            controller: passcon,
                           validator: (String? value){
                             if (value!.length<6){
                               return 'password is too short';
                             }else{
                               return null;
                             }
                           },//Appcubit.get(context).valid(passcon.toString(), 6, 'Password'),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: initcubit.get(context).ispass,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(initcubit.get(context).suffix),
                                onPressed: () {
                                  initcubit.get(context).changeicon();
                                },
                              ),
                              hintText: "Enter Your Password",
                              label: Text('Password'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            children: [
                              Spacer(),
                              Text(
                                'Forget Your Password?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(AnimationsRouteltr(
                                    page: recoverpass(),
                                  ), );
                                },
                                child: Text(
                                  'Recover',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! loginloadstate,
                            builder:(context)=>  Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 60,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.amberAccent,
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: MaterialButton(
                                onPressed: () async {
                                  if(formkey.currentState!.validate()) {
                                    await initcubit.get(context).userlogin(
                                      email: emailcon.text,
                                      password: passcon.text,);

                                  };
                                },
                                child: Text(
                                  "LOGIN",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    letterSpacing: 6.0,
                                  ),
                                ),
                              ),
                            ),
                            fallback:(context)=>Center(child: CircularProgressIndicator(),),
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                          Row(
                            children: [
                              Spacer(),
                              Text(
                                'Do Not Have Account?',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(AnimationsRouteltr(
                                      page: signuppage()
                                  ), (route) => false);

                                },
                                child: Text(
                                  'Sing Up',
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
