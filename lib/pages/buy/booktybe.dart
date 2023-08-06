import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ourlib/pages/buy/bookdata.dart';

import '../../animation/slidanimation.dart';
import '../../cubit/appcubit.dart';
import '../../cubit/appstates.dart';
import '../../models/bookmodel.dart';

class booktype extends StatelessWidget {
String type;
booktype({required this.type});

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (BuildContext contex) => appcubit()..gettypebook(type: type),
      child: BlocConsumer<appcubit, appstates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              title: Text(type),
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.tealAccent,
                fontSize: 16.0,
                letterSpacing: 1.0,
              ),

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
              child: ConditionalBuilder(
                condition: state is! findbookloadstate,
                builder: (context) => SingleChildScrollView(
                  child: appcubit.get(context).exbook.length==0? Container(
                      height: MediaQuery.of(context).size.height*0.9,
                      child: Center(child: Text('NO Books in this section')))
                      :Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height*0.9,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) => newbuild(appcubit
                          .get(context)
                          .exbook[
                      index],context) /*buildbook(selcubit.get(context).exbook[index],context) */,
                      itemCount: appcubit.get(context).exbook.length,
                    ),
                  ),
                ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator()),
              ),
            ),
          );
        },
      ),
    );
  }
Widget buildbook(bookmodel model, context) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    width: double.infinity,
    height: 300.0,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage('${model.bookimage}'),
        fit: BoxFit.cover,
        opacity: .8,
      ),
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
      /* border: Border.all(
                            color: Colors.blueGrey,
                            width: 5.0,
                            style: BorderStyle.solid,
                          ),*/
    ),
    child: Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(
                15.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Book Name:   ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                            fontSize: 14,
                            backgroundColor: Colors.white),
                      ),
                      Container(
                          width: 125,
                          child: Text(
                            '${model.bookname}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontSize: 18,
                                backgroundColor: Colors.white),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 60.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Book Description:   ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                            fontSize: 14,
                            backgroundColor: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                      alignment: AlignmentDirectional.topStart,
                      width: 200,
                      height: 120,
                      child: Text(
                        '${model.bookdesc}',
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.lightBlue,
                            fontSize: 18,
                            backgroundColor: Colors.white),
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Text(
                        'Book Type:   ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.amber,
                            fontSize: 14,
                            backgroundColor: Colors.white),
                      ),
                      Container(
                          width: 125,
                          child: Text(
                            '${model.booktype}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontSize: 18,
                                backgroundColor: Colors.white),
                          )),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          AnimationsRoutefade(
                            page: bookdata(
                              mod: model,
                            ),
                          ),
                        );
                      },
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: FaIcon(
                            FontAwesomeIcons.info,
                            color: Colors.blue,
                            size: 25.0,
                          ))),

                ],
              ),
            ),
          ],
        ),
      ],
    ),
  ),
);
Widget newbuild(bookmodel model,BuildContext context) => Padding(
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
                  expanded:Row(
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.1,
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  AnimationsRoutefade(
                                    page: bookdata(
                                      mod: model,
                                    ),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: FaIcon(
                                    FontAwesomeIcons.arrowRight,
                                    color: Colors.blue,
                                    size: 25.0,
                                  ))),

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
