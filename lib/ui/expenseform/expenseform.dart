import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:kclaim/DBandService/APIServices.dart';
import 'package:kclaim/Model/TripExpense.dart';

class Expenseform extends StatefulWidget {
  final String tripId;
  Expenseform({Key key, this.title, this.tripId}) : super(key: key);
  final String title;

  @override
  _ExpensePage createState() => new _ExpensePage();
}

class _ExpensePage extends State<Expenseform> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final txtAmountController = TextEditingController();
  final txtDescriptionController = TextEditingController();
  final txtReceiptNoController = TextEditingController();
  final txtCurrencyController = TextEditingController();
  List<String> _expenceTypes = <String>[
    'Miscellaneous',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Food'
  ];
  String _expenceType = 'Miscellaneous';
  String documentFilename;
  DateTime selectedDate = new DateTime.now();
  File uploadImageFile;
  String paymentmethodType = "";
  bool submitting = false;

  Future<void> _selectDocUploadDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  void toggleSubmitState() {
    setState(() {
      submitting = !submitting;
    });
  }

  void handleRadioValueChanged(String value) {
    setState(() {
      paymentmethodType = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text('Expense details'),
        ),
        body: Stack(
          children: <Widget>[
            expenceformUI(),
            submitting
                ? Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container()
          ],
        ));
  }

  Widget expenceformUI() {
    return new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
            key: _formKey,
            autovalidate: true,
            child: new ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
                new FormField(
                  builder: (FormFieldState state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        icon: const Icon(Icons.category),
                        labelText: 'Expense Category',
                      ),
                      isEmpty: _expenceType == '',
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _expenceType,
                          //style: TextStyle(color: Colors.black),
                          isDense: true,
                          onChanged: (String newValue) {
                            setState(() {
                              _expenceType = newValue;
                              state.didChange(newValue);
                            });
                          },
                          items: _expenceTypes
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                TextField(
                  style: TextStyle(color: Colors.black),
                  controller: txtAmountController,
                  keyboardType: TextInputType.number,
                  onChanged: (v) => txtAmountController.text = v,
                  decoration: new InputDecoration(
                    hintText: "Amount",
                    icon: const Icon(Icons.attach_money),
                  ),
                ),
                Container(
                  //padding: EdgeInsets.only(left: 0),
                  margin: EdgeInsets.only(left: 0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Radio(
                        value: "Card",
                        groupValue: paymentmethodType,
                        onChanged: handleRadioValueChanged,
                      ),
                      new Text('Card', style: TextStyle(color: Colors.black)),
                      new Radio(
                        value: "Cash",
                        groupValue: paymentmethodType,
                        onChanged: handleRadioValueChanged,
                      ),
                      new Text('Cash', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
                TextField(
                  style: TextStyle(color: Colors.black),
                  controller: txtDescriptionController,
                  onChanged: (v) => txtDescriptionController.text = v,
                  decoration: new InputDecoration(
                    hintText: "Description",
                    icon: const Icon(Icons.note_add),
                  ),
                ),
                TextField(
                  style: TextStyle(color: Colors.black),
                  controller: txtCurrencyController,
                  onChanged: (v) => txtCurrencyController.text = v,
                  decoration: new InputDecoration(
                    hintText: "Currency",
                    icon: const Icon(Icons.attach_money),
                  ),
                ),
                TextField(
                  style: TextStyle(color: Colors.black),
                  controller: txtReceiptNoController,
                  onChanged: (v) => txtReceiptNoController.text = v,
                  decoration: new InputDecoration(
                    hintText: "Receipt No.",
                    icon: const Icon(Icons.receipt),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectDocUploadDate(context);
                      });
                    },
                    child: Container(
                      child: new InputDecorator(
                        child: Text(
                            "${DateFormat('yyyy-MM-dd').format(selectedDate)}",
                            style: TextStyle(
                              color: Colors.black,
                            )),
                        decoration: const InputDecoration(
                          labelText: '',
                          icon: const Icon(Icons.calendar_today),
                        ),
                      ),
                    )),
                GestureDetector(
                    onTap: () {
                      _showMButtoModal();
                    },
                    child: Container(
                      child: new InputDecorator(
                        child: (uploadImageFile == null
                            ? Text("Upload file")
                            : Text("$documentFilename")),
                        decoration: const InputDecoration(
                          labelText: '',
                          icon: const Icon(Icons.file_upload),
                        ),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(right: 4, top: 60),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      DecoratedBox(
                        decoration: new BoxDecoration(
                            border: new Border.all(color: Colors.red.shade900),
                            borderRadius: new BorderRadius.circular(30.0),
                            color: Colors.red.shade900),
                        child: _createPillButton('Save'),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }

  void _showMButtoModal() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return enableUpload();
      },
    );
  }

  Widget _createPillButton(String text) {
    return new ClipRRect(
      borderRadius: new BorderRadius.circular(40.0),
      child: new MaterialButton(
        minWidth: 100.0,
        onPressed: () async {
          toggleSubmitState();
          final result = await _uploadFileToFireStore();
          toggleSubmitState();
          if (result == true) {
            Navigator.pop(context, "true");
          } else {
            // to do show error result
          }
        },
        child: new Text(text),
      ),
    );
  }

  Future<bool> _uploadFileToFireStore() async {
    try {
      var respocedata = await uploadTripRealtedFile(uploadImageFile);

      bool isSuccess = false;
      TripExpense tripExpense = new TripExpense();
      tripExpense.tripId = widget.tripId;
      tripExpense.amount = txtAmountController.text;
      tripExpense.currency = txtAmountController.text;
      tripExpense.date =
          DateFormat('yyyy-MM-dd').format(selectedDate).toString();
      tripExpense.description = txtDescriptionController.text;
      tripExpense.devicePhysicalPath = uploadImageFile.path;
      tripExpense.expenseCategory = _expenceType;
      tripExpense.filePath = "";
      tripExpense.receiptNo = txtReceiptNoController.text;
      tripExpense.paymnetMethod = paymentmethodType;

      final result = await addTripDoc(tripExpense, 1);
      if (result == 'Success') {
        isSuccess = true;
      }
      return isSuccess;
    } catch (ex) {
      return false;
    }
  }

  Widget enableUpload() {
    return Padding(
        padding: EdgeInsets.all(28.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton(
              onPressed: (() {
                getImagefromCamera();
              }),
              tooltip: 'Increment Counter',
              child: Icon(Icons.camera_enhance, size: 48, color: Colors.white),
              backgroundColor: Colors.amber,
            ),
            FloatingActionButton(
              onPressed: (() {
                getImage();
              }),
              tooltip: 'Increment Counter',
              child: Icon(Icons.photo_album, size: 48, color: Colors.white),
              backgroundColor: Colors.green,
            ),
            FloatingActionButton(
              onPressed: (() {
                getImage();
              }),
              tooltip: 'Increment Counter',
              child: Icon(Icons.archive, size: 48, color: Colors.white),
              backgroundColor: Colors.orange,
            ),
          ],
        ));
  }

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      uploadImageFile = tempImage;
    });

    documentFilename = uploadImageFile.path.substring(
        uploadImageFile.path.lastIndexOf("/") + 1, uploadImageFile.path.length);
  }

  Future getImagefromCamera() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      uploadImageFile = tempImage;
    });

    documentFilename = uploadImageFile.path.substring(
        uploadImageFile.path.lastIndexOf("/") + 1, uploadImageFile.path.length);
  }
}
