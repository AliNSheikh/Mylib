import 'dart:io';

import 'package:flutter/material.dart';

class AnimationsRoutertl extends PageRouteBuilder{
  final page;
  AnimationsRoutertl({
    this.page,
}): super(
    transitionDuration: Duration(milliseconds: 700),
   reverseTransitionDuration:  Duration(milliseconds: 700),
    pageBuilder: (context,animation,animation2,)=>page,
    transitionsBuilder: (context,animation,animation2,child)=>
      SlideTransition(
        position: animation.drive(Tween(begin:Offset(1,0),end: Offset(0,0))),
        child: child,),
  );
}
class AnimationsRouteltr extends PageRouteBuilder{
  final page;
  AnimationsRouteltr({
    this.page,
  }): super(
    transitionDuration: Duration(milliseconds: 700),
    reverseTransitionDuration:  Duration(milliseconds: 700),
    pageBuilder: (context,animation,animation2,)=>page,
    transitionsBuilder: (context,animation,animation2,child)=>
        SlideTransition(
          position: animation.drive(Tween(begin:Offset(-1,0),end: Offset(0,0))),
          child: child,),
  );
}
class AnimationsRoutefade extends PageRouteBuilder{
  final page;
  AnimationsRoutefade({
    this.page,
  }): super(
    transitionDuration: Duration(milliseconds: 700),
    reverseTransitionDuration:  Duration(milliseconds: 700),
    pageBuilder: (context,animation,animation2,)=>page,
    transitionsBuilder: (context,animation,animation2,child)=>
        FadeTransition(
          opacity: animation,
          child: child,),
  );
}
class AnimationsRoutefade1 extends PageRouteBuilder{
  final page;
  AnimationsRoutefade1({
    this.page,
  }): super(
    transitionDuration: Duration(milliseconds: 200),
    reverseTransitionDuration:  Duration(milliseconds: 200),
    pageBuilder: (context,animation,animation2,)=>page,
    transitionsBuilder: (context,animation,animation2,child)=>
        FadeTransition(
          opacity: animation,
          child: child,),
  );
}
class scaleanimation extends PageRouteBuilder{
  final page;
  scaleanimation({
    this.page,
  }): super(
    transitionDuration: Duration(milliseconds: 700),
    reverseTransitionDuration:  Duration(milliseconds: 700),
    pageBuilder: (context,animation,animation2,)=>page,
    transitionsBuilder: (context,animation,animation2,child)=>
        ScaleTransition(

          scale: animation,
          child: child,),
  );
}
class opestscale extends PageRouteBuilder{
  final page;
  opestscale({
    this.page,
  }): super(
    transitionDuration: Duration(milliseconds: 700),
    reverseTransitionDuration:  Duration(milliseconds: 700),
    pageBuilder: (context,animation,animation2,)=>page,
    transitionsBuilder: (context,animation,animation2,child)=>
        ScaleTransition(

          scale: animation2,
          child: child,),
  );
}
