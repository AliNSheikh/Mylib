import '../models/usermodel.dart';

abstract class initstates{}
 //abstract class registerstates extends appstates{}
//abstract class loginstates extends appstates{}

class appinitstate extends initstates{}
//class registerinitstate extends registerstates{}
//class logininitstate extends loginstates{}

class setbuyerstate extends initstates{}
class setsellerstate extends initstates{}
class changeiconpasstate extends initstates{}
class signsuccesstate extends initstates{
 final String uid;

  signsuccesstate(this.uid);

}
class signloadstate extends initstates{}
class signerrorstate extends initstates{
 final String error;
 signerrorstate(this.error);
}
class creatsuccesstate extends initstates{}
class createrrorstate extends initstates{
 final String error;
 createrrorstate(this.error);
}
class loginsuccessstate extends initstates{
 final String uid;
  loginsuccessstate(this.uid);
}
class loginloadstate extends initstates{}
class loginerrorstate extends initstates{
 final String error;

  loginerrorstate(this.error);

}
class recoversuccessstate extends initstates{

}
class recoverloadstate extends initstates{}
class recovererrorstate extends initstates{

}
class getdatasuccessstate extends initstates{
 final bool tt;
 final String id;


  getdatasuccessstate(this.tt, this.id,);
}
class getdataerrorstate extends initstates{}

class geterrorstate extends initstates{}

class  getsuccessstate extends initstates{
 usermodel selmodel;
 getsuccessstate(this.selmodel);

  //usermodel get selmodel => selmodel;
}

class getloadingstate extends initstates{}
class updateuserloadstate extends initstates{}
class updateusersucstate extends initstates{}
class updateusererstate extends initstates{}





