import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ourlib/Components/functions.dart';
import 'package:ourlib/animation/slidanimation.dart';
import 'package:ourlib/cubit/appcubit.dart';
import 'package:ourlib/cubit/appstates.dart';
import 'package:ourlib/models/bookmodel.dart';
import 'package:ourlib/pages/sell/modifybook.dart';
import 'package:ourlib/layout/seller.dart';

import '../../Components/reuseable.dart';
enum ButtonAction{
  cancel,
  Agree,
}
class serachbook extends StatelessWidget {

  TextEditingController searchcon=TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<appcubit,appstates>(
      listener: (context,state) async {
      if(state is findbookloadstate){
        await appcubit.get(context).resetImage();
      }
      },
      builder:(context,state)  {


        return Scaffold(
          appBar:  AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () async {
                appcubit.get(context).resetsearch();

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
            title: Text('Modify Book'),
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.tealAccent,
              fontSize: 16.0,
              letterSpacing: 1.0,
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                    onPressed: () {},
                    icon: FaIcon(
                      FontAwesomeIcons.penToSquare,
                      color: Colors.tealAccent,
                    )),
              )
            ],
          ),
          body: SingleChildScrollView(

              child: Container(
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formkey,
                        child: TextFormField(
                          controller: searchcon,
                          validator: ( String? val){
                            if(val!.isEmpty){
                              return "Search Must Not be Empty";
                            }else{
                              return null;
                            }
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              hintText: "Input Name Of Book",
                              suffixIcon:InkWell(
                                  onTap: () async {
                                    String mysearch=searchcon.text;
                                    if(formkey.currentState!.validate()){
                                    await appcubit.get(context).findbook(search: mysearch);
                                    if(booksearch.length==0){
                                      Fluttertoast.showToast(msg: "No Book in this name",gravity: ToastGravity.TOP);
                                    }
                                    }

                                  },
                                  child: FaIcon(FontAwesomeIcons.magnifyingGlass, color: Colors.grey,))
                          ),
                          onFieldSubmitted: (value) async {
                            if(formkey.currentState!.validate()){
                              String mysearch=searchcon.text;
                              await appcubit.get(context).findbook(search: mysearch);
                              if(booksearch.length==0){
                                Fluttertoast.showToast(msg: "No Book in this name",gravity: ToastGravity.TOP);
                              }
                            }
                          },
                        ),
                      ),
                    ),
                    ConditionalBuilder(
                      condition: state is! findbookloadstate,
                      builder: (context)=> SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height*0.9,
                          child:ListView.builder(

                            scrollDirection: Axis.vertical,
                            itemBuilder: (context,index)=>
                                buildsearch(booksearch[index],context) ,
                            itemCount: booksearch.length,
                          ),
                        ),
                      ) ,
                      fallback:(context)=>Center(child: CircularProgressIndicator()),
                    ),
                  ],
                ),
              ),
            ),
          );


    },
    );

  }
  Widget buildsearch(bookmodel model,context)=>Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(15),
            topLeft: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.outer,
            blurRadius: 10.0,
            color: Colors.grey,
            offset: Offset(0, 0),
          )
        ],
      ),
      child: Card(
          clipBehavior: Clip.antiAlias,
          child: ExpandableNotifier(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(10)),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 200.0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(15),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(15),
                            topLeft: Radius.circular(10)),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                            image: NetworkImage('${model.bookimage}'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  ExpandablePanel(
                    header: Padding(
                        padding: EdgeInsets.only(top: 10.0, left: 10),
                        child: Text('Book Name: ${model.bookname}')),
                    collapsed: Text(
                      'Book Description: ${model.bookdesc}',
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 175.0,
                                child: Text(
                                  'Book Description: ${model.bookdesc}',
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                              SizedBox(
                                height: 30.0,
                              ),
                              Text(
                                'Book Type: ${model.booktype}',
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    AnimationsRoutefade(
                                      page: modifybook(
                                        mod: model,
                                      ),
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: FaIcon(
                                      FontAwesomeIcons.penToSquare,
                                      color: Colors.blue,
                                      size: 25.0,
                                    ))),
                            SizedBox(
                              height: 150,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: IconButton(
                                  onPressed: () async {
                                    appcubit
                                        .get(context)
                                        .showMaterialDialog<ButtonAction>(
                                      context: context,
                                      child: AlertDialog(
                                        title: const Text(
                                            'Are you sure you want to delete the item?'),
                                        content: Text(
                                          'If you want to delete the item, choose AGREE or cancel the operation',
                                        ),
                                        actions: <Widget>[
                                          InkWell(
                                            child: const Text('Cancel'),
                                            onTap: () {
                                              Navigator.pop(context,
                                                  ButtonAction.cancel);
                                            },
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          InkWell(
                                            child: const Text('Agree'),
                                            onTap: () async {
                                              await appcubit
                                                  .get(context)
                                                  .deletebook(
                                                  id: '${model.bookid}');
                                              Navigator.pop(context,
                                                  ButtonAction.Agree);
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(
                                                  AnimationsRoutertl(
                                                    page: seller(),
                                                  ),
                                                      (route) => false);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.delete_outline_outlined,
                                    color: Colors.blue,
                                    size: 25.0,
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 10.0),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )),
    ),
  );
}
