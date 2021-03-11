import 'dart:typed_data';
import 'package:emall/Translate/Tmain.dart';
import 'package:emall/api/image/image.dart';
import 'package:emall/api/secrets/Secrets.dart';
import 'package:emall/widgets/loading.dart';
import 'package:emall/widgets/toast.dart';
import 'package:emall/widgets/widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:emall/Dashboard/dashboard.dart' as dash;
import '../../main.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  String Personal = "Personal";
  String Bank = "Bank";
  String Shop = "Shop";
  String selected = "Selected";
  List<int> fullImage = Vender.ProfilePic;
  MemoryImage ProfilePictureInbytes;
  MemoryImage VatInbytes;
  MemoryImage CrInbytes;
  bool showimage = false;
  bool loading = true;
  bool edit_profile = false;
  bool edit_vat = false;
  bool edit_cr = false;
  String ProfilePic = "Profile Pic";
  String UploadVat = "VAT Certificate";
  String UploadCR = "Upload CR";
  String Email = "Email";
  String Mobile = "Mobile Number";
  String Name = "Name";
  String Password = "Password";
  String Address = "Address";
  String ShopName = "Shop Name";
  String City = "City";
  String State = "State";
  String Country = "Country";
  String PostalCode = "Postal Code";
  String BankHolderName = "Bank Holder Name";
  String IBan = "IBan code";
  String AccountNumber = "Account Number";
  String BankName = "Bank Name";
  String ChooseImage = "Choose An Image First";
  String NoImage = "No Image Selected";
  String LargeImage = "Image Is Too Large";
  PlatformFile file;
  bool canUploadPP = false;
  bool canUploadVat = false;
  bool canUploadCr = false;

  @override
  void initState() {
    ProfilePictureInbytes  = MemoryImage(Uint8List.fromList(Vender.ProfilePic));
    VatInbytes  = MemoryImage(Uint8List.fromList(Vender.VAT));
    CrInbytes  = MemoryImage(Uint8List.fromList(Vender.CR));
    TranslatePage().then((value) {
      setState(() {
        loading = false;
        selected = Personal;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Stack(
            children: [
              Container(
                width: (dash.kIsWeb)?MediaQuery.of(context).size.width - 200 : MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 50,
                child: (loading)? Loading(loading):SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          VSpace(20.0),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(image: ProfilePictureInbytes,fit: BoxFit.fill),
                            ),
                            height: 200,
                            width: 200,
                          ),
                          VSpace(20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              HSpace(20.0),
                              Button(Personal),
                              HSpace(5.0),
                              Button(Bank),
                              HSpace(5.0),
                              Button(Shop)
                            ],
                          ),
                          VSpace(10.0),
                          dividerc(Colors.grey,(kIsWeb)?MediaQuery.of(context).size.width - 200 : MediaQuery.of(context).size.width),
                          PrintDetails(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              (showimage)?
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        showimage = false;
                      });
                    },
                    child: Container(
                      width: (kIsWeb)?MediaQuery.of(context).size.width - 200:MediaQuery.of(context).size.width,
                      height: (kIsWeb)?MediaQuery.of(context).size.height - 50:MediaQuery.of(context).size.height,
                      color: Colors.black54,
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              width: (kIsWeb)?MediaQuery.of(context).size.width - 250:MediaQuery.of(context).size.width-100,
                              height: (kIsWeb)?MediaQuery.of(context).size.height - 100:MediaQuery.of(context).size.height-100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(image: MemoryImage(Uint8List.fromList(fullImage)),fit: BoxFit.fill),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20.0,
                            left: 20.0,
                            child: GestureDetector(
                                child: Icon(Icons.arrow_back,size: 40.0,),
                                onTap: (){
                              setState(() {
                                showimage = false;
                              });
                            }),
                          ),
                        ],
                      ),
                    ),
                  )
                  :SizedBox(height: 0.0,),
            ],
          ),
    );
  }

  Widget Button(String text){
    return GestureDetector(
      onTap: (){
        setState(() {
          selected = text;
        });
      },
      child: Container(
        decoration: SettingButton(selected, text),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Text(
          text,
        ),
      ),
    );
  }

  Widget PrintDetails(){

    if(selected == Personal){
      return Column(
        children: [
          Info(Name, Vender.Name),
          Info(Email, Vender.Email),
          Info(Mobile, Vender.Mobile),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: RaisedButton(
                  color: Colors.blue[800],
                  onPressed: () async {
                    var result = await FilePicker.platform.pickFiles(
                      type: FileType.image,
                      withReadStream: true,
                    );

                    if(result != null) {
                      file = result.files.single;
                      if(file.size > 411111) {
                        setState(() {
                          canUploadPP = false;
                        });
                        ShowToast(LargeImage, context);
                      }else setState(() {
                        canUploadPP = true;
                      });
                    }
                    else ShowToast(NoImage, context);
                  },
                  child: Center(
                    child: Text("Profile Picture (less then 400Kb)",style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
              HSpace(20.0),
              IconButton(icon: Icon(Icons.upload_outlined), onPressed: (){
                setState(() {
                  loading = true;
                });
                (canUploadPP)?uploadImageFile(file,ProfileUpload,"firstimg",context,"PP").then((value) => setState((){
                  Vender.ProfilePic = value;
                  loading = false;
                  canUploadVat = false;
                  canUploadCr = false;
                  canUploadPP = false;
                  router.pop(context);
                  router.navigateTo(context, "/vender/dashboard", transition: TransitionType.fadeIn);
                })):ShowToast(ChooseImage, context).then((value) => setState((){loading = false;}));
              }),
              GestureDetector(
                onTap: (){
                setState(() {
                  showimage = true;
                  fullImage = Vender.ProfilePic;
                });
              },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(image: ProfilePictureInbytes,fit: BoxFit.fill),
                  ),
                  height: 40,
                  width: 40,
                ),
              ),
            ],
          ),

          VSpace(50.0),
        ],
      );
    }

    if(selected == Bank){
      return Column(
        children: [
          Info(BankHolderName, Vender.BankHoldername),
          Info(IBan, Vender.IBan),
          Info(AccountNumber, Vender.AccountNumber),
          Info(BankName, Vender.BankName),
          VSpace(50.0),
        ],
      );
    }

    else {
      return Column(
        children: [
          Info(ShopName, Vender.Shopname),
          Info(Address, Vender.Address),
          Info(City, Vender.City),
          Info(PostalCode, Vender.PostalCode),
          Info(State, Vender.State),
          Info(Country, Vender.Country),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
               child: RaisedButton(
                 color: Colors.blue[800],
                 onPressed: () async {
                   var result = await FilePicker.platform.pickFiles(
                     type: FileType.image,
                     withReadStream: true,
                   );

                   if(result != null) {
                     file = result.files.single;
                     if(file.size > 411111) {
                       setState(() {
                         canUploadVat = false;
                       });
                       ShowToast(LargeImage, context);
                     }else setState(() {
                       canUploadVat = true;
                     });
                   }
                   else ShowToast(NoImage, context);
                 },
                 child: Center(
                   child: Text("VAT (less then 400Kb)",style: TextStyle(color: Colors.white)),
                 ),
               ),
              ),
              HSpace(20.0),
              IconButton(icon: Icon(Icons.upload_outlined), onPressed: (){
                setState(() {
                  loading = true;
                });
                (canUploadVat)?uploadImageFile(file,ProfileUpload + "/VAT","firstimg",context,"VAT").then((value) => setState((){
                  Vender.VAT = value;
                  loading = false;
                  canUploadVat = false;
                  canUploadCr = false;
                  canUploadPP = false;
                  router.pop(context);
                  router.navigateTo(context, "/vender/dashboard", transition: TransitionType.fadeIn);
                })):ShowToast(ChooseImage, context).then((value) => setState((){loading = false;}));
              }),
              GestureDetector(
                onTap: (){
                  setState(() {
                    showimage = true;
                    fullImage = Vender.VAT;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(image: VatInbytes,fit: BoxFit.fill),
                  ),
                  height: 40,
                  width: 40,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: RaisedButton(
                  color: Colors.blue[800],
                  onPressed: () async {
                    var result = await FilePicker.platform.pickFiles(
                      type: FileType.image,
                      withReadStream: true,
                    );
                    if(result != null) {
                      file = result.files.single;
                      if(file.size > 411111) {
                        setState(() {
                          canUploadCr = false;
                        });
                        ShowToast(LargeImage, context);
                      }else setState(() {
                        canUploadCr = true;
                      });
                    }
                    else ShowToast(NoImage, context);
                  },
                  child: Center(
                    child: Text("CR (less then 400Kb)",style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              HSpace(20.0),
              IconButton(icon: Icon(Icons.upload_outlined), onPressed: (){
                setState(() {
                  loading = true;
                });
                (canUploadCr)?uploadImageFile(file,ProfileUpload + "/CR","firstimg",context,"CR").then((value) => setState((){
                  Vender.CR = value;
                  loading = false;
                  canUploadVat = false;
                  canUploadCr = false;
                  canUploadPP = false;
                  router.pop(context);
                  router.navigateTo(context, "/vender/dashboard", transition: TransitionType.fadeIn);
                })):ShowToast(ChooseImage, context).then((value) => setState((){loading = false;}));
              }),
              GestureDetector(
                onTap: (){
                  setState(() {
                    showimage = true;
                    fullImage = Vender.CR;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(image: CrInbytes,fit: BoxFit.fill),
                  ),
                  height: 40,
                  width: 40,
                ),
              ),
            ],
          ),
          VSpace(50.0),
        ],
      );
    }

  }

  Widget Info(String text1, String text2){
    return SelectableText(text1 + " : " + text2,style: TextStyle(
      fontSize: 20.0,
    ),);
  }


  Future<void> TranslatePage() async {
    Translate("Personal").then((value) => Personal = value);
    Translate("Bank").then((value) => Bank = value);
    await Translate("Choose An Image First").then((value) => ChooseImage = value);
    Translate("No Image Selected").then((value) => NoImage = value);
    Translate("Image Is Too Large").then((value) => LargeImage = value);
    await Translate("Shop").then((value) => Shop = value);
    Translate("Email").then((value) {setState(() {Email = value;});});
    Translate("Name").then((value) {setState(() {Name = value;});});
    Translate("Mobile Number").then((value) {setState(() {Mobile = value;});});
    await Translate("Address").then((value) {setState(() {Address = value;});});
    Translate("Shop Name").then((value) {setState(() {ShopName = value;});});
    Translate("City").then((value) {setState(() {City = value;});});
    Translate("State").then((value) {setState(() {State = value;});});
    await Translate("Country").then((value) {setState(() {Country = value;});});
    Translate("Postal Code").then((value) {setState(() {PostalCode = value;});});
    Translate("Bank Holder Name").then((value) {setState(() {BankHolderName = value;});});
    if(languageEnglish) IBan = "IBan Number";
    else IBan = "رقم الايبان";
    Translate("Account Number").then((value) {setState(() {AccountNumber = value;});});
    Translate("Bank Name").then((value) {setState(() {BankName = value;});});
    if(languageEnglish) ProfilePic = "Profile Pic";
    else ProfilePic = "صورة العرض";
    if(languageEnglish) UploadVat = "Upload VAT Certificate";
    else UploadVat = "الشهادة الضريبية";
    if(languageEnglish) UploadCR = "Upload CR";
    else UploadCR = "السجل التجاري";
  }
}