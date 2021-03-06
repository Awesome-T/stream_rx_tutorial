import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stream_rx_tutorial/model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  static Model model = new Model();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  StreamSubscription streamSubscription;

  @override
  void initState() {
    streamSubscription = MyApp.model.counterUpdates.listen((newVal) => setState(() {
          _counter = newVal;
        }));

    super.initState();
  }

  // Although this state will not get destroyed as long as the App is running its good
  // style to always free subscriptions
  @override
  void dispose() {
      streamSubscription?.cancel();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
                onPressed: MyApp.model.incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), 
    );
  }
}
