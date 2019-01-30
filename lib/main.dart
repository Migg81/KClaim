import 'package:flutter/material.dart';
import 'package:kclaim/ui/homecardview/homecard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Kmart buisness trip claim.'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var followerStyle =
        textTheme.subhead.copyWith(color: Colors.black);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Container(
              padding: const EdgeInsets.all(8.0),
              height: 500,
              child: Center(
                  child: new Column(
                children: <Widget>[
                  new HomeCardnNewTrip(),
                  new HomeCardnEditTrip(),
                ],
              )))),
    );
  }
}


