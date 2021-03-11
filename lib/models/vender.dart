class vender{

  //step1
  String Name = "name";
  String Email;
  String Password;
  String Mobile;
  List<int> ProfilePic = [];
  String Token;

  //step2
  String Shopname;
  String Address;
  String City;
  String PostalCode;
  String State;
  String Country;
  List<int> VAT = [];
  List<int> CR = [];

  //step2;
  String BankHoldername;
  String AccountNumber;
  String IBan;
  String BankName;

  //validation
  bool Validation = false;

  void step1Completed(String NAME, String EMAIL, String PASSWORD,String Number){
    this.Name = NAME;
    this.Email = EMAIL;
    this.Password = PASSWORD;
    this.Mobile = Number;
    // print("Step1");
    // print(Name);
    // print(Email);
    // print(Password);
    // print(ProfilePic);
  }

  void step2Completed(String SHOPNAME,String AdDDRESS, String CITY, String POSTLCODE, String STATE, String COUNTRY){
    this.Shopname = SHOPNAME;
    this.Address = AdDDRESS;
    this.City =CITY;
    this.PostalCode = POSTLCODE;
    this.State = STATE;
    this.Country = COUNTRY;

    // print(VAT);
    // print(CR);
  }

  void step3Completed(String BANKHOLDERNAME,String ACCOUNTNUMBER,String IBAN, String BANKNAME){
    this.BankHoldername = BANKHOLDERNAME;
    this.AccountNumber = ACCOUNTNUMBER;
    this.IBan = IBAN;
    this.BankName = BANKNAME;
  }

}