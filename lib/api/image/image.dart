import 'dart:convert';
import 'package:emall/widgets/toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';

Future<List<int>> uploadImageFile(PlatformFile file,String url,String text,BuildContext context, String what) async {

  final request = http.MultipartRequest(
    "POST",
    Uri.parse(url),
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
  var resp = await request.send();
  var responses = await http.Response.fromStream(resp);
  var res = await json.decode(responses.body);
  if(res["error"] == null){
    return List.from(res["data"]["data"]);
  }
  else ShowToast("Error, Try Again", context);
}