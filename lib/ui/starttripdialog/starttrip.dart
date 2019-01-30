import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kclaim/ui/tripview/tripview.dart';

class TripDialog extends StatefulWidget {
  const TripDialog();
  @override
  State createState() => new AddNewTripDialogState();
}

class AddNewTripDialogState extends State<TripDialog> {
  final txtTripNameController = TextEditingController();
  DateTime selectedDate = new DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
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

  Widget build(BuildContext context) {
    return new SimpleDialog(
      title: Text("Trip Starter"),
      contentPadding: const EdgeInsets.all(10.0),
      children: <Widget>[
        Column(
          children: <Widget>[
            new ListTile(
              leading: const Icon(Icons.person),
              title: new TextField(
                controller: txtTripNameController,
                onChanged: (v) => txtTripNameController.text = v,
                decoration: new InputDecoration(
                  hintText: "Name",
                ),
              ),
            ),
            ListTile(
                leading: const Icon(Icons.calendar_today),
                title: Text("${DateFormat('yyyy-MM-dd').format(selectedDate)}"),
                onTap: () {
                  _selectDate(context);
                }),
            new Row /*or Column*/ (
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.done),
                  color: Colors.orange,
                  tooltip: 'Choose date',
                  onPressed: (() {
                    Firestore.instance
                        .runTransaction((Transaction transaction) async {

                      CollectionReference reference =
                          Firestore.instance.document('users/User1').collection('Trips');

                      await reference.add({
                        "Tripname": txtTripNameController.text,
                        "TripStartDate": selectedDate,
                      });
                      txtTripNameController.clear();
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TripScreen()),
                    );
                  }),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}


