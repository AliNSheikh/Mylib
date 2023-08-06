import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ourlib/cubit/appcubit.dart';
import 'package:ourlib/cubit/appstates.dart';
import 'package:ourlib/models/bookmodel.dart';
import 'package:ourlib/pages/buy/bookdata.dart';
import '../../Components/reuseable.dart';
import 'package:wave_transition/wave_transition.dart';

class allbooks extends StatelessWidget {
  int itemcount=4;

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<appcubit,appstates>(
      listener: (context,state){
        if(state is changenumstate){
          if(appcubit.get(context).count>reuse.length){
            Fluttertoast.showToast(msg: "This is all books");
          }
        }
      },
      builder:  (context,state){

        return  Scaffold(
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
                    height: 15.0,
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
                        IconButton(onPressed: () async {
                          await appcubit.get(context).albooks();
                        },
                            icon: Icon(
                              Icons.refresh
                            ))
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
                  SizedBox(
                    height: 15.0,
                  ),
                  ConditionalBuilder(
                    condition: state is! findbookloadstate,
                      builder: (context)=>builditems(context),
                      fallback: (context)=>CircularProgressIndicator(), ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: [
                            Colors.black,
                            Colors.blueGrey,
                            Colors.grey,
                            //Colors.blue,
                          ]),
                    ),
                    child: MaterialButton(
                      onPressed: () async {
                        appcubit.get(context).changenumitems();
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Show More",
                            style: TextStyle(

                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              letterSpacing: 6.0,
                            ),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Icon(Icons.arrow_circle_down,color: Colors.amber,size: 30.0,)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60.0,
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
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
              appcubit.get(context).count< reuse.length? appcubit.get(context).count
              : reuse.length,
                  (index) =>buildgrid(reuse[index],context) ),
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
