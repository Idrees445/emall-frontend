import 'package:emall/Dashboard/screens/products.dart';
import 'package:emall/main.dart';
import 'package:emall/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hexcolor/hexcolor.dart';

class FullProduct extends StatefulWidget {
  @override
  _FullProductState createState() => _FullProductState();
}

class _FullProductState extends State<FullProduct> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 2.0;
    return SafeArea(
        child: Scaffold(
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: (MediaQuery.of(context).size.width < 500)?350:450,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0.0,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              color: Colors.blue[800],
                            ),
                          ),
                          Center(
                            child: Container(
                              width: (2*MediaQuery.of(context).size.width/3 < 400)?2*MediaQuery.of(context).size.width/3:400,
                              height: (2*MediaQuery.of(context).size.width/3 < 400)?2*MediaQuery.of(context).size.width/3:400,
                              child: Hero(
                                  tag: ToFullImageTag,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(image: ProductImages[ToFullImageIndex],fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            top: 20,
                            left: 20,
                            child: GestureDetector(
                              onTap: (){
                                router.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(Icons.arrow_back,color: Colors.white,),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Text(AllProductList[ToFullImageIndex].productname,style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),),
                          VSpace(5.0),
                          Text(AllProductList[ToFullImageIndex].price,style: TextStyle(
                            fontSize: 35,
                          ),),
                          VSpace(10.0),
                          Text(AllProductList[ToFullImageIndex].Description,style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),),
                          VSpace(10.0),
                          specification("Product Id", AllProductList[ToFullImageIndex].Id),
                          specification("Category", AllProductList[ToFullImageIndex].category),
                          specification("SubCategory", AllProductList[ToFullImageIndex].subcategory),
                          VSpace(10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for(int i=-1;i<AllProductList[ToFullImageIndex].color.length;i++) (i==-1)?
                                  Column(
                                   children: [
                                     Container(
                                       height: 40,
                                       child: Center(child: Text("Available Colors: ")),
                                     ),
                                     Text("Size: "),
                                     Text("Quantity: "),
                                   ],
                                  )
                                  :Column(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration : AddProductDecoration(HexColor(AllProductList[ToFullImageIndex].color[i]), 500),
                                  ),
                                  Text(AllProductList[ToFullImageIndex].size[i]),
                                  Text(AllProductList[ToFullImageIndex].Quantity[i]),
                                ],
                              ),
                            ],
                          ),
                          VSpace(20.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ),
        )
    );
  }

  Widget specification(String text1,String text2){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text1 + " : " + text2),
      ],
    );
  }

}
