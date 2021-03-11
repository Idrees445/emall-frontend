import 'package:emall/Dashboard/dashboard.dart';
import 'package:emall/Dashboard/subscreens/products/FullProduct.dart';
import 'package:emall/Dashboard/subscreens/products/addproduct.dart';
import 'package:emall/auth/register.dart';
import 'package:emall/models/newProduct.dart';
import 'package:emall/models/vender.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'auth/login.dart';

bool languageEnglish = true;
FluroRouter router = new FluroRouter();
vender Vender = vender();
NewProduct newProduct;
int number_of_products = 11;
List<NewProduct> AllProductList = [];
List<String> AllCategoryList = [];
List<String> AllSubCategoryList = [];
int ToFullImageIndex = 0;
String ToFullImageTag = "";

void main() {
  router.define(
    '/auth/login',
    handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return Login();
      },
    ),
    transitionType: TransitionType.fadeIn,
  );

  router.define(
    '/auth/register',
    handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return Register();
      },
    ),
    transitionType: TransitionType.fadeIn,
  );

  router.define(
    '/vender/dashboard',
    handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return Dashboard();
      },
    ),
    transitionType: TransitionType.fadeIn,
  );

  router.define(
    '/vender/dashboard/addproduct',
    handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return VenderProduct();
        // return Testing();
      },
    ),
    transitionType: TransitionType.fadeIn,
  );

  router.define(
    '/vender/dashboard/fullproduct',
    handler: new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return FullProduct();
      },
    ),
    transitionType: TransitionType.fadeIn,
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    onGenerateRoute: router.generator,
    initialRoute: '/auth/login',
    title: "Appname",
    theme: ThemeData(
      fontFamily: 'Mainfont',
      primarySwatch: Colors.blue,
    ),
    home: Login(),
  ));
}