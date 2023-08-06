class usermodel
{
  late String username;
  late String email;
  late String password;
  late String phone;
  late  String uid;
  late  bool? isbuy;
  late String location;




  usermodel({
    required this.username,
    required this.email,
    required this.password,
    required this.uid,
    required this.phone,
    required this.isbuy,
    required this.location,
  });
  usermodel.fromJson(Map<String , dynamic> json)
  {
    username=json['username'];
    email=json['email'];
    password=json['password'];
    uid=json['uid'];
    phone=json['phone'];
    isbuy=json['isbuy'];;
    location=json['location'];
  }
  Map<String, dynamic>toMap(){
    return{
      'username':username,
      'email':email,
      'password':password,
       'uid':uid,
       'phone':phone,
       'isbuy':isbuy,
      'location':location,
    } ;
    }
  }
class usertype{
  late String email;
  late String password;
  late  String uid;
  late  bool? isbuy;
  late String? location;
  late String phone;
  late String username;
  usertype({
    required this.uid,
    required this.isbuy,
    required this.email,
    required this.password,
    required this.username,
    required this.phone,
    this.location,

});
  usertype.fromJson(Map<String , dynamic> json)
  {
    email=json['email'];
    password=json['password'];
    uid=json['uid'];
    phone=json['phone'];
    isbuy=json['isbuy'];;
    location=json['location'];
    username=json['username'];


  }
}

