import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'bloc/bloc.dart';
import 'bloc/bloc_provider.dart';
import 'screens/about.dart';
import 'screens/schedule.dart';
import 'widgets/error.dart';

void main() => runApp(BlocProvider(child: MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google I/O 19 extended at HPI',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MainScreen(),
    );
  }
}

class DayOfEvents {
  final DateTime day;
  final List<TimeslotOfEvents> timeslots;

  const DayOfEvents(this.day, this.timeslots);
}

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  List<DayOfEvents> _eventDays;
  String _error;
  TabController _controller;

  @override
  void initState() {
    super.initState();

    Bloc.of(context).eventsStream.listen((events) {
      setState(() {
        _error = null;
        _controller = null;

        if (events == null) {
          return; // Still loading.
        }

        // Get a set of all the days that events take place at.
        var days = <DateTime>{};
        var eventsByDay = Map<DateTime, Set<Event>>();

        for (var event in events) {
          var moment = event.start;
          var day = DateTime(moment.year, moment.month, moment.day);
          days.add(day);
          eventsByDay[day] ??= {};
          eventsByDay[day].add(event);
        }

        if (days.isEmpty) {
          _error = 'No events.';
          return;
        }

        // Then, cluster the events to timeslots and create the DayOfEvents.
        _eventDays = days.map((day) {
          var timeslots = Map<DateTime, Set<Event>>();
          for (var event in eventsByDay[day]) {
            timeslots[event.start] ??= {};
            timeslots[event.start].add(event);
          }
          return DayOfEvents(
            day,
            timeslots.entries.map((e) {
              return TimeslotOfEvents(e.key, e.value.toList());
            }).toList()
              ..sort((a, b) => a.start.compareTo(b.start)),
          );
        }).toList()
          ..sort((a, b) => a.day.compareTo(b.day));

        // Finally, create the tab controller.
        _controller = TabController(
          initialIndex: 0,
          length: days.length,
          vsync: this,
        );
      });
    }, onError: (error) => _error = error);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _buildContent(),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(
        'Google I/O 19 at HPI',
        style: TextStyle(fontFamily: 'Signature', color: Colors.black),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.info_outline, color: Colors.black),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => AboutScreen(),
            ));
          },
        ),
      ],
    );
  }

  Widget _buildContent() {
    if (_error != null) {
      return OopsError(
        error: "An error occurred while getting the events.\nMake sure it's "
            "no issue with your internet connection.\nOtherwise:",
        technicalDetails: _error,
      );
    }

    if (_controller == null) {
      return Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.only(top: 48),
            child: TabBarView(
              controller: _controller,
              children: _eventDays.map((eventDay) {
                return DailySchedule(timeslots: eventDay.timeslots);
              }).toList(),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Material(
            color: Colors.white,
            elevation: 2,
            child: TabBar(
              controller: _controller,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black54,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 16),
              indicatorWeight: 3,
              indicatorColor: Colors.deepOrange,
              tabs: _eventDays.map((dayOfEvents) {
                return Tab(text: DateFormat.MMMd().format(dayOfEvents.day));
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
