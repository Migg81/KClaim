import 'package:flutter/material.dart';
import 'package:kclaim/bottom_sheet_fix.dart';
import 'package:kclaim/ui/starttripdialog/starttrip.dart';
import 'package:kclaim/ui/tripview/tripview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // primarySwatch:  Colors.red,
        primaryColor: Colors.red.shade800,
        primaryColorDark: Colors.red.shade900,
        primaryColorLight: Colors.red.shade700,
        brightness: Brightness.light,
        // buttonColor: Colors.red.shade900,
        iconTheme: new IconThemeData(
            color: Colors.deepOrangeAccent[700],
            opacity: 1.0,
            //size: 50.0
        ),
        accentColor: Colors.red,
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: TripScreen(), //(title: 'Kmart buisness trip claim.'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    // showModalBottomSheet<void>(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return addtrip();
    //   },
    // );

    showModalBottomSheetApp(
        context: context,
        builder: (builder) {
          return addtrip();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: Container(child: Center(child: TripScreen()))),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment Counter',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget addtrip() {
    return new TripDialog();
  }
}