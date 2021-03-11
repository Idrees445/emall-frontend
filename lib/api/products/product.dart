import 'dart:convert';
import 'package:emall/api/secrets/Secrets.dart';
import 'package:emall/models/newProduct.dart';
import 'package:emall/widgets/toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';

Future<Map> UploadNewProduct(BuildContext context,String text, PlatformFile file) async {

  final request = http.MultipartRequest(
    "POST",
    Uri.parse(ProductUrl),
  );
  Map<String,String> headers={
    "Content-type": "multipart/form-data",
    "auth-token": Vender.Token,
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*",
  };
  request.headers.addAll(headers);
  request.files.add(new http.MultipartFile(
    text, file.readStream, file.size,
    filename: file.name,
  ));
  request.fields.addAll({
    "Productname": newProduct.productname,
        "Price": newProduct.price,
        "Description": newProduct.Description,
        "Category": newProduct.category,
        "Subcategory": newProduct.subcategory,
        "Color": newProduct.color.toString(),
        "Quantity": newProduct.Quantity.toString(),
        "Size": newProduct.size.toString(),
  });
  var resp = await request.send();
  var responses = await http.Response.fromStream(resp);
  var res = await json.decode(responses.body);
  if(res["error"] == null){}
  else ShowToast("Error, Try Again", context);
}

Future<Map> AllProducts() async {

  var response = await http.get(
    AllProductUrl,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "auth-token": Vender.Token,
      "Access-Control-Allow-Origin": "*",
    },
  );

  Map<dynamic, dynamic> res = await jsonDecode(response.body.toString());

  if(res["error"] == null) {
    for (int i = 0; i < res["count"]; i++) {
      NewProduct tempProduct = NewProduct();
      tempProduct.createProduct(
          res["data"][i]["productname"],
          res["data"][i]["price"],
          res["data"][i]["Description"],
          List.from(res["data"][i]["ProductPic"]["data"]["data"]),
          res["data"][i]["Category"],
          res["data"][i]["Subcategory"],
          res["data"][i]["color"].toString(),
          res["data"][i]["size"].toString(),
          res["data"][i]["_id"],
          res["data"][i]["quantity"].toString()
      );
      AllProductList.insert(i, tempProduct);
    }
    number_of_products = res["count"];
  }

  return res;

}

Future<Map> AllCategories() async {
  var response = await http.get(
    CategoryUrl,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
    },
  );

  Map<dynamic, dynamic> res = await jsonDecode(response.body.toString());

  if(res["error"] == null){
    for(int i=0;i<res["data"].length;i++){
      AllCategoryList.add(res["data"][i]["Category"]);
    }
  }

  return res;
}

Future<Map> AllSubCategories() async {
  var response = await http.get(
    SubCategoryUrl,
    headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json",
      "Access-Control-Allow-Origin": "*",
    },
  );

  Map<dynamic, dynamic> res = await jsonDecode(response.body.toString());

  if(res["error"] == null){
    for(int i=0;i<res["data"].length;i++){
      AllSubCategoryList.add(res["data"][i]["Subcategory"]);
    }
  }

  return res;
}