import 'dart:convert';
import 'package:emall/api/secrets/Secrets.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';

Future<bool> DeleteProduct(String id) async {

  var response = await http.post(
    DeleteProductUrl,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "auth-token": Vender.Token,
      "Access-Control-Allow-Origin": "*",
    },
    body: jsonEncode(<String, dynamic>{"id": id,}),
  );

  Map<dynamic, dynamic> res = jsonDecode(response.body.toString());

  if(res["error"] == null) return true;
  return false;

}