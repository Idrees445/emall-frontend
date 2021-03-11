import 'dart:async';
import 'dart:typed_data';
import 'package:emall/Dashboard/dashboard.dart';
import 'package:emall/api/products/deleteproduct.dart';
import 'package:emall/api/products/product.dart';
import 'package:emall/widgets/loading.dart';
import 'package:emall/widgets/widgets.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../main.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

List<MemoryImage> ProductImages = [];

class _ProductScreenState extends State<ProductScreen> {

  double width, height;
  double pwidth = 150,pheight = 150;
  double opacity = 1;
  Timer time;
  String Confirm = "Confirm";
  bool loading = false;

  @override
  void initState() {
    Confirm = "Confirm";
    AllProducts().then((res){setState(() {
      ProductImages.clear();
      for(int i=0;i<number_of_products;i++){
        ProductImages.add(MemoryImage(Uint8List.fromList(AllProductList[i].ProductPic)));
      }
    });});

    time = new Timer.periodic(Duration(milliseconds: 800), (Timer t) {
      setState(() {
        if(opacity == 0.6) opacity = 1;
        else opacity = 0.6;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    time.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
    return Container(
      height: Dheight - 20,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
            width: Dwidth,
            height: Dheight,
            child: (loading)?Loading(loading):SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Wrap(
                      spacing: 20.0,
                      runSpacing: 20.0,
                      children: [
                        GestureDetector(

                          onTap: (){
                            router.navigateTo(context, "/vender/dashboard/addproduct", transition: TransitionType.fadeIn);
                          },

                          child: Container(
                            width: (MediaQuery.of(context).size.width > 460)?250:(MediaQuery.of(context).size.width - 60)/2,
                            height: (MediaQuery.of(context).size.width > 460)?200:150,
                            decoration: boxdecoration(Colors.grey[300], 500, 10.0, 20.0, Offset(10, 10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_circle_outline,size: 50.0,),
                                Text(AddProduct),
                              ],
                            ),
                          ),
                        ),
                        for(int i=0;i<number_of_products;i++)
                          Column(
                            children: [
                              Container(
                                width: (MediaQuery.of(context).size.width > 460)?250:(MediaQuery.of(context).size.width - 60)/2,
                                height: (MediaQuery.of(context).size.width > 460)?200:150,
                                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                child: (AllProductList.asMap().containsKey(i))?
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          ToFullImageTag = "FullProduct" + i.toString();
                                          ToFullImageIndex = i;
                                        });
                                        router.navigateTo(context, "/vender/dashboard/fullproduct", transition: TransitionType.fadeIn);
                                      },
                                      child: Hero(
                                          tag: "FullProduct" + i.toString(),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              image: DecorationImage(image: ProductImages[i],fit: BoxFit.fill),
                                            ),
                                          ),
                                      ),
                                    )
                                :AnimatedOpacity(
                                    opacity: opacity,
                                    duration: const Duration(milliseconds: 800),
                                    child: Image.asset("assets/images/product/noimage.png")),
                              ),
                              Container(
                                width: (MediaQuery.of(context).size.width > 460)?250:(MediaQuery.of(context).size.width - 60)/2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 10.0),
                                            child: (AllProductList.asMap().containsKey(i))?
                                            Center(child: Text(AllProductList[i].productname,style: mytextstyle(20.0, FontWeight.w200, Colors.black),)):
                                            Center(child: Text(Name,style: mytextstyle(20.0, FontWeight.w200, Colors.black))),
                                        ),
                                        Container(
                                            child: Center(child: (AllProductList.asMap().containsKey(i))?
                                            Text(AllProductList[i].price + " ﷼",style: mytextstyle(20.0, FontWeight.w200, Colors.black))
                                                :Text(Price + "﷼ ",style: mytextstyle(20.0, FontWeight.w200, Colors.black))
                                            )
                                        ),
                                      ],
                                    ),

                                    InkWell(
                                      onTap: (){
                                        if(AllProductList.asMap().containsKey(i)){
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) => AlertDialog(
                                              title: Text("Deleting Product"),
                                              content: Text("Do you really want to delete the Product?"),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text("Cancel",style: TextStyle(color: Colors.white)),
                                                  onPressed: () => Navigator.pop(context),
                                                  color: Colors.blue[800],
                                                ),
                                                HSpace(20),
                                                FlatButton(
                                                  child: Text(Confirm,style: TextStyle(color: Colors.white),),
                                                  onPressed: () {
                                                    setState(() {loading = true;});
                                                    Navigator.pop(context);
                                                    DeleteProduct(AllProductList[i].Id).then((value) async {
                                                      AllProductList.clear();
                                                      ProductImages.clear();
                                                      number_of_products = 11;
                                                      setState(() {loading = false;});
                                                      AllProducts().then((res){setState(() {
                                                        ProductImages.clear();
                                                        for(int i=0;i<number_of_products;i++){
                                                          ProductImages.add(MemoryImage(Uint8List.fromList(AllProductList[i].ProductPic)));
                                                        }
                                                      });});
                                                    });
                                                    },
                                                  color: Colors.red,
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                      child: Icon(Icons.delete),
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
