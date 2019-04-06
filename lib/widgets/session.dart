import 'package:flutter/material.dart';

import '../bloc/model.dart';
import '../screens/session.dart';
import 'schedule.dart';

const kSessionColor = Colors.white;

class SessionInSchedule extends StatelessWidget {
  SessionInSchedule(this.session);

  final Session session;

  Widget build(BuildContext context) {
    return EventInSchedule(
      color: kSessionColor,
      tag: session,
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
            children: session.tags.map((tag) => SessionTagLabel(tag)).toList(),
          ),
        ],
      ),
    );
  }
}

class SessionTagLabel extends StatelessWidget {
  SessionTagLabel(this.tag);

  final SessionTag tag;

  Widget build(BuildContext context) {
    String text;
    Color color;

    switch (tag) {
      case SessionTag.ai:
        text = 'AI';
        color = Colors.purple;
        break;
      case SessionTag.android:
        text = 'Android';
        color = Colors.green;
        break;
      case SessionTag.design:
        text = 'Design';
        color = Colors.red;
        break;
      case SessionTag.flutter:
        text = 'Flutter';
        color = Colors.pink;
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8, right: 8),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.w800),
      ),
    );
  }
}
