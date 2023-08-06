import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ourlib/animation/slidanimation.dart';
import 'package:ourlib/pages/sell/addbar.dart';
import 'package:ourlib/pages/sell/addbook.dart';
import 'package:ourlib/pages/sell/searchbook.dart';
import 'package:ourlib/pages/sell/showbar.dart';
import '../../cubit/appcubit.dart';
import '../../cubit/appstates.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appcubit, appstates>(
        listener: (context, state) {},
        builder: (context, state) {

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
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CarouselSlider(
                        items: [
                          Image(
                            image: AssetImage('imgcaru/Bibliophile-bro.png'),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Image(
                            image: AssetImage('imgcaru/Bibliophile-pana.png'),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Image(
                            image: AssetImage('imgcaru/Knowledge-rafiki.png'),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Image(
                            image: AssetImage('imgcaru/Library-amico.png'),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Image(
                            image: AssetImage('imgcaru/Library-cuate.png'),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Image(
                            image: AssetImage('imgcaru/Library-rafiki.png'),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ],
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height*0.35,
                          reverse: false,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(seconds: 1),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          scrollDirection: Axis.horizontal,
                          viewportFraction: 1.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 2.0,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                              colors: [
                                Colors.lightGreenAccent,
                                Colors.lightGreenAccent,
                                Colors.greenAccent,
                                Colors.greenAccent,
                              ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40.0,
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(AnimationsRouteltr(
                                page: addbook(),
                              ));
                              // nav(context, addbook());
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
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
                              height: 100.0,
                              width: 100.0,
                              child: Center(
                                child: Text(
                                  'Add New Book',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () async {
                             await appcubit.get(context).resetsearch();
                             await appcubit.get(context).resetImage();
                              Navigator.of(context).push(AnimationsRouteltr(
                                  page: serachbook(),),

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
                              height: 100.0,
                              width: 100.0,
                              child: Center(
                                child: Text(
                                  'Modify Book',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
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
                        horizontal: 40.0,
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () async {
                             await appcubit.get(context).newdata();
                              Navigator.of(context).push(AnimationsRouteltr(
                                page: addbar(),
                              ));
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
                              height: 100.0,
                              width: 100.0,
                              child: Center(
                                child: Text(
                                  'Add New Borrower',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () async {
                              await appcubit.get(context).getdata();
                              Navigator.of(context).push(AnimationsRouteltr(
                                page: showbar(),
                              ));
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
                              height: 100.0,
                              width: 100.0,
                              child: Center(
                                child: Text(
                                  'Show All Borrower',
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
            ), //
          );
        });
  }
}
