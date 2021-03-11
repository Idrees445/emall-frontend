import 'package:emall/main.dart';
import 'package:translator/translator.dart';

Future<String> Translate(String input) async {

  if(languageEnglish) return input;

  final translator = GoogleTranslator();
  String Result = input;
  await translator
      .translate(input, to: 'ar')
      .then((result) {Result = result.toString();});
  return Result;
}