import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kclaim/ui/tripdocumnet/tripdocs.dart';

class TripScreen extends StatelessWidget {
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
            itemExtent: 150.0,
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) =>
                _buildlistitem(context, snapshot.data.documents[index]),
          );
        },
      )),
    );
  }

  _buildlistitem(BuildContext context, DocumentSnapshot document) {
    return Card(
      elevation: 1.7,
        child: new Container(
      child: cardRowDecor(context, document),
    ));
  }

  Widget planetCard(BuildContext context, DocumentSnapshot document) {
    return new Container(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(document['Tripname'], style: TextStyle(color: Colors.white.withOpacity(1.0)),),
            subtitle: Text(document['TripStartDate'].toString(),style: TextStyle(color: Colors.white.withOpacity(1.0))),
          ),
          ButtonTheme.bar(
            // make buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[
                Icon(Icons.update,
                color: Colors.deepOrangeAccent,
                ),
                FlatButton(
                  child: const Text('UPDATE', style: TextStyle(color: Colors.black),),
                  onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyTripDocWidget(tripId:document.documentID)),
                      );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      height: 150.0,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color:  Colors.grey, //(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );
  }

  final planetThumbnail = new Container(
    margin: new EdgeInsets.symmetric(vertical: 16.0),
    alignment: FractionalOffset.centerLeft,
    child: Icon(
      Icons.flight_takeoff,color: Colors.deepOrangeAccent,
    ),
  );

  
  Widget cardRowDecor(BuildContext context, DocumentSnapshot document) {
    return new Container(
        // height: 180.0,
        margin: const EdgeInsets.symmetric(
          vertical: 1.0,
          horizontal: 4.0,
        ),
        child: new Stack(
          children: <Widget>[
            planetCard(context, document),
            planetThumbnail,
          ],
        ));
  }
}

// class CardReowDecor extends StatelessWidget {
//   BuildContext context;
//   DocumentSnapshot document;
//   CardRowDecor(BuildContext context, DocumentSnapshot document) {
//     context = context;
//     document = document;
//   }

//   final planetCard = new Container(
//     child: Column(
//       children: <Widget>[
//         ListTile(
//           title: Text('Tripname'),
//           subtitle: Text('TripStartDate'),
//         ),
//         ButtonTheme.bar(
//           // make buttons use the appropriate styles for cards
//           child: ButtonBar(
//             children: <Widget>[
//               Icon(Icons.update),
//               FlatButton(
//                 child: const Text('UPDATE'),
//                 onPressed: () {/* ... */},
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//     height: 150.0,
//     margin: new EdgeInsets.only(left: 46.0),
//     decoration: new BoxDecoration(
//       color: new Color(0xFF333366),
//       shape: BoxShape.rectangle,
//       borderRadius: new BorderRadius.circular(8.0),
//       boxShadow: <BoxShadow>[
//         new BoxShadow(
//           color: Colors.black12,
//           blurRadius: 10.0,
//           offset: new Offset(0.0, 10.0),
//         ),
//       ],
//     ),
//   );

//   final planetThumbnail = new Container(
//     margin: new EdgeInsets.symmetric(vertical: 16.0),
//     alignment: FractionalOffset.centerLeft,
//     child: Icon(
//       Icons.account_balance,
//     ),
//   );

//   @override
//   Widget build(BuildContext context) {
//     return new Container(
//         // height: 180.0,
//         margin: const EdgeInsets.symmetric(
//           vertical: 1.0,
//           horizontal: 4.0,
//         ),
//         child: new Stack(
//           children: <Widget>[
//             planetCard,
//             planetThumbnail,
//           ],
//         ));
//   }
// }
