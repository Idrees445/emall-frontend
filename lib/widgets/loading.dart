import 'package:emall/widgets/widgets.dart';
import 'package:flutter/material.dart';

Widget Loading(bool loading){
  return (loading)?Container(
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(),
      )):VSpace(0.0);
}