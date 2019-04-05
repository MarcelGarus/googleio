import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../bloc/model.dart';
import '../widgets/details_screen.dart';
import '../widgets/session.dart';

class SessionScreen extends StatelessWidget {
  SessionScreen({@required this.session});

  final Session session;

  Widget build(BuildContext context) {
    var start = session.start;
    var end = session.start.add(session.duration);
    var formatDate = DateFormat.yMMMd().format;
    var formatTime = DateFormat.Hm().format;
    var timeString =
        '${formatDate(start)}, ${formatTime(start)} - ${formatTime(end)}';

    return DetailsScreen(
      tag: session,
      backgroundColor: Colors.white,
      children: <Widget>[
        Text(
          session.title,
          style: TextStyle(
            fontFamily: 'Signature',
            fontSize: 42,
          ),
        ),
        SizedBox(height: 16),
        Text(timeString),
        SizedBox(height: 8),
        Text(session.location),
        SizedBox(height: 16),
        Text(session.description),
        SizedBox(height: 16),
        Wrap(
          children: session.tags.map((tag) => SessionTagLabel(tag)).toList(),
        ),
      ],
    );
  }
}
