import 'package:flutter/foundation.dart';

@immutable
class Event {
  final DateTime start;
  final Duration duration;

  Event({
    @required this.start,
    @required this.duration,
  });
}

class Session extends Event {
  final String title;
  final String description;
  final List<SessionTag> tags;

  Session({
    @required this.title,
    @required this.description,
    @required this.tags,
  });
}

enum SessionTag { android, ai, flutter }
