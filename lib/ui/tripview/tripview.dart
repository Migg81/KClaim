import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:kclaim/bottom_sheet_fix.dart';
import 'package:kclaim/ui/starttripdialog/starttrip.dart';
import 'package:kclaim/ui/tripdocumnet/tripdocs.dart';

class TripScreen extends StatefulWidget {
  TripScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TripScreenState createState() => new _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  void addtrip(BuildContext context) {
    showModalBottomSheetApp(
        builder: (builder) {
          return TripDialog();
        },
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trips"),
      ),
      body: Center(
          child: StreamBuilder(
        stream: Firestore.instance
            .document('users/User1')
            .collection('Trips')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text("Loading....");
          return ListView.builder(
            itemExtent: 130.0,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) =>
                _buildlistitem(context, snapshot.data.documents[index]),
          );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          addtrip(context);
        }),
        tooltip: 'Add Trip',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget cardRowDecor(BuildContext context, DocumentSnapshot document) {
    return new Container(
        margin: const EdgeInsets.symmetric(
          vertical: 1.0,
          horizontal: 4.0,
        ),
        child: new Stack(
          children: <Widget>[
            tripCard(context, document),
            planetThumbnail,
          ],
        ));
  }

  _buildlistitem(BuildContext context, DocumentSnapshot document) {
    return Card(
        elevation: 1.7,
        child: new Container(
          child: cardRowDecor(context, document),
        ));
  }

  Widget tripCard(BuildContext context, DocumentSnapshot document) {
    return new GestureDetector(
      onDoubleTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MyTripDocWidget(tripId: document.documentID)),
        );
      },
      child: Container(
        child: Column(
          children: <Widget>[
            ListTile(
                title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  document['Tripname'],
                  style: TextStyle(color: Colors.white.withOpacity(1.0)),
                ),
                Text(new DateFormat.yMMMd().format(document['TripStartDate']))
              ],
            )),
            ButtonTheme.bar(
              // make buttons use the appropriate styles for cards
              child: ButtonBar(
                children: <Widget>[
                  Icon(
                    Icons.update,
                  ),
                  FlatButton(
                    child: const Text(
                      'UPDATE',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MyTripDocWidget(tripId: document.documentID)),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        height: 120.0,
        margin: new EdgeInsets.only(left: 46.0),
        decoration: new BoxDecoration(
          color: Colors.grey, //(0xFF333366),
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.circular(8.0),
          boxShadow: <BoxShadow>[
            new BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: new Offset(0.0, 11.0),
            ),
          ],
        ),
      ),
    );
  }

  final planetThumbnail = new Container(
    margin: new EdgeInsets.symmetric(vertical: 16.0),
    alignment: FractionalOffset.centerLeft,
    child: Icon(
      Icons.flight_takeoff,
    ),
  );
}
