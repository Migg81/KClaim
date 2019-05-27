import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import 'package:kclaim/DBandService/APIServices.dart';
import 'package:kclaim/Model/Trip.dart';
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

  Widget _createPillButton(String text) {
    return new ClipRRect(
      borderRadius: new BorderRadius.circular(40.0),
      child: new MaterialButton(
        minWidth: 100.0,
        // color: backgroundColor,
        // textColor: textColor,
        onPressed: () async {
          var addTrip = new Trip();
          addTrip.id = 1;
          addTrip.tripName = txtTripNameController.text;
          addTrip.date = selectedDate.toString();

          await createPost(addTrip, 1);

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TripScreen()),
          );
        },
        child: new Text(text),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: Padding(
          padding: EdgeInsets.all(11),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                leading: const Icon(Icons.person),
                title: new TextField(
                  style: TextStyle(color: Colors.black),
                  controller: txtTripNameController,
                  onChanged: (v) => txtTripNameController.text = v,
                  decoration: new InputDecoration(
                    hintText: "Name",
                  ),
                ),
              ),
              ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: Text(
                    "${DateFormat('yyyy-MM-dd').format(selectedDate)}",
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () {
                    _selectDate(context);
                  }),
              new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  DecoratedBox(
                    decoration: new BoxDecoration(
                        border: new Border.all(color: Colors.red.shade900),
                        borderRadius: new BorderRadius.circular(30.0),
                        color: Colors.red.shade900),
                    child: _createPillButton('Save'
                        //textColor: Colors.white70,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ));
    //return ;
  }
}
