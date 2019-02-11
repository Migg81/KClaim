import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kclaim/ui/expenseform/expenseform.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class MyTripDocWidget extends StatefulWidget {
  final String tripId;
  MyTripDocWidget({Key key, this.tripId}) : super(key: key);

  @override
  _MyTripDocWidgettState createState() => _MyTripDocWidgettState();
}

class _MyTripDocWidgettState extends State<MyTripDocWidget> {
  File sampleImage;
  int totalcost;
  int count = 0;
  bool inprogress = false;

  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var followerStyle = textTheme.subhead.copyWith(color: Colors.black);

    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Doc'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.email, size: 30.0),
            tooltip: 'Choose date',
            onPressed: (() async {
              setState(() {
                inprogress = true;
              });
              await _pepairingCSVData('${widget.tripId}');
              await _uploadCSVToFireStore();
            }),
          ),
        ],
      ),
      body: Center(
        child: inprogress
            ? const Center(child: const CircularProgressIndicator())
            : new Column(children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Container(
                        child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _calculatingtravelCost(
                                followerStyle, '${widget.tripId}')))),
                Expanded(
                  child: StreamBuilder(
                    stream: Firestore.instance
                        .document('/users/User1/Trips/${widget.tripId}')
                        .collection('TropDocs')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return const Text("Loading....");
                      return ListView.builder(
                        itemExtent: 150.0,
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) => _buildlistitem(
                            context, snapshot.data.documents[index]),
                      );
                    },
                  ),
                )
              ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Expenseform()),
              );
            }),
        tooltip: 'Increment Counter',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  _buildlistitem(BuildContext context, DocumentSnapshot document) {


    return Card(
        elevation: 1.7,
        child: new Container(
          child: cardRowDecor(context, document),
        ));
  }

  Widget planetThumbnail(BuildContext context, DocumentSnapshot document) {
    return new Container(
      margin: new EdgeInsets.symmetric(vertical: 16.0),
      alignment: FractionalOffset.centerLeft,
      child: new IconButton(
        icon: new Icon(Icons.picture_as_pdf, size: 30.0),
        tooltip: 'Choose date',
        onPressed: (() {}),
      ),
    );
  }

  Widget cardRowDecor(BuildContext context, DocumentSnapshot document) {
    return new Container(
        // height: 180.0,
        margin: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 1.0,
        ),
        child: new Stack(
          children: <Widget>[
            travelDocCard(context, document),
            planetThumbnail(context, document),
          ],
        ));
  }

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempImage;
    });
  }

  _calculatingtravelCost(TextStyle costStyle, String tripId) {
    int cost = 0;
    int kount = 0;
    Firestore.instance
        .collection("/users/User1/Trips/$tripId/TropDocs")
        .snapshots()
        .listen((snapshot) {
      snapshot.documents.forEach((doc) {
        cost = (cost + int.parse(doc.data["Amount"]));
        kount = kount + 1;
        setState(() {
          totalcost = cost;
          count = kount;
        });
      });
    });

    return (<Widget>[
      new Text('Totalcost $totalcost', style: costStyle),
      new Text(
        ' | ',
        style:
            costStyle.copyWith(fontSize: 24.0, fontWeight: FontWeight.normal),
      ),
      new Text('No of Documnet $count ', style: costStyle),
    ]);
  }

  _pepairingCSVData(String tripId) async {
    String data =
        'Date,Expense Category,Travel Location,Expense Nature,Account,Description,Receipt No,' +
            'Cost Centre,Currency,Foreign Currency Amount,FX Rates,Local Currency Amount,Corporate Card,Remarks';
    await _creteLocalocalFile(data, 'START');
    Firestore.instance
        .collection("/users/User1/Trips/$tripId/TropDocs")
        .snapshots()
        .listen((snapshot) {
      snapshot.documents.forEach((doc) async {
        //cost = (cost + int.parse(doc.data["Amount"]));
        data = doc.data["Date"] +
            ',' +
            doc.data["ExpenseCategory"] +
            ',' +
            '' +
            ',' +
            doc.data["ExpenseCategory"] +
            '' +
            ',' +
            '' +
            ',' +
            doc.data["Description"] +
            ',' +
            doc.data["Receipt No"] +
            ',' +
            '' +
            ',' +
            '' +
            ',' +
            doc.data["Currency"] +
            ',' +
            '' +
            ',' +
            '' +
            ',' +
            '';

        await _creteLocalocalFile('\r\n' + data, 'APPEND');
      });
    });
  }

  _uploadCSVToFireStore() async {
    final path = await _localPath;
    final documentFilename =
        path.substring(path.lastIndexOf("/") + 1, path.length);
    final StorageReference ref =
        FirebaseStorage.instance.ref().child('$documentFilename');
    final StorageUploadTask uploadTask = ref.putFile(new File(path));

    final downloadURL =
        await (await uploadTask.onComplete).ref.getDownloadURL();

    if (uploadTask.isComplete) {
      _emailCSV(downloadURL);

      setState(() {
        inprogress = false;
      });
    }
  }

  _emailCSV(String filelocation) async {
    String url =
        'mailto:smith@example.org?subject=News&body=$filelocation%20plugin';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    final path = directory.path;

    return '$path/counter.csv';
  }

  Future<File> _creteLocalocalFile(String content, String filemode) async {
    final path = await _localPath;
    File localFile = File(path);

    if (filemode == 'START') {
      localFile.writeAsStringSync(content);
    } else {
      localFile.writeAsStringSync(content, mode: FileMode.append);
    }
    return localFile;
  }

  Widget travelDocCard(BuildContext context, DocumentSnapshot document) {
    return new Container(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              document['ExpenseCategory'],
              style: TextStyle(color: Colors.white.withOpacity(1.0)),
            ),
          ),
          new Padding(
              padding: new EdgeInsets.all(7.0),
              child: new Row(
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.all(7.0),
                    child: new Icon(
                      Icons.credit_card,
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(7.0),
                    child: new Text(
                      document['Paymnet Method'],
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(3.0),
                    child: new Icon(
                      Icons.attach_money,
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(7.0),
                    child: new Text(document['Amount'],
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(3.0),
                    child: new Icon(
                      Icons.calendar_today,
                    ),
                  ),
                  new Padding(
                      padding: new EdgeInsets.all(7.0),
                      child: new Text(
                        document['Date'],
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ))
        ],
      ),
      height: 180.0,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color: Colors.grey, //(0xFF333366),
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
}
