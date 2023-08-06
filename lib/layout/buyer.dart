import 'package:animations/animations.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ourlib/Shared/cash.dart';
import '../Components/functions.dart';
import '../animation/slidanimation.dart';
import '../cubit/appcubit.dart';
import '../cubit/appstates.dart';
import '../cubit/initcubit.dart';
import 'Loginpage.dart';

class buyer extends StatelessWidget {
  const buyer({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext contex) => initcubit(),
        ),
        BlocProvider(
          create: (BuildContext contex) => appcubit()..albooks(),
        ),
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
        builder: (context, state){
          var cub = appcubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              leading: Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  left: 8.0,
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
                      FontAwesomeIcons.bookOpen,
                      size: 30.0,

                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Books',
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
                    Icon(
                      FontAwesomeIcons.sliders,
                      size: 30.0,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Categories',
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
              child:  cub.bottombuyscreen[cub.currentindex],
            ),
          );
        },

      ),
    );
  }
}
