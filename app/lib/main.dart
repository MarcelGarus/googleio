import 'package:flutter/material.dart';

import 'bloc/model.dart';
import 'screens/info.dart';
import 'screens/location.dart';
import 'screens/schedule.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google I/O 19 extended at HPI',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.red,
        type: BottomNavigationBarType.shifting,
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            title: Text('Info'),
            backgroundColor: Colors.yellow,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text('Schedule'),
            backgroundColor: Colors.deepOrange,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            title: Text('Location'),
            backgroundColor: Colors.green,
          ),
        ],
        onTap: (index) => setState(() => _index = index),
      ),
    );
  }

  Widget _buildBody() {
    switch (_index) {
      case 0:
        return InfoScreen();
      case 1:
        return ScheduleScreen(
          events: kEvents,
        );
      case 2:
        return LocationScreen();
      default:
        throw "There are only three tabs to show.";
    }
  }
}
