import 'package:flutter/material.dart';

import '../bloc/model.dart';
import 'schedule.dart';

class CodelabInSchedule extends StatelessWidget {
  CodelabInSchedule({@required this.codelab});

  final Codelab codelab;

  Widget build(BuildContext context) {
    return EventInSchedule(
      color: Colors.amber,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Codelab: ${codelab.title}', style: scheduleTitleStyle),
          SizedBox(height: 4),
          Text(codelab.durationAndLocation),
        ],
      ),
    );
  }
}
