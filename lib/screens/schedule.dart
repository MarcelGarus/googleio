import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../bloc/bloc.dart';
import '../widgets/session.dart';
import '../widgets/codelab.dart';
import '../widgets/hackathon.dart';
import '../widgets/meal.dart';

class TimeslotOfEvents {
  final DateTime start;
  final List<Event> events;

  const TimeslotOfEvents(this.start, this.events);
}

class DailySchedule extends StatelessWidget {
  const DailySchedule({
    @required this.timeslots,
  }) : assert(timeslots != null);

  final List<TimeslotOfEvents> timeslots;

  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: Bloc.of(context).refreshSessions,
        child: CustomScrollView(
          slivers: timeslots.map((timeslot) {
            return SliverStickyHeader(
              overlapsContent: true,
              header: _buildSideTime(context, timeslot.start),
              sliver: SliverPadding(
                padding: const EdgeInsets.only(left: 60),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    timeslot.events.map(_buildEvent).toList(),
                  ),
                ),
              ),
            );
          }).toList(),
        ));
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

  Widget _buildEvent(Event event) {
    if (event is Session) {
      return SessionInSchedule(event);
    } else if (event is Codelab) {
      return CodelabInSchedule(event);
    } else if (event is Hackathon) {
      return HackathonInSchedule(event);
    } else if (event is Meal) {
      return MealInSchedule(event);
    } else {
      return Container(color: Colors.red, height: 100);
    }
  }
}
