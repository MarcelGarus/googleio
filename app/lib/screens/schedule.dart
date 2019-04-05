import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class ScheduleScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return MainScreen();
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Sticky Header example')),
      body: Builder(builder: (BuildContext context) {
        return CustomScrollView(
          slivers: _buildSlivers(context),
          //slivers: _buildSideHeaderGrids(context, 0, 5),
        );
      }),
    );
  }

  List<Widget> _buildSlivers(BuildContext context) {
    return List.generate(5, (sliverIndex) {
      return SliverStickyHeader(
        overlapsContent: true,
        header: _buildSideTime(context, DateTime.now()),
        sliver: SliverPadding(
          padding: EdgeInsets.only(left: 80),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              EventInSchedule(
                title: 'Test-Event',
                location: 'Dachterrasse',
                duration: Duration(hours: 1, minutes: 30),
                onTap: () {},
              ),
              EventInSchedule(
                title: 'Test-Event',
                location: 'Dachterrasse',
                onTap: () {},
              ),
              Container(color: Colors.red, height: 100),
              Container(color: Colors.yellow, height: 100),
              Container(color: Colors.orangeAccent, height: 100),
              Container(color: Colors.deepOrangeAccent, height: 100),
              Container(color: Colors.deepOrange, height: 100),
            ]),
          ),
        ),
      );
    });
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Text(text, style: TextStyle(fontSize: 24, letterSpacing: -1)),
      ),
    );
  }
}

class EventInSchedule extends StatelessWidget {
  EventInSchedule({
    @required this.title,
    this.duration = const Duration(hours: 1),
    @required this.location,
    @required this.onTap,
  });

  final String title;
  final Duration duration;
  final String location;
  final VoidCallback onTap;

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 4, bottom: 4, right: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 16, fontFamily: 'Signature'),
              ),
              SizedBox(height: 4),
              Text('$duration / $location'),
            ],
          ),
        ),
      ),
    );
  }
}
