class bookmodel
{
  late String bookname;
  late String bookdesc;
  late String booktype;
  late  String? uid;
  late  String bookimage;
  late  String? bookid;
  late String? booklib;
  late String? locat;
  late String? phone;


  bookmodel({
    required this.bookname,
    required this.bookdesc,
    required this.booktype,
    required this.uid,
    required this.bookimage,
     this.booklib,
    this.locat,
    this.bookid,
    this.phone,

  });
  bookmodel.fromJson(Map<String , dynamic> json)
  {
    bookname=json['bookname'];
    bookdesc=json['bookdesc'];
    booktype=json['booktype'];
    uid=json['uid'];
    bookimage=json['bookimage'];
    bookid=json['bookid'];
    locat=json['locat'];
    booklib=json['booklib'];
    phone=json['phone'];

  }
  Map<String, dynamic>toMap(){
    return{
      'bookname':bookname,
      'bookdesc':bookdesc,
      'booktype':booktype,
      'uid':uid,
      'bookimage':bookimage,
      'bookid':bookid,
      'locat':locat,
      'booklib':booklib,
      'phone':phone,
    } ;
  }
}


