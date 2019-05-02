class TravelDoc {
  TravelDoc(
      {this.id,
      this.amount,
      this.currency,
      this.date,
      this.description,
      this.devicePhysicalPath,
      this.expenseCategory,
      this.filePath,
      this.paymnetMethod,
      this.receiptNo});
  String id;
  String amount;
  String currency;
  String date;
  String description;
  String devicePhysicalPath;
  String expenseCategory;
  String filePath;
  String paymnetMethod;
  String receiptNo;


   TravelDoc.fromMap(Map<String, dynamic> map) {

 
    this.id = map['documentID'];
    this.amount = map['Amount'];
    this.currency = map['Currency'];

    this.date = map['Date'];
    this.description = map['Description'];
    this.devicePhysicalPath = map['DevicePhysicalPath'];

    this.expenseCategory = map['ExpenseCategory'];
    this.filePath = map['FilePath'];
    this.paymnetMethod = map['Paymnet Method'];

    this.receiptNo = map['Receipt No'];
  }
}
