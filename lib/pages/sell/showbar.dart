import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:ourlib/cubit/appcubit.dart';
import 'package:ourlib/cubit/appstates.dart';

import '../../Components/reuseable.dart';
import '../../animation/slidanimation.dart';
import '../../layout/seller.dart';
import 'modifybar.dart';

enum ButtonAction {
  cancel,
  Agree,
}

class showbar extends StatelessWidget {
  const showbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appcubit, appstates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () async {
                Navigator.of(context).pushAndRemoveUntil(
                    AnimationsRoutertl(
                      page: seller(),
                    ),
                    (route) => false);
                //navandfin(context, seller());
              },
              icon: FaIcon(
                FontAwesomeIcons.arrowLeftLong,
                color: Colors.tealAccent,
              ),
            ),
            title: Text('All Borrower'),
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: Colors.tealAccent,
              fontSize: 16.0,
              letterSpacing: 1.0,
            ),
            actions: [
              IconButton(
                  onPressed: ()async {},
                  icon: FaIcon(
                    FontAwesomeIcons.user,
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
              child: bar.length == 0
                  ? Center(child: Text('NO Barrower'))
                  : Container(
                      height: double.maxFinite,
                      child: ListView.builder(
                          itemBuilder: (context, index) =>
                              builditem(bar[index], context),
                          itemCount: bar.length),
                    )),
        );
      },
    );
  }

  Widget builditem(Map model, context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GFAccordion(
                title: 'Book Name :${model['bookname']}'.substring(0,15),
                contentBorderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),

                    ),
               contentBorder: Border.all(
                 color: Colors.lightGreenAccent,
                 style: BorderStyle.solid,
                 width: .5,
               ),
                contentChild: Container(
                  width: double.maxFinite,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.lightGreenAccent,
                          Colors.lightGreenAccent,
                          Colors.white,
                          Colors.white,
                        ]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                                'Barrower Name : ${model['barname']}'
                                    .substring(0, 20),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1),
                            Spacer(),
                            IconButton(
                                onPressed: () {

                                  Navigator.of(context).push(AnimationsRoutefade(
                                    page: modbar(
                                     id: '${model['id']}',
                                      bar: '${model['barname']}',
                                      book:'${model['bookname']}' ,
                                      date: '${model['date']}',
                                    ),
                                  ));
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.penToSquare,
                                  color: Colors.greenAccent,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          children: [
                            Text('Barrow Date: ${model['date']}'.substring(0,25),overflow: TextOverflow.ellipsis,),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  appcubit.get(context).showMaterialDialog<ButtonAction>(
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
                                                Navigator.pop(
                                                    context, ButtonAction.cancel);
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
                                                    .deletedata(id: model['id'])
                                                    .then((value) {
                                                  Fluttertoast.showToast(
                                                      msg: "Deleted Successfully");
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                },
                                icon: Icon(
                                  Icons.delete_outline_outlined,
                                  color: Colors.red,
                                )),
                          ],
                        ),
                      ],
                    ),
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
            ],
          ),
        ),
      );
}
