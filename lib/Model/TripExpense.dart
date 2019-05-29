class TripExpense {
  TripExpense(
      {this.id,
      this.amount,
      this.currency,
      this.date,
      this.description,
      this.devicePhysicalPath,
      this.expenseCategory,
      this.filePath,
      this.paymnetMethod,
      this.receiptNo,
      this.tripId});
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
  String tripId;

  TripExpense.fromMap(Map<String, dynamic> map) {
    this.id = map['Document_Id'].toString();
    this.amount = map['Amount'].toString();
    this.currency = map['Currency'];

    this.date = map['Date'];
    this.description = map['Description'];
    this.devicePhysicalPath = map['Device_Physical_Path'];

    this.expenseCategory = map['Expense_Category'];
    this.filePath = map['File_Path'];
    this.paymnetMethod = map['Payment_Method'];

    this.receiptNo = map['Receipt_Number'];
    this.tripId = map['Trip_Id'].toString();
  }
}