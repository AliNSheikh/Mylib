
import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ourlib/Shared/cash.dart';
import 'package:ourlib/cubit/initcubit.dart';
import 'package:ourlib/pages/sell/updateseller.dart';
import 'package:ourlib/models/usermodel.dart';

import '../../animation/slidanimation.dart';
import '../../cubit/appcubit.dart';
import '../../cubit/appstates.dart';
import '../../cubit/initstates.dart';

class profileseller extends StatelessWidget {

  late usermodel mode;



  @override
  Widget build(BuildContext context) {
    /*final appCubit = context.read<Appcubit>();
    appCubit.getuserdata();*/


    return Scaffold(
      body: BlocBuilder<initcubit,initstates>(
        builder: (context,state)
        {

            if (state is getloadingstate) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else if (state is getsuccessstate) {
              mode = state.selmodel;
              return Container(
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
                    child: ConditionalBuilder(
                      condition: state is! getloadingstate,
                      builder: (context) =>
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  TextFormField(
                                    enabled: false,
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

                                      label: Text('Library Name : ${mode.username}'),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  TextFormField(
                                    enabled: false,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.email_outlined,
                                      ),

                                      label: Text('Email Address : ${mode.email}'),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  TextFormField(
                                    enabled: false,

                                    keyboardType: TextInputType.text,

                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.location_on_outlined,
                                      ),


                                      label: Text('Location : ${ mode.location}'),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  TextFormField(
                                    enabled: false,

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

                                      label: Text('Phone : ${mode.phone}'),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
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
                                        Navigator.of(context).push(AnimationsRoutefade1(
                                          page: updateseller(model: mode),

                                        ));

                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "Modify",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                              letterSpacing: 6.0,
                                            ),
                                          ),
                                          Spacer(),
                                          Icon(Icons.mode),
                                        ],
                                      ),
                                    ),
                                  ),


                                ],),
                            ),
                          ),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator()),
                    )

                );//

            }
            else if (state is geterrorstate) {
              return Center(
                child: Text('No Data'),
              );
            }
            else{
              return Center(
                  child: Text('unknown'),
                );

            }



        },


      ),
    );

  }


}
