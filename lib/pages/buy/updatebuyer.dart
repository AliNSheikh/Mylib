import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../animation/slidanimation.dart';
import '../../cubit/initcubit.dart';
import '../../cubit/initstates.dart';
import '../../layout/buyer.dart';
import '../../models/usermodel.dart';

class updatebuyer extends StatelessWidget {
  usermodel model;
  updatebuyer({required this.model});
  var libname = TextEditingController();

  var emailaddress = TextEditingController();

  var location = TextEditingController();

  var phone = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<initcubit,initstates>(
      listener: (context,state){
        if(state is updateusersucstate){
          Navigator.of(context).push(AnimationsRoutefade(
            page: buyer(),
          ),);
        }
      },
      builder:(context,state){
        libname.text=model.username;
        location.text=model.location;
        phone.text=model.phone;
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: Text('Update User'),
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.tealAccent,
              fontSize: 16.0,
              letterSpacing: 1.0,
            ),
            actions: [
              IconButton(
                  onPressed: () {

                  },
                  icon: FaIcon(
                    FontAwesomeIcons.penToSquare,
                    color: Colors.tealAccent,
                  ))
            ],
          ),
          body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
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
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
                            controller: libname,
                            validator: (String? value) {
                              if (value!.length < 5) {
                                return 'Library Name is too short';
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding:
                                const EdgeInsets.only(
                                    top: 8.0, left: 12.0),
                                child: FaIcon(
                                  FontAwesomeIcons.user,
                                  color: Colors.grey,
                                ),
                              ),

                              label: Text('Library Name '),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),


                          TextFormField(
                            controller: location,
                            validator: (String? value) {
                              if (value!.isEmpty ) {
                                return 'Location is too short';
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.text,

                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.location_on_outlined,
                              ),


                              label: Text('Location '),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          TextFormField(
                            controller: phone,
                            validator: (String? value) {
                              if (value!.length < 10) {
                                return 'phone is too short';
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding:
                                const EdgeInsets.only(
                                    top: 8.0, left: 12.0),
                                child: FaIcon(
                                  FontAwesomeIcons.phone,
                                  color: Colors.grey,
                                ),
                              ),

                              label: Text('Phone '),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! updateuserloadstate,
                            builder: (context)=>Container(
                              width: 300.0,
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
                                  if(formkey.currentState!.validate()){
                                    await initcubit.get(context).updateuser(
                                        username: libname.text,
                                        email: model.email,
                                        password: model.password,
                                        phone: phone.text,
                                        uid: model.uid,
                                        location: location.text,
                                        isbuy: model.isbuy);



                                  }

                                },



                                child: Row(
                                  children: [
                                    Text(
                                      "Update",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                        letterSpacing: 6.0,
                                      ),
                                    ),
                                    Spacer(),
                                    Icon(Icons.save_outlined),
                                  ],
                                ),
                              ),
                            ),
                            fallback: (context)=>Center(child: CircularProgressIndicator(),),
                          ),


                        ],),
                    ),
                  ),
                ),

              )

          ),
        );
      } ,

    );
  }
}
