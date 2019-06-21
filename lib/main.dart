import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:package_hello/package_hello.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static const platform = const MethodChannel('samples.flutter.io/battery');

  int numm = 0;

  // Get battery level.
  String _batteryLevel = '还没有调用哦.';

   Future<Null> _getBatteryLevel() async {
    String batteryLevel;
    try {
//      final int result = await platform.invokeMethod('getBatteryLevel');
      final int result = await platform.invokeMethod('getCount');
      batteryLevel = '获取的电量 $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "调用失败: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  Future<Null> _getOtherNum() async {

    int numms =  Calculator().addOne(numm);

    setState(() {
      numm = numms;
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new RaisedButton(
              child: new Text('获取系统电量'),
              onPressed: _getBatteryLevel,
            ),
            new Text(_batteryLevel),

            new RaisedButton(
              child: new Text('获取另外一个包'),
              onPressed: _getOtherNum,
            ),
            new Text(numm.toString()),
          ],
        ),
      ),
    );
  }
}
