import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kclaim/ui/starttripdialog/starttrip.dart';
import 'package:kclaim/ui/tripview/tripview.dart';

class HomeCardnNewTrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.note_add),
              title: Text('Update existing buisness trip'),
              subtitle: Text('Keep adding expenditure for your new trip'),
            ),
            ButtonTheme.bar(
              // make buttons use the appropriate styles for cards
              child: ButtonBar(
                children: <Widget>[
                  Icon(Icons.add),
                  FlatButton(
                    child: const Text('ADD EXPENCE'),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return new Container(child: new TripDialog());
                          });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeCardnEditTrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.business_center),
              title: Text('Start a new buisness trip'),
              subtitle: Text('Keep adding expenditure for your new trip'),
            ),
            ButtonTheme.bar(
              // make buttons use the appropriate styles for cards
              child: ButtonBar(
                children: <Widget>[
                  Icon(Icons.update),
                  FlatButton(
                    child: const Text('UPDATE'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TripScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
