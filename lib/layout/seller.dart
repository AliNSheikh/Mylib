import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ourlib/Components/functions.dart';
import 'package:ourlib/Components/reuseable.dart';
import 'package:ourlib/Shared/cash.dart';
import 'package:ourlib/cubit/appcubit.dart';
import 'package:ourlib/cubit/appstates.dart';
import 'package:ourlib/models/usermodel.dart';
import 'package:ourlib/layout/Loginpage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../animation/slidanimation.dart';
import '../cubit/initcubit.dart';
import '../cubit/initstates.dart';

class seller extends StatelessWidget {

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext contex) => initcubit(),
        ),
        BlocProvider(create: (BuildContext contex) => appcubit(),),
      ],
      child: BlocConsumer<appcubit, appstates>(
        listener: (context, state) async {
          if (state is signoutstate) {
            await cashhelper.removedata(key: 'id',);
            Navigator.of(context).pushAndRemoveUntil(scaleanimation(
                page: loginpage()
            ), (route) => false);
          }

        },
        builder: (context, state) {

          var cub = appcubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              leading: Padding(
                padding: const EdgeInsets.only(
                  top: 4.0,
                  left: 4.0,
                ),
                child: Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Image.asset('icons/loog.png'),
                  foregroundDecoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.tealAccent,
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
              title: Text(
                'MyLib',
                style: TextStyle(
                  color: Colors.tealAccent,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 4.0,
                ),
              ),
              actions: [
                Row(
                  children: [

                  ],
                ),
                SizedBox(
                  width: 20.0,
                ),
                InkWell(
                  onTap: () {
                    cub.signout();
                  },
                  child: Row(
                    children: [
                      Text(
                        'Sign Out',
                        style: TextStyle(
                            color: Colors.tealAccent,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 20.0),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      FaIcon(
                        FontAwesomeIcons.arrowRightFromBracket,
                        color: Colors.tealAccent,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
              ],
            ),
            bottomNavigationBar: CurvedNavigationBar(
              items: [
                Column(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.house,
                      size: 30.0,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Home',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.bookOpenReader,
                      size: 30.0,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'MyLib',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.user,
                      size: 30.0,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Profile',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ],
              onTap: (int index) {
                cub.changbot(index);
                if(index==2){
                  initcubit.get(context).getuserdata();
                }
              },
              backgroundColor: Colors.tealAccent,
              animationCurve: Curves.easeInOut,
              buttonBackgroundColor: Colors.tealAccent,
            ),
            body: PageTransitionSwitcher(
              duration: Duration(milliseconds: 1000),
              transitionBuilder: (child, animation,animation2)=>
                  FadeTransition(
                  opacity: animation,
                  // scale: animation,
                   child: child,
                  ),
              child:  cub.bottomselscreen[cub.currentindex],
            ),

          );
        },
      ),
    );
  }
}
