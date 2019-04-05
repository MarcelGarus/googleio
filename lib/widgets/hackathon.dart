import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

import '../bloc/model.dart';
import '../screens/hackathon.dart';
import 'schedule.dart';

class HackathonInSchedule extends StatelessWidget {
  HackathonInSchedule({@required this.hackathon});

  final Hackathon hackathon;

  @override
  Widget build(BuildContext context) {
    return EventInSchedule(
      event: hackathon,
      color: Colors.black87,
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => HackathonScreen(hackathon: hackathon),
          )),
      child: SizedBox(
        height: 100,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: 200,
                alignment: Alignment.centerRight,
                child: FlareActor('assets/hackathon.flr', animation: 'typing'),
              ),
            ),
            Column(
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
          ],
        ),
      ),
    );
  }
}
