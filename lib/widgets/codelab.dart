import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

import '../bloc/model.dart';
import 'schedule.dart';

class CodelabInSchedule extends StatelessWidget {
  CodelabInSchedule({@required this.codelab});

  final Codelab codelab;

  Widget build(BuildContext context) {
    return EventInSchedule(
      event: codelab,
      color: Colors.amber,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: Align(
              alignment: Alignment.centerRight,
              child: FlareActor(
                "assets/codelab.flr",
                alignment: Alignment.centerRight,
                fit: BoxFit.contain,
                animation: "glass",
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Codelab: ${codelab.title}', style: scheduleTitleStyle),
              SizedBox(height: 24),
              Text(codelab.durationAndLocation),
            ],
          ),
        ],
      ),
    );
  }
}
