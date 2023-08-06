import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ourlib/Components/functions.dart';
import 'package:ourlib/animation/slidanimation.dart';
import 'package:ourlib/cubit/appcubit.dart';
import 'package:ourlib/models/usermodel.dart';
import 'package:ourlib/pages/sell/home.dart';
import 'package:ourlib/layout/seller.dart';

import '../../cubit/appstates.dart';

class addbook extends StatelessWidget {
  var bookname = TextEditingController();
  var descr = TextEditingController();
  var booktype = 'Scientific';
  int x = 5;
//var type=Contr();
  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    return BlocConsumer<appcubit, appstates>(
      listener: (context, state) async {
        if (state is addbooksuccessstate) {
          Fluttertoast.showToast(msg: 'book add success');
          Navigator.of(context).pushAndRemoveUntil(AnimationsRoutertl(
            page: seller(),
          ), (route) => false);
          //navandfin(context, seller());
         await appcubit.get(context).resetImage();
        }
      },
      builder: (BuildContext context, state) {
        File? bookcover = appcubit.get(context).bookimage;
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () async {
                await appcubit.get(context).resetImage();
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
            title: Text('ADD'),
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
                    FontAwesomeIcons.book,
                    color: Colors.tealAccent,
                  ))
            ],
          ),
          body: Container(
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
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Add New Book To Your Library',
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
                            controller: bookname,
                            validator: (String? value) {
                              if (value!.length < 5) {
                                return 'Name of Book is too short';
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
                                  FontAwesomeIcons.book,
                                  color: Colors.grey,
                                ),
                              ),
                              hintText: "Bookname",
                              label: Text('Book Name'),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Container(
                            width: double.infinity,
                            height: 100,
                            child: TextFormField(
                              controller: descr,
                              textAlignVertical: TextAlignVertical.top,
                              maxLines: 15,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.description_outlined,
                                ),
                                hintText: "Enter a Description For Book",
                                label: Text('Description'),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  'Type Of Book :',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blueAccent,
                                    width: 1.0,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                child: DropdownButton(
                                  padding: EdgeInsets.only(
                                    left: 10.0,
                                  ),
                                  value: booktype,
                                  items: [
                                    'Scientific',
                                    'Literary',
                                    'Poetry',
                                    'Prose',
                                    'Novel',
                                    'Religious',
                                  ]
                                      .map((e) => DropdownMenuItem(
                                            child: Text('$e'),
                                            value: e,
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    booktype = value!;
                                    appcubit.get(context).setbooktype(value);
                                  },
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Center(
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                image: bookcover == null
                                    ? DecorationImage(
                                        image: AssetImage('assets/cov.jpg'),
                                        fit: BoxFit.cover,
                                      )
                                    : DecorationImage(
                                        image: FileImage(bookcover),
                                        fit: BoxFit.cover,
                                      ),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 3.0,
                                  style: BorderStyle.solid,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurStyle: BlurStyle.outer,
                                    blurRadius: 10.0,
                                    color: Colors.blueGrey,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Container(
                                  width: 200.0,
                                  child: InkWell(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        bookcover == null
                                            ? FaIcon(
                                          FontAwesomeIcons.image,
                                          color: Colors.blueAccent,
                                          size: 35.0,
                                        ):Center(
                                          child: CircleAvatar(
                                            child: Image(
                                              image:AssetImage('assets/correctsign.jpg') ,
                                            ),

                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        bookcover == null
                                            ? Text(
                                          'Add Cover Book',
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold),
                                        )
                                        :Text(
                                          'Chang Cover Book',
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    onTap: () async {
                                      await appcubit.get(context).getImage();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          ConditionalBuilder(
                            condition: state is! addbookloadingstate,
                            builder: (context) => Center(
                              child: Container(
                                width: 200.0,
                                height: 35.0,
                                padding: EdgeInsets.symmetric(
                                  vertical: 0,
                                  horizontal: 30,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent,
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: MaterialButton(
                                  onPressed: () async {
                                    if(bookcover==null){
                                      if (formkey.currentState!.validate()) {
                                        await appcubit.get(context).addbook(
                                          bookname: bookname.text,
                                          bookdesc: descr.text,
                                          booktype: booktype,
                                        );
                                      }
                                    }else{
                                      if (formkey.currentState!.validate()){
                                        await appcubit.get(context).addbookwithimage(bookname: bookname.text, bookdesc: descr.text, booktype: booktype);
                                      }
                                    }

                                  },
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 6.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            fallback: (BuildContext context) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
