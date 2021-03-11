import 'package:clipboard/clipboard.dart';
import 'package:emall/Translate/Tmain.dart';
import 'package:emall/api/ordersAndSales/viewsales.dart';
import 'package:emall/widgets/loading.dart';
import 'package:emall/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:json_table/json_table.dart';
import '../dashboard.dart';

class SalesScreen extends StatefulWidget {
  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {

  var json;
  String stringjson;
  bool loading = true;
  int countNum = 0;

  String Number = "Number";
  String Copy = "Copy";
  String OrderId = "Order ID";
  String ProductId = "Product ID";
  String Quantity = "Quantity";
  String Date = "Date And Time";
  String OrderCompleted = "OrderCompleted";
  String Sale = "Sale";
  String PaymentCompleted = "Payment Completed";
  String Copied = "Copied To Clipboard";

  Future<void> TranslatePage() async {
    Translate("Number").then((value) => Number = value);
    await Translate("Copy").then((value) => Copy = value);
    Translate("Order ID").then((value) => OrderId = value);
    Translate("Product ID").then((value) => ProductId = value);
    await Translate("Quantity").then((value) => Quantity = value);
    Translate("Date").then((value) => Date = value);
    Translate("Sale").then((value) => Sale = value);
    await Translate("Copied To Clipboard").then((value) => Copied = value);
    Translate("Payment Completed").then((value) => PaymentCompleted = value);
    await Translate("Order Completed").then((value) => OrderCompleted = value);
  }

  var columns;

  @override
  void initState() {

    columns = [
      JsonTableColumn("Sr No",label: Number),
      JsonTableColumn("Copy",label: Copy),
      JsonTableColumn("_id",label: OrderId),
      JsonTableColumn("Product_id",label: ProductId),
      JsonTableColumn("Total_amount",label: Sale + "﷼"),
      JsonTableColumn("Quantity",label: Quantity),
      JsonTableColumn("Date",label: Date),
      JsonTableColumn("User_payment",label: OrderCompleted),
      JsonTableColumn("vender_payment",label: PaymentCompleted),
    ];

    AllSales().then((res){
      setState((){
        loading = false;
        json = res["data"];
        countNum = res["data"].length;
        for(int i=0;i<res["data"].length;i++){
          json[i]["Sr No"] = (i+1).toString();
          json[i]["Copy"] = (i+1).toString() + "<-!@#%";
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
                  return (value.contains(new RegExp(r'<-!@#%', caseSensitive: false)))?
                  Container(
                    height: 60.0,
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    decoration: BoxDecoration(border: Border.all(width: 0.5, color: Colors.grey.withOpacity(0.5))),
                    child: GestureDetector(
                      onTap: (){
                        int index = int.parse(value.split('<')[0]) - 1;
                        print(index);

                        FlutterClipboard.copy(
                            "Order ID: " + json[index]["_id"] + "\n" +
                                "Product ID: " + json[index]["Product_id"] + "\n" +
                                "Quantity: " + json[index]["Quantity"] + "\n" +
                                "Date: " + json[index]["Date"] + "\n" +
                                "Total amount: " + json[index]["Total_amount"].toString() + "\n" +
                                "Order Completed: " + json[index]["User_payment"].toString() + "\n" +
                                "Payment Done: " + json[index]["vender_payment"].toString()
                        ).then(( value ){
                          ShowToast(Copied, context);
                        });
                      },
                      child: Icon(Icons.copy),
                    )
                  ) :Container(
                    height: 60.0,
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    decoration: BoxDecoration(border: Border.all(width: 0.5, color: Colors.grey.withOpacity(0.5))),
                    child: (!(value is bool) && (value == "true" || value == "false"))?
                        Icon((value == "true")?Icons.check:Icons.clear, color: (value == "true")?Colors.green:Colors.red,)
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
