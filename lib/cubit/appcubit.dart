import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ourlib/Shared/cash.dart';
import 'package:ourlib/cubit/initcubit.dart';
import 'package:ourlib/cubit/appstates.dart';
import 'package:ourlib/models/bookmodel.dart';
import 'package:ourlib/models/searchmodel.dart';
import 'package:ourlib/models/usermodel.dart';
import 'package:ourlib/pages/buy/catg.dart';
import 'package:ourlib/pages/buy/allbooks.dart';
import 'package:ourlib/pages/buy/profilebuyer.dart';
import 'package:ourlib/pages/sell/home.dart';
import 'package:ourlib/pages/sell/mylib.dart';
import 'package:ourlib/pages/sell/profileseller.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;
import 'package:sqflite/sqflite.dart';

import '../Components/reuseable.dart';

class appcubit extends Cubit<appstates> {

  appcubit() : super(selinitstate());
  static appcubit get(context) => BlocProvider.of(context);
   int currentindex =0;
  var type = '';

  File? bookimage;
  XFile? pickedFile;
  late bookmodel? boomodel;
  String bookcover = '';
  var picker = ImagePicker();
  List<Widget> bottomselscreen = [
    home(),
    mylib(),
    profileseller(),
  ];
  List<Widget> bottombuyscreen = [
    allbooks(),
    catg(),
    profilebuyer(),
  ];
  void changbot(int index) {
    emit(changebotstate());
    currentindex = index;

  }
  int count=10;
  void changenumitems() {
    count+=10;
    emit(changenumstate());


  }

  void signout() {
    emit(signoutstate());
  }

  void setbooktype(String val) {
    type = val;
    emit(booktypestate());
  }

  Future<void> addbook({
    required String bookname,
    required String bookdesc,
    required String booktype,
  }) async {

    emit(addbookloadingstate());
    final User? user=await FirebaseAuth.instance.currentUser;
  var  value =await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();

      usermodel selmodel = await usermodel.fromJson(value.data()!);


   String bookid= await FirebaseFirestore.instance
        .collection('books').doc().id;
   await FirebaseFirestore.instance
       .collection('books').doc(bookid)
       .set({
      "bookname": bookname,
      "bookdesc": bookdesc ?? '',
      "booktype": booktype,
      "uid": await cashhelper.getid(key: 'id'),
      "bookimage":'https://firebasestorage.googleapis.com/v0/b/mylib-64c54.appspot.com/o/defimg.jpg?alt=media&token=64915338-9fa1-43b5-a2f7-ffee9594f0f9',
      "bookid": bookid,
     "booklib":selmodel.username,
     'locat':selmodel.location,
     'phone':selmodel.phone,
    })
        .then((value) {
      emit(addbooksuccessstate());
    }).catchError((error) {
      emit(addbookerrorstate());
      Fluttertoast.showToast(msg: "error add");
    });
  }

  Future<void> getImage() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      bookimage = File(pickedFile.path);
      emit(addimagesuccessstate());
    } else {
      emit(addimageerrorstate());
    }
  }

  Future<void> resetImage() async {
    bookimage = null;
  }

  Future<void> uploadcoverbook() async {

    await fs.FirebaseStorage.instance
        .ref()
        .child('books/${Uri.file(bookimage!.path).pathSegments.last}')
        .putFile(bookimage!)
        .then((value) async {
      await value.ref.getDownloadURL().then((value) {
        bookcover = value;
        emit(uploadimagesuccessstate());
      }).catchError((error) {
        emit(uploadimageerrorstate());
        Fluttertoast.showToast(msg: 'error was occured');
      });
    }).catchError((error) {
      emit(uploadimageerrorstate());
      Fluttertoast.showToast(msg: 'error was occured');
    });
  }

  Future<void> addbookwithimage({
    required String bookname,
    required String bookdesc,
    required String booktype,
  }) async {
    emit(addbookloadingstate());
    await uploadcoverbook();
    final User? user=await FirebaseAuth.instance.currentUser;
    var  value =await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();

    usermodel selmodel = await usermodel.fromJson(value.data()!);
    //emit(addbookloadingstate());
    String bookid= await FirebaseFirestore.instance
        .collection('books').doc().id;
    await FirebaseFirestore.instance
        .collection('books').doc(bookid)
        .set({
      "bookname": bookname,
      "bookdesc": bookdesc ?? '',
      "booktype": booktype,
      "uid": await cashhelper.getid(key: 'id'),
      'bookimage':bookcover,
      "bookid": bookid,
      'booklib':selmodel.username,
      'locat':selmodel.location,
      'phone':selmodel.phone,
    })
        .then((value) {
      emit(addbooksuccessstate());
    })
        .catchError((error) {
      emit(addbookerrorstate());
      Fluttertoast.showToast(msg: 'error was occured');
    });
  }


  Future<void> findbook({required String search}) async {
    booksearch = [];

    emit(findbookloadstate());
    await FirebaseFirestore.instance
        .collection('books')
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        if (element.data()['uid'] == await cashhelper.getid(key: 'id') &&
            element.data()['bookname'] == search) {
          booksearch.add(bookmodel.fromJson(element.data()));

        }
        /*else if(booksearch.isEmpty){
          Fluttertoast.showToast(msg: "No Book in this name",toastLength: Toast.LENGTH_SHORT,gravity: ToastGravity.CENTER,);
          emit(findbooksuccessstate());
        }*/
      });
      emit(findbooksuccessstate());
    }).catchError((error) {
      emit(findbookerrorstate());
    });
  }


  Future<void> resetsearch() async {
    booksearch = [];
  }
  Future<void> updatebook({
    required String bookname,
    required String bookdesc,
    required String booktype,
    required String id,
    required String img,
  })async {
    emit(updatebookloadingstate());
    final User? user=await FirebaseAuth.instance.currentUser;
    var  value =await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();

    usermodel selmodel = await usermodel.fromJson(value.data()!);

    boomodel = bookmodel(
      bookname: bookname,
      bookdesc: bookdesc ?? '',
      booktype: booktype,
      uid: await cashhelper.getid(key: 'id'),
      bookimage: img,
      bookid: id,
      booklib: selmodel.username,
      locat: selmodel.location,
      phone:selmodel.phone,
    );
    await FirebaseFirestore.instance.collection('books').doc(id)
        .update(boomodel!.toMap()).then((value) {
      emit(updatebooksuccessstate());
      Fluttertoast.showToast(msg: 'update success');
    }).catchError((error){emit(updatebookerrorstate());});
  }
  Future<void> updatebookwithimage({
    required String bookname,
    required String bookdesc,
    required String booktype,
    required String id,
})async {
    emit(updatebookloadingstate());
    await uploadcoverbook();
    final User? user=await FirebaseAuth.instance.currentUser;
    var  value =await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();

    usermodel selmodel = await usermodel.fromJson(value.data()!);
boomodel = bookmodel(
bookname: bookname,
bookdesc: bookdesc ?? '',
booktype: booktype,
uid: await cashhelper.getid(key: 'id'),
bookimage: bookcover,
bookid: id,
  booklib: selmodel.username,
  locat: selmodel.location,
  phone:selmodel.phone,
);
    await FirebaseFirestore.instance.collection('books').doc(id)
        .update(boomodel!.toMap()).then((value) {
          emit(updatebooksuccessstate());
          Fluttertoast.showToast(msg: 'update success',);
    }).catchError((error){
      emit(updatebookerrorstate());
      Fluttertoast.showToast(msg: 'error update');
    });
}
  Future<void> deletebook({

    required String id,
  })async {
    emit(deletebookloadingstate());

    await FirebaseFirestore.instance.collection('books').doc(id)
        .delete().then((value) {
          emit(deletebooksuccessstate());
      Fluttertoast.showToast(msg: 'delete success');
    }).catchError((error){
      emit(deletebookerrorstate());
      Fluttertoast.showToast(msg: 'error delete');
    });
  }
 void showMaterialDialog<T>({required BuildContext context, required Widget child})
 {
    showDialog<T>(context: context,
        builder: (BuildContext context)=>child,);
 }
  late List<bookmodel> exbook = [];
  Future<void> scibooks({required String type}) async {
    exbook = [];

    emit(findbookloadstate());
    await FirebaseFirestore.instance
        .collection('books')
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        if (element.data()['uid'] == await cashhelper.getid(key: 'id') &&
            element.data()['booktype'] == type) {
          exbook.add(bookmodel.fromJson(element.data()));
        }
      });
      emit(findbooksuccessstate());
    }).catchError((error) {
      emit(findbookerrorstate());
    });
  }
  late Database database;
  Future<Database?> newdata() async {
    emit(creatdbloadstate());
    database=  await openDatabase(
        'bar.db',
      version: 1,
      onCreate: (database,version){
     database.execute('CREATE TABLE bar (id INTEGER PRIMARY KEY,barname TEXT,bookname TEXT,date TEXT)')
         .then((value) {
           emit(creatdbsucstate());
           print('success');


     })
         .catchError((error){
           emit(creatdberrstate());
           print(error);
     });

      },
      onOpen: (database){
        emit(creatdbsucstate());
    }

    );
    return database;
  }
  Future insertdata({required String barname,required String bookname,required String date})async {
     await newdata();
     emit(insertdbloadstate());
    return await database.rawInsert( 'INSERT INTO bar(barname,bookname,date) VALUES("$barname","$bookname","$date")')
        .then((value) {
          emit(insertdbsucstate());
    print('success insert');})
        .catchError((error){
      emit(insertdberrstate());
      print(error.toString());
    });


        }

  Future getdata()async{
    await newdata();
    List<Map> res=await database.rawQuery('SELECT * FROM bar');
    print(res);
    bar =res;
    print(bar.length);
  }
  Future Updatedata({
    required int id,
    required String barname,
    required String bookname,
    required String date
})async{
    await newdata();
    await database.rawUpdate('UPDATE bar SET barname="$barname" ,bookname="$bookname",date="$date" WHERE id=?',[id])
    .then((value) {
      getdata();
      emit(updatesucstate());
    })
    .catchError((error){
      emit(updateerrstate());
    });


  }
  Future deletedata({required int id})async{
    await newdata();
    await database.rawDelete('DELETE  FROM bar WHERE id= ?' ,[id])
    .then((value) {
      getdata();
      emit(deletesucstate());
    })
    .catchError((error){
      emit(deleteerrstate());

    });


  }
  ////////////////////////////////////////////

  Future<void> albooks() async {
    reuse = [];

    emit(findbookloadstate());
    await FirebaseFirestore.instance
        .collection('books')
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        reuse.add(bookmodel.fromJson(element.data()));
      });
      emit(findbooksuccessstate());
    }).catchError((error) {
      emit(findbookerrorstate());
    });
  }
  Future<void> getbookbuylib({
    required String id,
}) async {
    libbooks = [];

    emit(findbookloadstate());
    await FirebaseFirestore.instance
        .collection('books')
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        if( element.data()['uid']==id){
          libbooks.add(bookmodel.fromJson(element.data()));
        }

      });
      emit(findbooksuccessstate());
    }).catchError((error) {
      emit(findbookerrorstate());
    });
  }
  Future<void> getlib({required String id}) async {

    emit(getlibloadstate());
    await FirebaseFirestore.instance
        .collection('users').doc(id)
        .get()
        .then((value) async {
      libmodel=await usermodel.fromJson(value.data()!);
      emit(getlibsucstate());
    })
        .catchError((error) {
      emit(getliberrstate());
    });
  }
  Future<void> gettypebook({required String type}) async {
    exbook = [];

    emit(findbookloadstate());
    await FirebaseFirestore.instance
        .collection('books')
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        if (element.data()['booktype'] == type) {
          exbook.add(bookmodel.fromJson(element.data()));
        }
      });
      emit(findbooksuccessstate());
    }).catchError((error) {
      emit(findbookerrorstate());
    });
  }

  Future<void> findbookbuyer({required String search}) async {
    buysearch = [];

    emit(findbookloadstate());
    await FirebaseFirestore.instance
        .collection('books')
        .get()
        .then((value) {
      value.docs.forEach((element) async {
        if (element.data()['bookname'] == search) {
          buysearch.add(bookmodel.fromJson(element.data()));

        }

      });
      emit(findbooksuccessstate());
    }).catchError((error) {
      emit(findbookerrorstate());
    });
  }

  }


