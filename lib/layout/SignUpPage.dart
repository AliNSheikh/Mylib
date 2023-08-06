import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ourlib/Shared/cash.dart';
import 'package:ourlib/cubit/initcubit.dart';

import '../Components/functions.dart';
import '../Components/reuseable.dart';
import '../animation/slidanimation.dart';
import '../cubit/initstates.dart';
import 'Loginpage.dart';

class signuppage extends StatelessWidget {
  TextEditingController emailcon = TextEditingController();
  TextEditingController passcon = TextEditingController();
  TextEditingController usercon = TextEditingController();
  TextEditingController phonecon = TextEditingController();
  bool? isbuyer = false;
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext contex) => initcubit(),
      child: BlocConsumer<initcubit, initstates>(
        listener: (context, state) {
          if (state is signsuccesstate) {
            cashhelper.savedata(key: id, value: state.uid);
          }
          if (state is signerrorstate) {
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
                      Colors.redAccent,
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
                          c2: Colors.redAccent,
                          fsize: 40.0,
                          stw: 3.5,
                          fstayle: FontStyle.italic,
                          text: 'Sign Up',
                          fwe: FontWeight.w400,
                        ),
                        Text(
                          'Sign Up Now For Buy Or Sell Books',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 2.0,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: usercon,
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
                                  const EdgeInsets.only(top: 8.0, left: 12.0),
                              child: FaIcon(
                                FontAwesomeIcons.user,
                                color: Colors.grey,
                              ),
                            ),
                            hintText: "Enter Your User Name",
                            label: Text('User Name'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: emailcon,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Email Address must not be empty  ';
                            } else if (consym(value) == false) {
                              return 'Please enter a valid email address';
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email_outlined,
                            ),
                            hintText: "Enter Your Email",
                            label: Text('Email Address'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: passcon,
                          validator: (String? value) {
                            if (value!.length < 6) {
                              return 'password is too short';
                            } else {
                              return null;
                            }
                          },
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
                            ), //appcubit.get(context).suffix,
                            hintText: "Enter Your Password",
                            label: Text('Password'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: phonecon,
                          validator: (String? value) {
                            if (value!.length < 9) {
                              return 'Phone number is too short';
                            }  if (isnum(value!) == false) {
                              return 'Please enter a valid Phone number';
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, left: 12.0),
                              child: FaIcon(
                                FontAwesomeIcons.phone,
                                color: Colors.grey,
                              ),
                            ),
                            hintText: "Enter Your Phone Number",
                            label: Text('Phone'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Buy Books",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Radio(
                                value: true,
                                groupValue: isbuyer,
                                onChanged: (val) {
                                  isbuyer = val;
                                  initcubit.get(context).setuserbuyer(val);
                                  //print(val);
                                }),
                            Text(
                              "Sell Books",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Radio(
                                value: false,
                                groupValue: isbuyer,
                                onChanged: (val) {
                                  isbuyer = val;
                                  initcubit.get(context).setuserseller(val);
                                  //print(val);
                                })
                          ],
                        ),
                        ConditionalBuilder(
                          condition: state is! signloadstate,
                          builder: (context) => Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 60,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: MaterialButton(
                              onPressed: () async {
                                if (formkey.currentState!.validate()) {
                                  await initcubit.get(context).usersign(
                                    username: usercon.text,
                                    email: emailcon.text,
                                    password: passcon.text,
                                    phone: phonecon.text,
                                    isbuy: isbuyer!,
                                  );
                                }
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 6.0,
                                ),
                              ),
                            ),
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Spacer(),
                            Text(
                              'Do You Have Account?',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(AnimationsRoutertl(
                                    page: loginpage()
                                ), (route) => false);

                              },
                              child: Text(
                                'Login Now',
                                style: TextStyle(
                                  color: Colors.red,
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
        },
      ),
    );
  }
}
