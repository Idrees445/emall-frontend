import 'package:emall/Dashboard/dashboard.dart';
import 'package:emall/Dashboard/subscreens/colors.dart';
import 'package:emall/Translate/Tmain.dart';
import 'package:emall/api/products/product.dart';
import 'package:emall/main.dart';
import 'package:emall/models/newProduct.dart';
import 'package:emall/widgets/addProductForm.dart' as form;
import 'package:emall/widgets/loading.dart';
import 'package:emall/widgets/toast.dart';
import 'package:emall/widgets/widgets.dart';
import 'package:circulardropdownmenu/circulardropdownmenu.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class VenderProduct extends StatefulWidget {
  @override
  _VenderProductState createState() => _VenderProductState();
}

class _VenderProductState extends State<VenderProduct> {

  PlatformFile file;
  FocusNode textSecondFocusNode = new FocusNode();
  String AddProduct = "Add Product";
  String ProductName = "Product Name";
  TextEditingController ProductNameController = TextEditingController();
  String Price = "Price";
  TextEditingController PriceController = TextEditingController();
  String Description = "Desciption";
  TextEditingController DescriptionController = TextEditingController();
  String ColorString = "Color";
  String ChooseColor = "Choose a Color";
  String Quantity = "Quantity";
  List<String> ProductQuantity;
  int colorindex = 0;
  List<Color> currentColor;
  List<String> currentColorString;
  List<String> SizeList;
  void changeColor(Color color) => setState((){currentColor[colorindex] = color; currentColorString[colorindex] = '#${color.value.toRadixString(16).substring(2, 8)}';});
  String selectedCategory = "Choose";
  String selectedSubCategory = "Choose";
  bool isImageSelected = false;
  bool loading = true;
  String NoImage = "No Image Selected";
  String LargeImage = "Image Is Too Large";
  String FillAllInfo = "Please Fill All The Information";
  String save = "Save";
  String CategoryText = "Category";
  String Sizes = "Sizes";
  List<DropdownMenuItem<dynamic>> ListCat = [];
  List<DropdownMenuItem<dynamic>> ListSubCat = [];

  Future<void> TranslatePage() async {
    Translate("Add Product").then((value) => AddProduct = value);
    await Translate("Product Name").then((value) => ProductName = value);
    Translate("Price").then((value) => Price = value);
    Translate("Description").then((value) => Description = value);
    Translate("Color").then((value) => ColorString = value);
    await Translate("Choose a Color").then((value) => ChooseColor = value);
    Translate("Quantity").then((value) => Quantity = value);
    Translate("No Image Selected").then((value) => NoImage = value);
    Translate("Image is Too large").then((value) => LargeImage = value);
    await Translate("Please Fill All The Information").then((value) => FillAllInfo = value);
    Translate("Save").then((value) => save = value);
    Translate("Category").then((value) => CategoryText = value);
    await Translate("Sizes").then((value) => Sizes = value);
  }

  @override
  void dispose() {
    ProductNameController.dispose();
    PriceController.dispose();
    DescriptionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    isImageSelected = false;
    AllSubCategoryList.clear();
    AllCategoryList.clear();
    ProductQuantity = ["-1"];
    SizeList = ["-1"];
    currentColorString = ['#${Colors.white.value.toRadixString(16).substring(2, 8)}'];
    currentColor = [Colors.white];
    AllCategories().then((value) {
      AllSubCategories().then((value) {
        TranslatePage().then((value){
          setState(() {
            loading = false;
            Add_to_Cat();
            Add_to_SubCat();
          });
        });
      });
    });
    super.initState();
  }

  void Addnewone(){setState(() {ProductQuantity.add("-1");currentColor.add(Colors.white);currentColorString.add('#${Colors.white.value.toRadixString(16).substring(2, 8)}'); SizeList.add("-1");});}
  void deleteone(){setState(() {ProductQuantity.removeLast();currentColor.removeLast();currentColorString.removeLast(); SizeList.removeLast();});}

  Widget Add_to_Cat(){
    ListCat.clear();
    for(String cat in AllCategoryList){
      ListCat.add(
        DropdownMenuItem(
          child: Text(cat),
          value: cat,
        ),
      );
    }
  }

  Widget Add_to_SubCat(){
    ListSubCat.clear();
    for(String cat in AllSubCategoryList){
      ListSubCat.add(
        DropdownMenuItem(
          child: Text(cat),
          value: cat,
        ),
      );
    }
  }

  List<Widget> children(){
    List<Widget> myChildren = [
      Text(CategoryText,style: TextStyle(fontSize: 20.0,),),
      HSpace(10.0),
      GestureDetector(
        onTap: (){FocusScope.of(context).requestFocus(new FocusNode());},
        child: Container(
          width: (MediaQuery.of(context).size.width > 400)?300:MediaQuery.of(context).size.width - 100,
          child: GestureDetector(
            onTap: (){FocusScope.of(context).requestFocus(new FocusNode());},
            child: CircularDropDownMenu(
              dropDownMenuItem: ListCat,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                  FocusScope.of(context).requestFocus(new FocusNode());
                });
              },
              hintText: selectedCategory,
            ),
          ),
        ),
      ),
      HSpace(20.0),
      Container(
        width: (MediaQuery.of(context).size.width > 400)?300:MediaQuery.of(context).size.width - 100,
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: CircularDropDownMenu(
            dropDownMenuItem: ListSubCat,
            onChanged: (value) {
              setState(() {
                selectedSubCategory = value;
                FocusScope.of(context).requestFocus(new FocusNode());
              });
            },
            hintText: selectedSubCategory,
          ),
        ),
      ),
    ];
    return myChildren;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: (){
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.grey[100],
            child: (loading)?Loading(loading):Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset("assets/images/background/productBG.jpg",fit: BoxFit.fill,),
                ),
                Column(
                  children: [
                    Heading(context),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 80,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            VSpace(20.0),
                            form.Form(ProductName,ProductNameController,context,Description),
                            Container(
                              width: (kIsWeb)?250:MediaQuery.of(context).size.width - 100,
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
                                      ShowToast(LargeImage, context);
                                    }else setState(() {isImageSelected = true;});
                                  }
                                  else ShowToast(NoImage, context);
                                },
                                child: Center(
                                  child: Text("Product Image (less then 400Kb)",style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                            form.Form(Price + "(﷼)",PriceController,context,Description),
                            for(int i=0;i<ProductQuantity.length;i++) Container(
                              margin: EdgeInsets.only(bottom: 5.0,right: 5.0,left: 5.0),
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Wrap(
                                    alignment: WrapAlignment.end,
                                    children: [
                                      ChooseProductColor(i),
                                      HSpace(10.0),
                                      ChooseSize(i),
                                      HSpace(10.0),
                                      ChooseQuantity(i),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Addnewone();
                                    },
                                    child: Container(
                                      child: Icon(Icons.add_circle_outline,size: 40,),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      if(ProductQuantity.length > 1) deleteone();
                                    },
                                    child: Container(
                                      child: Icon(Icons.remove_circle_outline,size: 40,),
                                    ),
                                  ),
                                ]
                            ),
                            form.Form(Description,DescriptionController,context,Description),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: SingleChildScrollView(
                                child: (MediaQuery.of(context).size.width > 500)?Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: children(),
                                ):Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: children(),
                                ),
                              ),
                            ),
                            VSpace(20.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ChooseSize(int index){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 1.5),
      decoration: ChooseProductDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(Sizes + "  ",style: TextStyle(fontWeight: FontWeight.w800),),
          HSpace(5.0),
          InkWell(
              onTap: () {
                setState(() {
                  colorindex = index;
                });
              },
              child: Container(
                width: 40,
                child: TextFormField(
                  onChanged: (val){
                    setState(() {
                      colorindex = index;
                      SizeList[index] = val;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "0",
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }

  Widget ChooseQuantity(int index){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 1.5),
      decoration: ChooseProductDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(Quantity + "  ",style: TextStyle(fontWeight: FontWeight.w800),),
          HSpace(5.0),
          InkWell(
            onTap: () {
              setState(() {
                colorindex = index;
              });
            },
            child: Container(
              width: 40,
              child: TextFormField(
                onChanged: (val){
                  setState(() {
                    colorindex = index;
                    ProductQuantity[index] = val;
                  });
                },
                decoration: InputDecoration(
                  hintText: "0",
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            )
          ),
        ],
      ),
    );
  }

  Widget ChooseProductColor(int index){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
      decoration: ChooseProductDecoration(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(ColorString + "  ",style: TextStyle(fontWeight: FontWeight.w800),),
          HSpace(5.0),
          InkWell(
            onTap: () {
              setState(() {
                FocusScope.of(context).requestFocus(new FocusNode());
                colorindex = index;
              });
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(ChooseColor),
                    content: SingleChildScrollView(
                      child: BlockPicker(
                        availableColors: mycolors,
                        pickerColor: currentColor[index],
                        onColorChanged: changeColor,
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              height: 40,
              width: 40,
              decoration : AddProductDecoration(currentColor[index], 500),
            ),
          ),
        ],
      ),
    );
  }

  Widget Heading(BuildContext context){

    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      decoration: curveHeadDecoration(Colors.blue[800], 800, 10.0),
      child: Stack(
        children: [

          GestureDetector(
            onTap: (){
              router.pop(context);
            },
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.arrow_back,color: Colors.white,),
            ),
          ),
          Center(child: SelectableText(AddProduct,style: mystyle(20.0, FontWeight.w500, Colors.white),)),
          Positioned(
            right: 20.0,
            child: Container(
              height: 50.0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      if(ValidatingText()) {
                        setState(() {
                          loading = true;
                          newProduct = new NewProduct();
                          newProduct.productname = ProductNameController.text;
                          newProduct.price = PriceController.text;
                          newProduct.Description = DescriptionController.text;
                          newProduct.color = currentColorString;
                          newProduct.size = SizeList;
                          newProduct.category = selectedCategory;
                          newProduct.subcategory = selectedSubCategory;
                          newProduct.Quantity = ProductQuantity;
                        });
                        UploadNewProduct(context, "firstimg", file).then((
                            value) {
                          setState(() {
                            loading = false;
                          });
                          router.pop(context);
                          router.pop(context);
                          router.navigateTo(context, "/vender/dashboard",
                              transition: TransitionType.fadeIn);
                        });
                      }
                      else ShowToast(FillAllInfo, context);
                    },
                    child: Text(save,style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  bool ValidatingText(){
    return (
        ProductNameController.text.isNotEmpty
        && PriceController.text.isNotEmpty
        && DescriptionController.text.isNotEmpty
        && selectedCategory != "Choose"
        && selectedSubCategory != "Choose"
        && validatingArray(SizeList)
        && validatingArray(ProductQuantity)
        && isImageSelected
    );
  }

  bool validatingArray(List<String> arr){
    for(int i=0;i<arr.length;i++){if(arr[i] == "-1") return false;}
    return true;
  }

}
