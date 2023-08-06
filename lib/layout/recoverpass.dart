import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ourlib/cubit/initcubit.dart';
import 'package:ourlib/cubit/initstates.dart';
import 'package:ourlib/layout/Loginpage.dart';

import '../Components/functions.dart';
import '../animation/slidanimation.dart';

class recoverpass extends StatelessWidget {

 var emailcon =TextEditingController();
 var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<initcubit,initstates>(
      listener: (context, state){
        if(state is recoversuccessstate){
          AwesomeDialog(
          context: context,
            animType: AnimType.topSlide,
            dialogType: DialogType.success,
            title: "Success",
            desc: "Recover Link has been sent to your email",
            btnOkIcon: Icons.check_circle,
            btnOkColor: Colors.green.shade900,
            btnOkOnPress: (){},

          ).show();
        }
        if(state is recovererrorstate){
          AwesomeDialog(
            context: context,
            animType: AnimType.topSlide,
            dialogType: DialogType.error,
            title: "Error",
            desc: "Email address is incorrect",
            btnOkIcon: Icons.check_circle,
            btnOkColor: Colors.red.shade900,
            btnOkOnPress: (){},

          ).show();
        }
      },
      builder: (context, state){
        return  Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () async {
                Navigator.of(context).pushAndRemoveUntil(AnimationsRoutertl(
                  page: loginpage(),
                ), (route) => false);
                //navandfin(context, seller());
              },
              icon: FaIcon(
                FontAwesomeIcons.arrowLeftLong,
                color: Colors.tealAccent,
              ),
            ),
            title: Text('Recover Password'),
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.tealAccent,
              fontSize: 16.0,
              letterSpacing: 1.0,
            ),

          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('If your email is Correct we will send an message to your inbox  To recover your password',style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w400,
                          color: Colors.amberAccent,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 2.0,
                        ),),
                        SizedBox(
                          height: 50.0,
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
                          height: 50.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! recoverloadstate,
                          builder:(context)=>  Container(
                            width: MediaQuery.of(context).size.width*50,
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
                                  await initcubit.get(context).recoverpass(
                                    email: emailcon.text,
                                    );

                                };
                              },
                              child: Text(
                                "Recover",
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

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
    });
  }
}
