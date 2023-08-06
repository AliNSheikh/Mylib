import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ourlib/Components/functions.dart';
import 'package:ourlib/cubit/appcubit.dart';
import 'package:ourlib/cubit/appstates.dart';

import '../../animation/slidanimation.dart';
import '../../layout/seller.dart';

class addbar extends StatelessWidget {

var barname=TextEditingController();
  var bookname=TextEditingController();
  var datecon=TextEditingController();

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    return BlocConsumer<appcubit,appstates>(
      listener: (context,state){},
      builder:(context,state){
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () async {

                Navigator.of(context).pushAndRemoveUntil(AnimationsRoutertl(
                  page: seller(),
                ), (route) => false);
                //navandfin(context, seller());
              },
              icon: FaIcon(
                FontAwesomeIcons.arrowLeftLong,
                color: Colors.tealAccent,
              ),
            ),
            title: Text('ADD Borrower'),
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.tealAccent,
              fontSize: 16.0,
              letterSpacing: 1.0,
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.user,
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
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey,
                  child: Column(
                    children:[
                      SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        controller: barname,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Borrower Name is too short';
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
                          hintText: "Enter Borrower Name",
                          label: Text('Borrower Name'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        controller: bookname,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Book Name must not be empty  ';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding:const EdgeInsets.only(top: 8.0, left: 12.0),
                            child: FaIcon(
                              FontAwesomeIcons.book,
                              color: Colors.grey,
                            ),
                          ),
                          hintText: "Enter Book Name",
                          label: Text('Book Name'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        controller: datecon,
                        validator: (String? value) {
                          if (value!.isEmpty ) {
                            return 'Date Must be Edit';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.datetime,
                        onTap: (){
                          showDatePicker(context: context, initialDate: DateTime.now(), firstDate:  DateTime(1900), lastDate: DateTime.parse('3000-01-01'),)
                              .then((value) {
                            datecon.text=DateFormat.yMMMd().format(value!);
                          });
                        },

                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.calendar_month_outlined,
                          ),
                          //appcubit.get(context).suffix,
                          hintText: "Enter Date",
                          label: Text('Date'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 45.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! insertdbloadstate,
                        builder: (context)=> Container(
                          height: 75,
                          width: 100,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.blue,
                                  Colors.blueAccent,
                                  Colors.lightBlueAccent,
                                  Colors.lightBlue,
                                ]),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          //  color: Colors.lightBlue,
                          child: MaterialButton(
                            onPressed: () async {
                              if(formkey.currentState!.validate()) {
                                await appcubit.get(context).insertdata(
                                    barname: barname.text,
                                    bookname: bookname.text,
                                    date: datecon.text
                                ).then((value){
                                  Fluttertoast.showToast(msg: 'Add Successfully');
                                  Navigator.of(context).push(AnimationsRoutefade(
                                      page:seller()));
                                });

                              };
                            },
                            child: Text(
                              "Save",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                letterSpacing: 6.0,
                              ),
                            ),
                          ),
                        ),
                        fallback: (context)=>Center(child: CircularProgressIndicator(),),
                      ),
                    ],),
                ),
              ),
            ),
          ),
        );
      } ,

    );
  }
}
