import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

BoxDecoration AddProductDecoration(var color,int shadow){
  return BoxDecoration(
    color: color,
    shape: BoxShape.circle,
    border: Border.all(color: Colors.blue,width: 2.0),
    boxShadow: [BoxShadow(
      color: Colors.grey[shadow],
      blurRadius: 5.0,
    ),],
  );
}

BoxDecoration FormDecoration(){
  return BoxDecoration(
    color: Colors.grey[100],
    border: Border.all(color: Colors.blue,width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
    boxShadow: [BoxShadow(
      color: Colors.grey[500],
      blurRadius: 10.0,
      offset: Offset(0,0),
    ),],
  );
}

BoxDecoration ChooseProductDecoration(){
  return BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.blue,width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(15.0)),
    boxShadow: [BoxShadow(
      color: Colors.grey[500],
      blurRadius: 10.0,
      offset: Offset(0,0),
    ),],
  );
}

BoxDecoration curveDecoration(double radius,var color,int shadow){
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.all(Radius.circular(radius)),
    boxShadow: [BoxShadow(
      color: Colors.grey[shadow],
      blurRadius: 5.0,
    ),],
  );
}

BoxDecoration curveHeadDecoration(var color,int shadow,double BlurRadius){
  return BoxDecoration(
    color: color,
    boxShadow: [BoxShadow(
      color: Colors.grey[shadow],
      blurRadius: BlurRadius,
    ),],
  );
}

BoxDecoration boxdecoration(var color,int shadow,double BlurRadius,double radius,Offset _offset){
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.all(Radius.circular(radius)),
    boxShadow: [BoxShadow(
      color: Colors.grey[shadow],
      blurRadius: BlurRadius,
      offset: _offset,
    ),],
  );
}

BoxDecoration SettingButton(String selected, String text){
  return BoxDecoration(
    border: Border.all(color: (selected == text)?Colors.grey[600]:Colors.blue,width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(5.0)),
    boxShadow: [BoxShadow(
      color: Colors.grey[200],
      blurRadius: 5.0,
    ),],
  );
}

SizedBox VSpace(double height){
  return SizedBox(
    height: height,
  );
}

SizedBox HSpace(double width){
  return SizedBox(
    width: width,
  );
}

TextStyle mystyle(double size,var weight,Color Colors){
  return TextStyle(
    fontSize: size,
    fontWeight: weight,
    color: Colors,
  );
}

Widget divider(){
  return Container(
    width: 200,
    height: 1.0,
    color: Colors.white,
  );
}

Widget dividerc(var Colors,double width){
  return Container(
    width: width,
    height: 1.0,
    color: Colors,
  );
}

TextStyle mytextstyle(double size, FontWeight weight, var Colors){
  return TextStyle(
    fontSize: size,
    fontWeight: weight,
    color: Colors,
  );
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}