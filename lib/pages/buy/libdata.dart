import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ourlib/layout/buyer.dart';
import 'package:ourlib/pages/buy/bookdata.dart';
import 'package:wave_transition/wave_transition.dart';

import '../../Components/reuseable.dart';
import '../../cubit/appcubit.dart';
import '../../cubit/appstates.dart';
import '../../models/bookmodel.dart';

class libdata extends StatelessWidget {
  String id;
  libdata({required this.id});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext contex) => appcubit()..getlib(id: id)..getbookbuylib(id: id),

      child:  BlocConsumer<appcubit, appstates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
              appBar:  AppBar(
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
                title: Text('Library Details '),
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
                        FontAwesomeIcons.bookOpen,
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
                width: double.infinity,
                child: SingleChildScrollView(
                  child: ConditionalBuilder(
                    condition: state is! getlibloadstate,
                    builder: (context)=> buildlib(context,state),
                    fallback:(context)=> Center(child: CircularProgressIndicator(),) ,
                  ),
                ),
              )
          );
        },
      ),
    );
  }
  Widget buildlib(BuildContext context,state)=> Padding(
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Library:",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 5.0,
                ),),

              SizedBox(width: 25.0,),
              SizedBox(
                width: 150,
                child: Text(libmodel!.username,
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 15.0,
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
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Location:",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 5.0,
                ),),

              SizedBox(width: 25.0,),
              SizedBox(
                width: 150,
                child: Text(libmodel!.location,
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 15.0,
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
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Phone:",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 5.0,
                ),),

              SizedBox(width: 25.0,),
              SizedBox(
                width: 150,
                child: Text(libmodel!.phone,
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 15.0,
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
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Email",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 5.0,
                ),),

              SizedBox(width: 25.0,),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.6,
                child: Text(libmodel!.email,
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 15.0,
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
        SizedBox(
          height: 20.0,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("All Books",style: TextStyle(
                fontSize: 30.0,

                fontStyle: FontStyle.italic,

              ),),

            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
          ),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width*0.4,
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
        ),
        SizedBox(height: 20.0,),
        ConditionalBuilder(
          condition: state is! findbookloadstate,
          builder: (context)=>builditems(context),
          fallback: (context)=>CircularProgressIndicator(), ),


      ],
    ),
  );
  Widget builditems( BuildContext context)=>Column(
    children: [
      Container(
        // color: Colors.red,
        child: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 1/1.4,
          children: List.generate(
              libbooks.length,
                  (index) =>buildgrid(libbooks[index],context) ),
        ),
      ),
    ],
  );
  Widget buildgrid(bookmodel model,BuildContext context)=>InkWell(
    onTap: (){
      Navigator.push(context , WaveTransition(
          child: bookdata(mod: model,),

          center: FractionalOffset(0.90, 0.90),

          duration: Duration(milliseconds: 3000),
          settings: RouteSettings(arguments: "yeah! it works!")),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.2,
            width: MediaQuery.of(context).size.width*2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.0),
            ) ,
            child: Image(
              height: MediaQuery.of(context).size.height*0.2,
              image: NetworkImage(model.bookimage),

              width: MediaQuery.of(context).size.width*2,
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width*2,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                        Colors.white,
                        Colors.white12,
                        Colors.grey,
                        //Colors.blue,
                      ]),
                  borderRadius: BorderRadius.circular(20.0)
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text("Book Name : ${model.bookname}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.green),),
                    ),
                    SizedBox(
                      height: 10.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Spacer(),
                          Icon(Icons.arrow_circle_right_outlined)
                        ],
                      ),
                    ),
                    Text("Type : ${model.booktype}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.green),),
                  ],
                ),
              )),

        ],
      ),
    ),
  );
}
