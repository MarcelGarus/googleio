import 'package:flutter/material.dart';

import '../bloc/model.dart';
import 'schedule.dart';

class HackathonInSchedule extends StatelessWidget {
  HackathonInSchedule({@required this.hackathon});

  final Hackathon hackathon;

  Widget build(BuildContext context) {
    return EventInSchedule(
      color: Colors.black87,
      onTap: () {},
      child: SizedBox(
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Hackathon',
              style: scheduleTitleStyle.copyWith(color: Colors.white),
            ),
            Spacer(),
            Text(
              hackathon.durationAndLocation,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
