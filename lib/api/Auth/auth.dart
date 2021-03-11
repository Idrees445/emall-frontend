import 'dart:convert';
import 'package:emall/api/secrets/Secrets.dart';
import 'package:emall/main.dart';
import 'package:http/http.dart' as http;

class Auth{

  Future<bool> AuthRegister() async {
    var response = await http.post(
      RegisterUrl,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
      body: jsonEncode(<String, dynamic>{
        "name": Vender.Name,
        "email": Vender.Email,
        "password": Vender.Password,
        "Mobile": Vender.Mobile,
        "shopname": Vender.Shopname,
        "address": Vender.Address,
        "city": Vender.City,
        "postalcode": Vender.PostalCode,
        "state": Vender.State,
        "country": Vender.Country,
        "Bankholdername": Vender.BankHoldername,
        "Accountnumber": Vender.AccountNumber,
        "IBan": Vender.IBan,
        "Bankname": Vender.BankName
      }),
    );

    Map<dynamic, dynamic> res = await jsonDecode(response.body.toString());
    if(res["error"] == null) return true;

    return false;

  }

  Future<bool> Authlogin() async {

    var response = await http.post(
      LoginUrl,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
        "Access-Control-Allow-Origin": "*",
      },
      body: jsonEncode(<String, dynamic>{
        "email": Vender.Email.trim(),
        "password": Vender.Password.trim()
      }),
    );

    Map<dynamic, dynamic> res = jsonDecode(response.body.toString());
    if(res["error"] == null) {
      Vender.Validation = res["info"]["validation"];
      Vender.Token = res["token"];
      Vender.step1Completed(
          res["info"]["name"],
          res["info"]["email"],
          res["info"]["password"],
          res["info"]["Mobile"]);
      Vender.step2Completed(
          res["info"]["Shop_Details"]["shopname"],
          res["info"]["Shop_Details"]["address"],
          res["info"]["Shop_Details"]["city"],
          res["info"]["Shop_Details"]["postalcode"],
          res["info"]["Shop_Details"]["state"],
          res["info"]["Shop_Details"]["country"]);
      Vender.step3Completed(
          res["info"]["Bank_Details"]["Bankholdername"],
          res["info"]["Bank_Details"]["Accountnumber"],
          res["info"]["Bank_Details"]["IBan"],
          res["info"]["Bank_Details"]["Bankname"]);

      Vender.ProfilePic.addAll(List.from(res["info"]["image"]["data"]["data"]));
      Vender.VAT.addAll(List.from(res["info"]["Shop_Details"]["VAT"]["data"]["data"]));
      Vender.CR.addAll(List.from(res["info"]["Shop_Details"]["CR"]["data"]["data"]));

      return true;

    }
    return false;
  }

}