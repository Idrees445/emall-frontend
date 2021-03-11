import 'package:clipboard/clipboard.dart';
import 'package:emall/Dashboard/dashboard.dart';
import 'package:emall/Dashboard/screens/products.dart';
import 'package:emall/Translate/Tmain.dart';
import 'package:emall/api/ordersAndSales/viewOrders.dart';
import 'package:emall/main.dart';
import 'package:emall/widgets/loading.dart';
import 'package:emall/widgets/toast.dart';
import 'package:emall/widgets/widgets.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:json_table/json_table.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {

  var json;
  String stringjson;
  bool loading = true;
  int countNum = 0;
  String Number = "Sr No";
  String Copy = "Copy";
  String ImageText = "Image";
  String OrderId = "Order ID";
  String ProductId = "Product ID";
  String Quantity = "Quantity";
  String Date = "Date And Time";
  String OrderCompleted = "OrderCompleted";
  String Copied = "Copied To Clipboard";
  String SizeString = "Size";
  String ColorString = "Color";

  Future<void> TranslatePage() async {
    Translate("Sr No").then((value) => Number = value);
    Translate("Size").then((value) => SizeString = value);
    Translate("Copy").then((value) => Copy = value);
    Translate("Color").then((value) => ColorString = value);
    await Translate("Image").then((value) => ImageText = value);
    Translate("Order ID").then((value) => OrderId = value);
    Translate("Product ID").then((value) => ProductId = value);
    await Translate("Quantity").then((value) => Quantity = value);
    Translate("Date").then((value) => Date = value);
    Translate("Copied To Clipboard").then((value) => Copied = value);
    await Translate("Order Completed").then((value) => OrderCompleted = value);
  }

  var columns;
  List randomNumberList;
  int randomnumberindex  = -1;

  String FindMyImage(String id){
    for(int i=0;i<number_of_products;i++){
      if(AllProductList[i].Id == id){
        randomnumberindex++;
        return randomNumberList[randomnumberindex].toString() + "%#&" + i.toString();
      }
    }
  }

  @override
  void initState() {

    AllOrders().then((res) async {
      await TranslatePage().then((value){setState(() {
        columns = [
          JsonTableColumn("Sr No",label: Number),
          JsonTableColumn("Copy",label: Copy),
          JsonTableColumn("Image",label: ImageText),
          JsonTableColumn("size",label: SizeString),
          JsonTableColumn("color",label: ColorString),
          JsonTableColumn("_id",label: OrderId),
          JsonTableColumn("Product_id",label: ProductId),
          JsonTableColumn("Quantity",label: Quantity),
          JsonTableColumn("Date",label: Date),
        ];
        loading = false;
      });});
      setState((){
        json = res["data"];
        countNum = res["data"].length;
        print(countNum);
        randomNumberList = List.generate(res["data"].length, (i) => i);
        for(int i=0;i<res["data"].length;i++){
          json[i]["Sr No"] = (i+1).toString();
          json[i]["Copy"] = (i+1).toString() + "<-!@#%";
          json[i]["Image"] = FindMyImage(res["data"][i]["Product_id"]);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dwidth,
      height: Dheight,
      padding: EdgeInsets.all(20.0),
      child: (loading)?Loading(loading):
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            (countNum < 1)?Center(
              child: Container(
                child: Image.asset("assets/images/ordersandsales/nothing_found.jpg"),
              ),
            ):Container(
              height: Dheight,
              child: JsonTable(
                  json,
                tableHeaderBuilder: (String header) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(border: Border.all(width: 0.5),color: Colors.blue[800]),
                    child: Text(
                      header,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0,color: Colors.white),
                    ),
                  );
                },
                tableCellBuilder: (value) {
                  return (value.contains(new RegExp(r'<-!@#%', caseSensitive: false)) || value.contains(new RegExp(r'%#&', caseSensitive: false)))?
                  Container(
                    height: 60.0,
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    decoration: BoxDecoration(border: Border.all(width: 0.5, color: Colors.grey.withOpacity(0.5))),
                    child: (value.contains(new RegExp(r'<-!@#%', caseSensitive: false)))?GestureDetector(
                      onTap: (){
                        int index = int.parse(value.split('<')[0]) - 1;
                        print(index);

                        FlutterClipboard.copy(
                          "Order ID: " + json[index]["_id"] + "\n" +
                            "Product ID: " + json[index]["Product_id"] + "\n" +
                            "Quantity: " + json[index]["Quantity"] + "\n" +
                              "Color: " + json[index]["color"] + "\n" +
                              "size: " + json[index]["size"] + "\n" +
                              "Date: " + json[index]["Date"]
                        ).then(( value ){
                          ShowToast(Copied, context);
                        });
                      },
                      child: Icon(Icons.copy),
                    ):GestureDetector(
                        onTap: (){
                          setState(() {
                            ToFullImageTag = value;
                            ToFullImageIndex = int.parse(value.split('&')[1]);
                          });
                          router.navigateTo(context, "/vender/dashboard/fullproduct", transition: TransitionType.fadeIn);
                        },
                      child: Hero(
                        tag: value,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(image: ProductImages[int.parse(value.split('&')[1])],fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      ),
                  ) :Container(
                    height: 60.0,
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    decoration: BoxDecoration(border: Border.all(width: 0.5, color: Colors.grey.withOpacity(0.5))),
                    child: (value.length > 0 && value[0] == "#")?
                    Center(
                      child: Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.only(right: 10),
                        decoration : AddProductDecoration(HexColor(value), 500),
                      ),
                    )
                        :Text(
                      value,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey[900],
                      ),
                    ),
                  );
                },
                columns: columns,
                paginationRowCount: 7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
