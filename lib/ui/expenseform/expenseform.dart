import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class Expenseform extends StatefulWidget {
  Expenseform({Key key, this.title}) : super(key: key);
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
    '',
    'Miscellaneous',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Food'
  ];
  String _expenceType = '';
  String documentFilename;
  DateTime selectedDate = new DateTime.now();
  File sampleImage;
  String paymentmethodType = "";

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
      body: new SafeArea(
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
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton(
                            value: _expenceType,
                            //style: TextStyle(color: Colors.black),
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                _expenceType = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: _expenceTypes.map((String value) {
                              return new DropdownMenuItem(
                                value: value,
                                child: new Text(value,style: TextStyle(color: Colors.black),),
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
                          value: "Cache",
                          groupValue: paymentmethodType,
                          onChanged: handleRadioValueChanged,
                        ),
                        new Text('Cache',
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                  TextField(
                    style: TextStyle(color: Colors.black),
                    controller: txtDescriptionController,
                    onChanged: (v) => txtDescriptionController.text = v,
                    decoration: new InputDecoration(
                      hintText: "Description",
                      icon: const Icon(Icons.attach_money),
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
                      icon: const Icon(Icons.attach_money),
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
                              "${DateFormat('yyyy-MM-dd').format(selectedDate)}",style: TextStyle(color: Colors.black,)),
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
                          child: (sampleImage == null
                              ? Text("Upload file")
                              : Text("$documentFilename")),
                          decoration: const InputDecoration(
                            labelText: '',
                            icon: const Icon(Icons.file_upload),
                          ),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(right:4,top: 60 ),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        DecoratedBox(
                          decoration: new BoxDecoration(
                              border:
                                  new Border.all(color: Colors.red.shade900),
                              borderRadius: new BorderRadius.circular(30.0),
                              color: Colors.red.shade900),
                          child: _createPillButton('Save'),
                        ),
                      ],
                    ),
                  ),
                ],
              ))),
    );
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
          _uploadFileToFireStore();
        },
        child: new Text(text),
      ),
    );
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
      sampleImage = tempImage;
    });

    documentFilename = sampleImage.path.substring(
        sampleImage.path.lastIndexOf("/") + 1, sampleImage.path.length);
  }

  Future getImagefromCamera() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      sampleImage = tempImage;
    });

    documentFilename = sampleImage.path.substring(
        sampleImage.path.lastIndexOf("/") + 1, sampleImage.path.length);
  }

  _uploadFileToFireStore() async {
    final StorageReference ref =
        FirebaseStorage.instance.ref().child('$documentFilename');
    final StorageUploadTask uploadTask = ref.putFile(sampleImage);

    final downloadURL =
        await (await uploadTask.onComplete).ref.getDownloadURL();

    if (uploadTask.isComplete) {
      DocumentReference reference =
          Firestore.instance.document('users/User1/Trips/-LVaowJaSoKuQWge_NWg');

      await reference.collection('TropDocs').add({
        "Date": DateFormat('yyyy-MM-dd').format(selectedDate).toString(),
        "FilePath": downloadURL,
        "ExpenseCategory": _expenceType,
        "DevicePhysicalPath": sampleImage.path,
        "Amount": txtAmountController.text,
        "Paymnet Method": paymentmethodType,
        "Currency": txtCurrencyController.text,
        "Description": txtDescriptionController.text,
        "Receipt No": txtReceiptNoController.text,
      });
    }
  }
}
