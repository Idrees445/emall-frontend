class NewProduct{

  String Id = "null";
  String productname = "null";
  String price = "null";
  String Description;
  List<int> ProductPic = [];
  String category;
  String subcategory;
  List<String> color = [];
  List<String> Quantity = [];
  List<String> size = [];

  NewProduct({this.ProductPic, this.productname, this.price,this.Description,this.color,this.size,this.category,this.subcategory,this.Quantity});

  void createProduct(String name,String Price, String Des,List<int> Productpic, String Category, String Subcategory, var Color, var Size,String _id,var quantity){
    this.productname = name;
    this.price = Price;
    this.Description = Des;
    this.ProductPic = Productpic;
    this.category = Category;
    this.subcategory = Subcategory;
    this.color = Color.substring(1,Color.length-1).split(',');
    this.size = Size.substring(1,Size.length-1).split(',');
    this.Id = _id;
    this.Quantity = quantity.substring(1,quantity.length-1).split(',');
    for(int i=0;i<color.length;i++){
      color[i] = color[i].trim();
      size[i] = size[i].trim();
      Quantity[i] = Quantity[i].trim();
      color[i] = color[i].replaceAll(']', '');
      size[i] = size[i].replaceAll(']', '');
      Quantity[i] = Quantity[i].replaceAll(']', '');
      color[i] = color[i].replaceAll('[', '');
      size[i] = size[i].replaceAll('[', '');
      Quantity[i] = Quantity[i].replaceAll('[', '');
    }
  }
}