import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

String RedColor = '#${Colors.red.value.toRadixString(16).substring(2, 8)}';
String DarkRedColor = '#${Colors.red[800].value.toRadixString(16).substring(2, 8)}';
String PinkColor = '#${Colors.pinkAccent.value.toRadixString(16).substring(2, 8)}';
String DarkPinkColor = '#${Colors.pink[800].value.toRadixString(16).substring(2, 8)}';
String PurpleColor = '#${Colors.purple.value.toRadixString(16).substring(2, 8)}';
String DarkPurpleColor = '#${Colors.purple[800].value.toRadixString(16).substring(2, 8)}';
String BlueColor = '#${Colors.blue.value.toRadixString(16).substring(2, 8)}';
String DarkBlueColor = '#${Colors.blue[800].value.toRadixString(16).substring(2, 8)}';
String GreenColor = '#${Colors.green.value.toRadixString(16).substring(2, 8)}';
String DarkGreenColor = '#${Colors.green[800].value.toRadixString(16).substring(2, 8)}';
String YellowColor = '#${Colors.yellow.value.toRadixString(16).substring(2, 8)}';
String DarkYellowColor = '#${Colors.yellow[800].value.toRadixString(16).substring(2, 8)}';
String OrangeColor = '#${Colors.orange.value.toRadixString(16).substring(2, 8)}';
String DarkOrangeColor = '#${Colors.orange[800].value.toRadixString(16).substring(2, 8)}';
String BrownColor = '#${Colors.brown.value.toRadixString(16).substring(2, 8)}';
String DarkBrownColor = '#${Colors.brown[800].value.toRadixString(16).substring(2, 8)}';
String BlackColor = '#${Colors.black.value.toRadixString(16).substring(2, 8)}';
String WhiteColor = '#${Colors.white.value.toRadixString(16).substring(2, 8)}';
String GreyColor = '#${Colors.grey.value.toRadixString(16).substring(2, 8)}';
String DarkGreyColor = '#${Colors.grey[800].value.toRadixString(16).substring(2, 8)}';
String TealColor =  '#${Colors.teal.value.toRadixString(16).substring(2, 8)}';
String DarkTealColor =  '#${Colors.teal[800].value.toRadixString(16).substring(2, 8)}';

List<Color> mycolors = [
  HexColor(RedColor),
  HexColor(DarkRedColor),
  HexColor(PinkColor),
  HexColor(DarkPinkColor),
  HexColor(PurpleColor),
  HexColor(DarkPurpleColor),
  HexColor(BlueColor),
  HexColor(DarkBlueColor),
  HexColor(GreenColor),
  HexColor(DarkGreenColor),
  HexColor(YellowColor),
  HexColor(DarkYellowColor),
  HexColor(OrangeColor),
  HexColor(DarkOrangeColor),
  HexColor(BrownColor),
  HexColor(DarkBrownColor),
  HexColor(BlackColor),
  HexColor(WhiteColor),
  HexColor(GreyColor),
  HexColor(DarkGreyColor),
  HexColor(TealColor),
  HexColor(DarkTealColor),
];