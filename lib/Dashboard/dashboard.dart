import 'dart:typed_data';
import 'package:emall/Dashboard/screens/aboutus.dart';
import 'package:emall/Dashboard/screens/empty/empty.dart';
import 'package:emall/Dashboard/screens/orders.dart';
import 'package:emall/Dashboard/screens/products.dart';
import 'package:emall/Dashboard/screens/sales.dart';
import 'package:emall/Dashboard/screens/settings.dart';
import 'package:emall/Translate/Tmain.dart';
import 'package:emall/models/newProduct.dart';
import 'package:emall/models/vender.dart';
import 'package:emall/widgets/loading.dart';
import 'package:emall/widgets/toast.dart';
import 'package:emall/widgets/widgets.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

double Dwidth;
double Dheight;
bool kIsWeb = true;
String AddProduct = "Add Product";
String Name = "Name";
String Price = "Price";
bool mainloading = true;

class _DashboardState extends State<Dashboard> {

  bool loading = true;
  bool show = false;
  String hover = "";
  var color = Colors.blue[800];
  String Dashboard = "Dashboard";
  String Settings = "Settings";
  String whattoopen;
  String Logout = "Logout";
  String Sales = "Sales";
  String Products = "Product";
  String Orders = "Orders";
  String AboutUs = "Support";
  String empty = "empty";
  String language = "English";
  String Ok = "Ok";
  String VerCompleted = "Verification Completed.";
  String VerProcessing = "Verification in Process.";
  String CompletedText = "You are all set.";
  String ProcessingText = "Your Products can not be shown to the users till Verification is Completed. "
      "Make Sure you have Uploaded the correct Vat and CR in Settings. "
      "If you think this is an error then contact us at email@email.com";
  MemoryImage ProfilePictureInbytes;

  @override
  void initState() {
    ProfilePictureInbytes  = MemoryImage(Uint8List.fromList(Vender.ProfilePic));
    whattoopen = Products;
    TranslatePage().then((value){
      setState(() {
        mainloading = false;
        loading = false;
        whattoopen = Products;
      });
    });
    super.initState();
  }

  Widget Heading(){

    if(MediaQuery.of(context).size.width < 400)setState(() {
      kIsWeb = false;
    });

    if(kIsWeb) setState(() {
      show = true;
    });

    setState(() {
      Dwidth = (kIsWeb)?MediaQuery.of(context).size.width - 200:MediaQuery.of(context).size.width;
      Dheight = MediaQuery.of(context).size.height - 50;
    });

    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      decoration: curveHeadDecoration(Colors.blue[800], 800, 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          (!kIsWeb)?IconButton(icon: Icon(Icons.menu), onPressed: (){
            setState(() {
              show = !show;
            });
          }):HSpace(0.0),

          SelectableText(Dashboard + " - " + whattoopen,style: mystyle(20.0, FontWeight.w500, Colors.white),),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: (){
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Vender.Validation?Text(VerCompleted):Text(VerProcessing),
                      content: Vender.Validation?Text(CompletedText):Container(
                          width: 250,
                          child: SelectableText(ProcessingText)),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(Ok),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  );
                },
                child: Icon(Vender.Validation?Icons.check:Icons.error,color: Vender.Validation?Colors.green:Colors.red,),
              ),
              HSpace(5.0),
              InkWell(
                  child: Icon(Icons.settings),
                  onTap: (){
                setState(() {
                  whattoopen = Settings;
                });
              }),
              HSpace(10.0),
            ],
          ),

        ],
      ),
    );
  }

  Widget DrawerTile(String text){

    void _updateLocation(PointerEvent details) {
      setState(() {
        hover = text;
        color = Colors.blue[800];
      });
    }

    void _updateLocationexit(PointerEvent details) {
      setState(() {
        hover = "";
        color = Colors.blue[800];
      });
    }

    return MouseRegion(

      onHover: _updateLocation,
      onExit: _updateLocationexit,

      child: InkWell(
        onTap: (){

          setState(() {
            show = !show;
            whattoopen = text;
          });

          if(text == Logout){
             Vender = vender();
             newProduct = NewProduct();
             AllProductList.clear();
             number_of_products = 11;
            router.pop(context);
            router.navigateTo(context, "/auth/login");
          }

        },

        child: Container(
          color: (hover == text)?color:Colors.transparent,
          child: Column(
            children: [
              VSpace(10.0),
              Text(text,style: mystyle(20.0, FontWeight.w400, Colors.white),),
              VSpace(10.0),
              divider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget Drawer(){
    return (show || kIsWeb)?Positioned(
        top: 50,
        left: 0,
        child: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(bottom: 50.0),
              width: 200,
              color: Color.fromRGBO(64, 64, 64, 1),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VSpace(30.0),
                    Center(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(image: ProfilePictureInbytes,fit: BoxFit.fill),
                            ),
                            height: 80,
                            width: 80,
                          ),
                          VSpace(10.0),
                          Text(Vender.Name, maxLines: 1,style: TextStyle(
                            color: Colors.white,
                          ),),
                          VSpace(10.0),
                          divider(),
                        ],
                      ),
                    ),

                    DrawerTile(Products),
                    DrawerTile(Orders),
                    DrawerTile(Sales),
                    DrawerTile(Settings),
                    DrawerTile(AboutUs),
                    DrawerTile(Logout),

                    VSpace(10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(language + "  ",style: TextStyle(color: Colors.white),),
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.blue[800],
                          value: languageEnglish,
                          onChanged: (bool value) {
                            setState(() {
                              languageEnglish = value;
                              router.pop(context);
                              router.navigateTo(context, "/vender/dashboard", transition: TransitionType.fadeIn);
                            });
                          },
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
            (!kIsWeb)?GestureDetector(
              onTap: (){
                setState(() {
                  show = !show;
                });
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black26,
              ),
            ):VSpace(0.0),
          ],
        )
    ):VSpace(0.0);
  }

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: (mainloading)?Empty():Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                  left: 0,
                  child: Heading()
              ),
              Positioned(
                  left: (kIsWeb)?200:0,
                  top: 50.0,
                  child: Openme(),
              ),
              Drawer(),
              Loading(loading),
            ],
          ),
        ),
      ),
    );
  }

  Widget Openme(){

    if(whattoopen == Settings) return SettingScreen();
    else if(whattoopen == Products) return ProductScreen();
    else if(whattoopen == Orders) return OrdersScreen();
    else if(whattoopen == Sales) return SalesScreen();
    else return AboutUsScreen();

  }
  
  Future<void> TranslatePage() async {

    Translate("Dashboard").then((value) => Dashboard = value);
    Translate("Verification Completed.").then((value) => VerCompleted = value);
    await Translate("Verification in Process.").then((value) => VerProcessing = value);
    Translate("You are all set.").then((value) => CompletedText = value);
    Translate("Settings").then((value) => Settings = value);
    Translate("Ok").then((value) => Ok = value);
    await Translate("Add Product").then((value) => AddProduct = value);
    Translate("Name").then((value) => Name = value);
    Translate("Price").then((value) => Price = value);
    if(languageEnglish) ProcessingText = "Your Products can not be shown to the users till Verification is Completed."
        "Make Sure you have Uploaded the correct Vat and CR in Settings. "
        "If you think this is an error then contact us at email@email.com";
    else ProcessingText = "";
    await Translate("Logout").then((value) => Logout = value);
    await Translate("Sales").then((value) => Sales = value);
    await Translate("Products").then((value) => Products = value);
    if(languageEnglish) Orders = "Orders";
    else Orders = "طلب";
    if(languageEnglish) language = "English";
    else language = "عربى";
    await Translate("Support").then((value) => AboutUs = value);
  }
  
}
