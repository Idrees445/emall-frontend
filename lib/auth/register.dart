import 'package:emall/Translate/Tmain.dart';
import 'package:emall/api/Auth/auth.dart';
import 'package:emall/main.dart';
import 'package:emall/widgets/loading.dart';
import 'package:emall/widgets/toast.dart';
import 'package:emall/widgets/widgets.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  Auth auth = Auth();
  FocusNode textSecondFocusNode = new FocusNode();
  String Register = "Register";
  String PersonalDetails = "Enter Your Persnal Info";
  String Email = "Email";
  TextEditingController EmailController = TextEditingController();
  String Mobile = "Mobile Number";
  TextEditingController MobileNumberController = TextEditingController();
  String Name = "Name";
  TextEditingController NameController = TextEditingController();
  String Password = "Password";
  TextEditingController PasswordController = TextEditingController();
  String shopDetails = "Enter Your Shopping Details";
  String Address = "Address";
  TextEditingController AddressController = TextEditingController();
  String ShopName = "Shop Name";
  TextEditingController ShopNameController = TextEditingController();
  String City = "City";
  TextEditingController CityController = TextEditingController();
  String State = "State";
  TextEditingController StateController = TextEditingController();
  String Country = "Country";
  TextEditingController CountryController = TextEditingController();
  String PostalCode = "Postal Code";
  TextEditingController PostalCodeController = TextEditingController();
  String BankDetails = "Enter Your Bank Details";
  String BankHolderName = "Bank Holder Name";
  TextEditingController BankHolderNameController = TextEditingController();
  String IBan = "IBan code";
  TextEditingController IBanController = TextEditingController();
  String AccountNumber = "Account Number";
  TextEditingController AccountNumberController = TextEditingController();
  String BankName = "Bank Name";
  TextEditingController BankNameController = TextEditingController();
  String Next = "Next";
  String language = "English";
  String Login = "Login";
  bool loading = true;
  int Current_step = 1;
  bool passwordobscure = true;
  Icon PasswordIcon = Icon(Icons.lock_outline);

  String ErrorProceeding = "Error To proceed Further";
  String FailedRegister = "Registration Failed Try Again";

  @override
  void dispose() {
    NameController.dispose();
    MobileNumberController.dispose();
    EmailController.dispose();
    PasswordController.dispose();
    ShopNameController.dispose();
    AddressController.dispose();
    CityController.dispose();
    PostalCodeController.dispose();
    StateController.dispose();
    CountryController.dispose();
    BankHolderNameController.dispose();
    AccountNumberController.dispose();
    IBanController.dispose();
    BankNameController.dispose();
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

  Widget InputText(String text, TextEditingController Controller,var icon,bool obscure,var keyboardtype,var input){
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
            obscureText: obscure,
            style: TextStyle(fontSize: 20),
            keyboardType: keyboardtype,
            inputFormatters: [input],
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
          ),
        ),
      ],
    );
  }

  Widget NextStep(){

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: (){
            router.pop(context);
            router.navigateTo(context, "/auth/login", transition: TransitionType.fadeIn);
          },
          child: Text(Login,style: mystyle(15.0, FontWeight.w500,Colors.blue[800]),),
        ),
        GestureDetector(
          onTap: (){
            setState(() {
              if(Current_step == 1){
                Complete1().then((value) => (value)?Current_step += 1:
                ShowToast(ErrorProceeding, context));
              }
              else if(Current_step == 2){
                Complete2().then((value) => (value)?Current_step += 1:
                ShowToast(ErrorProceeding, context));
              }
              else if(Current_step == 3){
                Complete3().then((value) => (value)?Current_step += 1:
                ShowToast(ErrorProceeding, context));
              }
            });
          },
          child: Container(
            margin: EdgeInsets.only(left: 60),
            padding: EdgeInsets.all(10.0),
            decoration: curveDecoration(10.0, Colors.blue,400),
            child: Text(Next,style: mystyle(15.0, FontWeight.w400,Colors.white),),
          ),
        ),
      ],
    );
  }

  Widget Steps(){
    if(Current_step == 1)
    return Column(
      children: [
        Center(child: Text(PersonalDetails + "  1/3",style: mystyle(15.0, FontWeight.w500,Colors.black),)),
        VSpace(10.0),
        InputText(Name, NameController,Icon(Icons.text_format),false,TextInputType.text,FilteringTextInputFormatter.singleLineFormatter),
        InputText(Mobile, MobileNumberController,Icon(Icons.phone),false,TextInputType.phone,FilteringTextInputFormatter.digitsOnly),
        InputText(Email, EmailController,Icon(Icons.email),false,TextInputType.emailAddress,FilteringTextInputFormatter.singleLineFormatter),
        InputText(Password, PasswordController,PasswordIcon,passwordobscure,TextInputType.text,FilteringTextInputFormatter.singleLineFormatter),
        VSpace(10.0),
        NextStep(),
      ],
    );

    if(Current_step == 2)
      return Column(
        children: [
          Center(child: Text(shopDetails + "  2/3",style: mystyle(15.0, FontWeight.w500,Colors.black),)),
          VSpace(10.0),
          InputText(ShopName, ShopNameController,Icon(Icons.text_format),false,TextInputType.text,FilteringTextInputFormatter.singleLineFormatter),
          InputText(Address, AddressController,Icon(Icons.shopping_cart),false,TextInputType.text,FilteringTextInputFormatter.singleLineFormatter),
          InputText(City, CityController,Icon(Icons.edit_location_outlined),false,TextInputType.text,FilteringTextInputFormatter.singleLineFormatter),
          InputText(PostalCode, PostalCodeController,Icon(Icons.code),false,TextInputType.number,FilteringTextInputFormatter.digitsOnly),
          InputText(State, StateController,Icon(Icons.edit_location_outlined),false,TextInputType.text,FilteringTextInputFormatter.singleLineFormatter),
          InputText(Country, CountryController,Icon(Icons.edit_location_outlined),false,TextInputType.text,FilteringTextInputFormatter.singleLineFormatter),
          VSpace(10.0),
          NextStep(),
        ],
      );

    if(Current_step == 3)
      return Column(
        children: [
          Center(child: Text(BankDetails + "  2/3",style: mystyle(15.0, FontWeight.w500,Colors.black),)),
          VSpace(10.0),
          InputText(BankHolderName, BankHolderNameController,Icon(Icons.text_format),false,TextInputType.text,FilteringTextInputFormatter.singleLineFormatter),
          InputText(AccountNumber, AccountNumberController,Icon(Icons.account_balance_wallet),false,TextInputType.number,FilteringTextInputFormatter.singleLineFormatter),
          InputText(IBan, IBanController,Icon(Icons.account_balance_wallet),false,TextInputType.text,FilteringTextInputFormatter.singleLineFormatter),
          InputText(BankName, BankNameController,Icon(Icons.account_balance),false,TextInputType.text,FilteringTextInputFormatter.singleLineFormatter),
          VSpace(10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  router.pop(context);
                  router.navigateTo(context, "/auth/login", transition: TransitionType.fadeIn);
                },
                child: Text(Login,style: mystyle(15.0, FontWeight.w500,Colors.blue[800]),),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    loading = true;
                  });
                  Complete3().then((value) {
                    if(value){
                      auth.AuthRegister().then((value) => {
                        if(value){
                          setState((){
                            loading = false;
                          }),
                          router.pop(context),
                          router.navigateTo(context, "/auth/login", transition: TransitionType.fadeIn),
                        }
                        else{
                          ShowToast(FailedRegister, context),
                        }
                      });
                    }else setState((){
                      loading = false;
                      ShowToast(ErrorProceeding, context);
                    });
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 60),
                  padding: EdgeInsets.all(10.0),
                  decoration: curveDecoration(10.0, Colors.blue,400),
                  child: Text(Register,style: mystyle(15.0, FontWeight.w400,Colors.white),),
                ),
              ),
            ],
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
                margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 40.0),
                width: (MediaQuery.of(context).size.width > 400)?400:MediaQuery.of(context).size.width,
                decoration: curveDecoration(20.0, Colors.grey[100],800),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Center(
                    child: Column(
                      children: [
                        Center(child: Text(Register,style: mystyle(25.0, FontWeight.w500,Colors.black),)),
                        VSpace(10.0),
                        Steps(),
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

  Future<void> Translatepage() async {
    Translate("Register").then((value) {setState(() {Register = value;});});
    Translate("Registration Failed Try Again").then((value) {setState(() {FailedRegister = value;});});
    Translate("Error To proceed Further").then((value) {setState(() {ErrorProceeding = value;});});
    await Translate("Enter Your Personal Info").then((value) {setState(() {PersonalDetails = value;});});
    Translate("Email").then((value) {setState(() {Email = value;});});
    Translate("Name").then((value) {setState(() {Name = value;});});
    Translate("Password").then((value) {setState(() {Password = value;});});
    Translate("Mobile Number").then((value) {setState(() {Mobile = value;});});
    Translate("Enter Your Shop Details").then((value) {setState(() {shopDetails = value;});});
    Translate("Address").then((value) {setState(() {Address = value;});});
    Translate("Shop Name").then((value) {setState(() {ShopName = value;});});
    Translate("City").then((value) {setState(() {City = value;});});
    Translate("State").then((value) {setState(() {State = value;});});
    Translate("Country").then((value) {setState(() {Country = value;});});
    Translate("Postal Code").then((value) {setState(() {PostalCode = value;});});
    Translate("Enter Your Bank Details").then((value) {setState(() {BankDetails = value;});});
    Translate("Bank Holder Name").then((value) {setState(() {BankHolderName = value;});});
    if(languageEnglish) IBan = "IBan Number";
    else IBan = "رقم الايبان";
    Translate("Account Number").then((value) {setState(() {AccountNumber = value;});});
    Translate("Bank Name").then((value) {setState(() {BankName = value;});});
    Translate("Login").then((value) {setState(() {Login = value;});});
    await Translate("Next").then((value) {setState(() {Next = value;});});
    if(languageEnglish) language = "English";
    else language = "عربى";
  }

  Future<bool> Complete1() async {

    bool result = false;

    setState(() {
      loading = true;
    });

    if(
      NameController.text.isNotEmpty
      && EmailController.text.isNotEmpty
      && MobileNumberController.text.isNotEmpty
      && MobileNumberController.text.length == 10
      && PasswordController.text.isNotEmpty
      && EmailController.text.isValidEmail()
    ) {
      Vender.step1Completed(
          NameController.text,
          EmailController.text,
          PasswordController.text,
        MobileNumberController.text
      );
      setState(() {
        loading = false;
        result = true;
      });
    }
    else setState(() {
      loading = false;
    });
    return result;
  }

  Future<bool> Complete2() async {
    bool result = false;

    setState(() {
      loading = true;
    });

    if(
    ShopNameController.text.isNotEmpty
    && AddressController.text.isNotEmpty
    && CityController.text.isNotEmpty
    && PostalCodeController.text.isNotEmpty
    && StateController.text.isNotEmpty
    && CountryController.text.isNotEmpty
    ){
      Vender.step2Completed(
        ShopNameController.text,
        AddressController.text,
        CityController.text,
        PostalCodeController.text,
        StateController.text,
        CountryController.text,
      );

      setState(() {
        loading = false;
        result = true;
      });
    }
    else setState(() {
      loading = false;
    });

    return result;
  }

  Future<bool> Complete3() async {
    bool result = false;

    if(
    BankHolderNameController.text.isNotEmpty
    && AccountNumberController.text.isNotEmpty
    && AccountNumberController.text.length <= 18
    && AccountNumberController.text.length >= 14
    && IBanController.text.isNotEmpty
    && IBanController.text.length == 32
    && BankNameController.text.isNotEmpty
    ){
      Vender.step3Completed(
        BankHolderNameController.text,
        AccountNumberController.text,
        IBanController.text,
        BankNameController.text
      );
      setState(() {
        result = true;
      });
    }
    return result;

  }

}
