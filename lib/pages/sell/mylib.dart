import 'package:flutter/material.dart';

import 'package:ourlib/pages/sell/sortbook.dart';

import '../../animation/slidanimation.dart';


class mylib extends StatelessWidget {
  const mylib({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child:Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(AnimationsRouteltr(
                          page: sortbooks(type: 'Scientific',),
                        ));
                        // nav(context, addbook());
                      },
                      child: Container(

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),


                          // color: Colors.tealAccent,
                          boxShadow: [
                            BoxShadow(
                              blurStyle: BlurStyle.outer,
                              blurRadius: 10.0,
                              color: Colors.blue,
                              offset: Offset(0, 0),
                            )
                          ],
                          border: Border.all(
                            color: Colors.blue,
                            width: 5.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        height: 125.0,
                        width: 125.0,
                        child: Center(
                          child: Text(
                            'Scientific',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        //selcubit.get(context).resetsearch();
                        Navigator.of(context).push(AnimationsRouteltr(
                          page: sortbooks(type: 'Novel',),),

                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                              blurStyle: BlurStyle.outer,
                              blurRadius: 10.0,
                              color: Colors.red,
                              offset: Offset(0, 0),
                            )
                          ],
                          border: Border.all(
                            color: Colors.redAccent,
                            width: 5.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        height: 125.0,
                        width: 125.0,
                        child: Center(
                          child: Text(
                            'Novel',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(AnimationsRouteltr(
                          page: sortbooks(type: 'Literary',),),);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                              blurStyle: BlurStyle.outer,
                              blurRadius: 10.0,
                              color: Colors.green,
                              offset: Offset(0, 0),
                            )
                          ],
                          border: Border.all(
                            color: Colors.greenAccent,
                            width: 5.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        height: 125.0,
                        width: 125.0,
                        child: Center(
                          child: Text(
                            'Literary',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(AnimationsRouteltr(
                          page: sortbooks(type: 'Poetry',),),);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                              blurStyle: BlurStyle.outer,
                              blurRadius: 10.0,
                              color: Colors.amber,
                              offset: Offset(0, 0),
                            )
                          ],
                          border: Border.all(
                            color: Colors.amberAccent,
                            width: 5.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        height: 125.0,
                        width: 125.0,
                        child: Center(
                          child: Text(
                            'Poetry',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(AnimationsRouteltr(
                          page: sortbooks(type: 'Prose',),),);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                              blurStyle: BlurStyle.outer,
                              blurRadius: 10.0,
                              color: Colors.purple,
                              offset: Offset(0, 0),
                            )
                          ],
                          border: Border.all(
                            color: Colors.purpleAccent,
                            width: 5.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        height: 125.0,
                        width: 125.0,
                        child: Center(
                          child: Text(
                            'Prose',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(AnimationsRouteltr(
                          page: sortbooks(type: 'Religious',),),);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.all(Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                              blurStyle: BlurStyle.outer,
                              blurRadius: 10.0,
                              color: Colors.cyan,
                              offset: Offset(0, 0),
                            )
                          ],
                          border: Border.all(
                            color: Colors.cyanAccent,
                            width: 5.0,
                            style: BorderStyle.solid,
                          ),
                        ),
                        height: 125.0,
                        width: 125.0,
                        child: Center(
                          child: Text(
                            'Religious',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

      ),//
    );
  }
}
