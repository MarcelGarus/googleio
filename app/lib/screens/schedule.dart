import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../bloc/model.dart';
import '../widgets/session.dart';
import '../widgets/codelab.dart';
import '../widgets/hackathon.dart';

class ScheduleScreen extends StatefulWidget {
  ScheduleScreen({@required this.events});

  final List<Event> events;

  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  List<DateTime> _days;
  var _events = Map<DateTime, List<Event>>();
  TabController _controller;

  void initState() {
    super.initState();

    // Extract the days from all the events and put the sorted events into a
    // map, containing the events of one day as values.
    var days = <DateTime>{};
    for (var event in widget.events) {
      var moment = event.start;
      var day = DateTime(moment.year, moment.month, moment.day);
      days.add(day);
      _events[day] = (_events[day] ?? [])..add(event);
    }
    _days = days.toList()..sort();
    for (var entry in _events.entries) {
      _events[entry.key] = entry.value
        ..sort((a, b) => a.start.compareTo(b.start));
    }

    _controller = TabController(
      initialIndex: 0,
      length: _days.length,
      vsync: this,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        controller: _controller,
        labelPadding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black54,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 16),
        indicatorWeight: 3,
        indicatorColor: Colors.deepOrange,
        tabs: _days.map((day) => Tab(text: '${day.day}.${day.month}')).toList(),
      ),
      body: TabBarView(
        controller: _controller,
        children: _days.map((day) {
          return DailySchedule(events: _events[day]);
        }).toList(),
      ),
    );
  }
}

class DailySchedule extends StatelessWidget {
  DailySchedule({
    this.events,
  });

  final List<Event> events;

  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: List.generate(5, (sliverIndex) {
        return SliverStickyHeader(
          overlapsContent: true,
          header: _buildSideTime(context, DateTime.now()),
          sliver: SliverPadding(
            padding: EdgeInsets.only(left: 60),
            sliver: SliverList(
              delegate: SliverChildListDelegate(events.map((event) {
                if (event is Session) {
                  return SessionInSchedule(session: event);
                } else if (event is Codelab) {
                  return CodelabInSchedule(codelab: event);
                } else if (event is Hackathon) {
                  return HackathonInSchedule(hackathon: event);
                } else {
                  return Container(color: Colors.red, height: 100);
                }
              }).toList()),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSideTime(BuildContext context, DateTime time) {
    String text = '${time.hour}';
    if (time.minute >= 0) {
      text += ':${time.minute < 10 ? '0' : ''}${time.minute}';
    } else {
      text += ':00';
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 60,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Signature',
            fontSize: 16,
            letterSpacing: -1,
          ),
        ),
      ),
    );
  }
}
