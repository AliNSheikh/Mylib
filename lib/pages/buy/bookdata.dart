import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ourlib/layout/buyer.dart';
import 'package:ourlib/pages/buy/libdata.dart';
import 'package:wave_transition/wave_transition.dart';

import '../../Components/reuseable.dart';
import '../../animation/slidanimation.dart';
import '../../models/bookmodel.dart';
import 'allbooks.dart';

class bookdata extends StatelessWidget {
  bookmodel mod;
  bookdata( {required this.mod});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
         AppBar(
          elevation: 0.0,
          leading:Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              onPressed: (){
                Navigator.push(context , WaveTransition(
                child: buyer(),

                center: FractionalOffset(0.90, 0.90),

                duration: Duration(milliseconds: 3000),
                settings: RouteSettings(arguments: "yeah! it works!")));
              },
              icon: FaIcon(
                FontAwesomeIcons.arrowLeftLong,
                color: Colors.tealAccent,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          title: Text('Book Details '),
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
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.tealAccent,
                Colors.white12,
                Colors.white12,
                Colors.white,
              ]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height*0.6,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),

                      boxShadow: [
                        BoxShadow(
                          blurStyle: BlurStyle.outer,
                          blurRadius: 20.0,
                          color: Colors.grey,
                          offset: Offset(0, 0),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Image(
                        image: NetworkImage(mod.bookimage),
                        fit: BoxFit.cover,




                      ),
                    ),

                  ),
                ),
                SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.of(context).push(
                          AnimationsRoutefade(
                            page: libdata(id: mod.uid!,),
                          )
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Show Library profile",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 5.0,
                          ),),







                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Book Name:",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 5.0,
                      ),),

                      SizedBox(width: 25.0,),
                  SizedBox(
                    width: 110,
                    child: Text(mod.bookname,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 5.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),




                    ],
                  ),
                ),

                SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Book Type:",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 5.0,
                        ),),

                      SizedBox(width: 25.0,),
                      SizedBox(
                        width: 150,
                        child: Text(mod.booktype,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 5.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),




                    ],
                  ),
                ),
                SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Library:",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 5.0,
                        ),),

                      SizedBox(width: 25.0,),
                      SizedBox(
                        width: 150,
                        child: Text(mod.booklib!,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 5.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),




                    ],
                  ),
                ),
                SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Lib Location:",
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 20.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 5.0,
                        ),),

                      SizedBox(width: 25.0,),
                      SizedBox(
                        width: 120,
                        child: Text(mod.locat!,
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 20.0,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 5.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),




                    ],
                  ),
                ),
                SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Book Description :",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 20.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 5.0,
                        ),),







                    ],
                  ),
                ),
               mod.bookdesc==""?SizedBox() :SizedBox(
                  width: MediaQuery.of(context).size.width*0.9,
                  height: 500,
                  child: Text(mod.bookdesc,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 5.0,
                    ),
                    //overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
