import 'package:flutter/foundation.dart';

@immutable
class Event {
  final DateTime start;
  final Duration duration;
  final String location;

  const Event({
    @required this.start,
    @required this.duration,
    @required this.location,
  })  : assert(start != null),
        assert(duration != null),
        assert(location != null);

  String get durationAndLocation {
    String text = '';
    if (duration.inHours > 0) {
      text += '${duration.inHours}h ';
    }
    if (duration.inMinutes % 60 > 0) {
      text += '${duration.inMinutes % 60}min ';
    }
    text += '/ ${this.location}';
    return text;
  }
}

class Session extends Event {
  final String title;
  final String description;
  final List<SessionTag> tags;

  const Session({
    @required DateTime start,
    @required Duration duration,
    @required String location,
    @required this.title,
    @required this.description,
    this.tags = const [],
  })  : assert(title != null),
        assert(description != null),
        assert(tags != null),
        super(start: start, duration: duration, location: location);
}

enum SessionTag { ai, android, design, flutter }

class Codelab extends Event {
  final String title;

  const Codelab({
    @required DateTime start,
    @required Duration duration,
    @required String location,
    @required this.title,
  })  : assert(title != null),
        super(start: start, duration: duration, location: location);
}

class Hackathon extends Event {
  const Hackathon({
    @required DateTime start,
    @required Duration duration,
    @required String location,
  }) : super(start: start, duration: duration, location: location);
}

class Meal extends Event {
  const Meal({
    @required DateTime start,
    @required Duration duration,
    @required String location,
  }) : super(start: start, duration: duration, location: location);
}
