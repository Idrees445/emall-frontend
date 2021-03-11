import 'package:emall/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

FocusNode textSecondFocusNode = new FocusNode();

Widget Form(String Title,TextEditingController controller,BuildContext context,String Description){
  return Container(
    decoration: FormDecoration(),
    width: (MediaQuery.of(context).size.width > 400)?
    MediaQuery.of(context).size.width - 200:
    MediaQuery.of(context).size.width - 50,
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
    child: TextFormField(
      controller: controller,
      autofocus: false,
      onFieldSubmitted: (String value) {
        FocusScope.of(context).requestFocus(textSecondFocusNode);
      },
      maxLines: (Title == Description)?20:1,
      maxLength: (Title == Description)?4000:100,
      decoration: InputDecoration(
        counterStyle: TextStyle(height: double.minPositive,),
        counterText: "",
        hintText: Title,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    ),
  );
}