import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../main.dart';
import '../secrets/Secrets.dart';

Future<Map> AllSales() async {

  var response = await http.get(
    ViewSalesUrl,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "auth-token": Vender.Token,
      "Access-Control-Allow-Origin": "*",
    },
  );

  Map<dynamic, dynamic> res = await jsonDecode(response.body.toString());
  // print("in viewsales");
  // print(res["data"]);
  return res;

}