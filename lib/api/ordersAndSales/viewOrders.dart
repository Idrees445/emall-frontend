import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../main.dart';
import '../secrets/Secrets.dart';

Future<Map> AllOrders() async {

  var response = await http.get(
    ViewOrdersUrl,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "auth-token": Vender.Token,
      "Access-Control-Allow-Origin": "*",
    },
  );

  Map<dynamic, dynamic> res = await jsonDecode(response.body.toString());
  return res;

}