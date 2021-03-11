import 'package:emall/Translate/Tmain.dart';
import 'package:emall/api/Auth/auth.dart';
import 'package:emall/main.dart';
import 'package:emall/widgets/loading.dart';
import 'package:emall/widgets/toast.dart';
import 'package:emall/widgets/widgets.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  Auth auth = Auth();
  FocusNode textSecondFocusNode = new FocusNode();
  String Email = "Email";
  String Password = "Password";
  String Login = "Login";
  String NoAccount = "Create Account?";
  String language = "English";
  bool loading = true;
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  Icon PasswordIcon = Icon(Icons.lock_outline);
  bool passwordobscure = true;

  String ValidEmail = "Enter a valid Email";
  String ErrorLogin = "Error In Login Try Again";

  Future<void> Translatepage() async {
    Translate("Email").then((value) {setState(() {Email = value;});});
    Translate("Error In Login Try Again").then((value) {setState(() {ErrorLogin = value;});});
    Translate("Enter a valid Email").then((value) {setState(() {ValidEmail = value;});});
    Translate("Password").then((value) {setState(() {Password = value;});});
    Translate("Login").then((value) {setState(() {Login = value;});});
    await Translate("Create Account?").then((value) {setState(() {NoAccount = value;});});
    if(languageEnglish) language = "English";
    else language = "عربى";
  }

  @override
  void dispose() {
    EmailController.dispose();
    PasswordController.dispose();
    super.dispose();
  }

  @override
  initState(){
    Translatepage().then((value) {
      setState(() {
        loading = false;
      });
    });
    super.initState();
  }

  Widget InputText(String text, TextEditingController Controller,var keyboardtype,bool obscure,var icon){
    return Column(
      children: [
        Row(
          mainAxisAlignment: (languageEnglish)?MainAxisAlignment.start:MainAxisAlignment.end,
          children: [
            Text(text,style: mystyle(15.0, FontWeight.w500,Colors.blue[800]),),
            HSpace(20.0),
          ],
        ),
        Container(
          padding: EdgeInsets.only(left: 20.0,right: 20.0),
          margin: EdgeInsets.symmetric(vertical: 8.0,horizontal: 5.0),
          decoration: curveDecoration(20.0, Colors.white,800),
          child: TextField(
            controller: Controller,
            textDirection: (languageEnglish)?TextDirection.ltr:TextDirection.rtl,
            style: TextStyle(fontSize: 20),
            decoration: new InputDecoration(
              suffixIcon: InkWell(
                onTap: (){
                  FocusScope.of(context).requestFocus(new FocusNode());
                  if(text == Password){
                    setState(() {
                      if(passwordobscure) PasswordIcon = Icon(Icons.lock_open);
                      else PasswordIcon = Icon(Icons.lock_outline);
                      passwordobscure = !passwordobscure;
                    });
                  }
                },
                child: icon,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
            ),
            keyboardType: keyboardtype,
            obscureText: obscure,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background/background.png"),
            fit: BoxFit.fill,
          ),
          color: Colors.blue[300],
        ),
        child: Stack(
          children: [

            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),
                margin: EdgeInsets.all(20.0),
                width: (MediaQuery.of(context).size.width > 400)?400:MediaQuery.of(context).size.width,
                decoration: curveDecoration(20.0, Colors.grey[100],800),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Text(Login,style: mystyle(25.0, FontWeight.w500,Colors.black),)),
                        VSpace(10.0),
                        InputText(Email, EmailController,TextInputType.emailAddress,false,Icon(Icons.email)),
                        InputText(Password, PasswordController,TextInputType.text,passwordobscure,PasswordIcon),
                        VSpace(10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){
                                router.pop(context);
                                router.navigateTo(context, "/auth/register", transition: TransitionType.fadeIn);
                              },
                                child: Text(NoAccount,style: mystyle(15.0, FontWeight.w500,Colors.blue[800]),),
                            ),
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  Vender.Email = EmailController.text;
                                  Vender.Password = PasswordController.text;
                                  loading = true;
                                });
                                if(ValidationText())
                                auth.Authlogin().then((value) => {
                                  if(value){
                                    setState((){
                                      loading = false;
                                    }),
                                    router.pop(context),
                                    router.navigateTo(context, "/vender/dashboard", transition: TransitionType.fadeIn),
                                  }
                                  else{
                                    setState((){
                                      loading  = false;
                                    }),
                                    ShowToast(ErrorLogin, context),
                                  }
                                  });
                                else{
                                  setState(() {loading = false;});
                                  ShowToast(ValidEmail, context);}
                                },
                              child: Container(
                                margin: EdgeInsets.only(left: 60),
                                padding: EdgeInsets.all(10.0),
                                decoration: curveDecoration(10.0, Colors.blue,400),
                                child: Text(Login,style: mystyle(15.0, FontWeight.w400,Colors.white),),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 0.0,
              left: 10.0,
              child:  Row(
                children: [
                  Text(language + "  "),
                  Checkbox(
                  checkColor: Colors.white,
                  activeColor: Colors.blue,
                  value: languageEnglish,
                  onChanged: (bool value) {
                    setState(() {
                      loading = true;
                      languageEnglish = value;
                      Translatepage().then((value) {
                        setState(() {
                          loading = false;
                        });
                      });
                    });
                  },
                  ),
                ],
              ),),
            Loading(loading),
          ],
        ),
      ),
    );
  }

  bool ValidationText(){return EmailController.text.isValidEmail();}

}
