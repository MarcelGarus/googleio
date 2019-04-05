import 'package:flutter/material.dart';

import '../bloc/model.dart';
import '../screens/session.dart';
import 'schedule.dart';

class SessionInSchedule extends StatelessWidget {
  SessionInSchedule({@required this.session});

  final Session session;

  Widget build(BuildContext context) {
    return EventInSchedule(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => SessionScreen(session: session),
          )),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(session.title, style: scheduleTitleStyle),
          SizedBox(height: 4),
          Text(session.durationAndLocation),
          Wrap(
              children: session.tags.map((tag) {
            switch (tag) {
              case SessionTag.ai:
                return SessionTagLabel(label: 'AI', color: Colors.purple);
              case SessionTag.android:
                return SessionTagLabel(label: 'Android', color: Colors.green);
              case SessionTag.flutter:
                return SessionTagLabel(label: 'Flutter', color: Colors.pink);
            }
          }).toList()),
        ],
      ),
    );
  }
}

class SessionTagLabel extends StatelessWidget {
  SessionTagLabel({
    @required this.label,
    @required this.color,
  });

  final String label;
  final Color color;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 8),
      child: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.w800),
      ),
    );
  }
}
