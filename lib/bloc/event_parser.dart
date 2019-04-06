import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';

List<Event> parseDocuments(List<DocumentSnapshot> documents) {
  var events = <Event>[];

  for (var doc in documents) {
    if (doc['hide'] ?? false) {
      continue;
    }

    var start = DateTime.fromMicrosecondsSinceEpoch(
        (doc['start'] as Timestamp).microsecondsSinceEpoch);
    var duration = Duration(minutes: doc['duration']);
    var location = doc['location'];

    switch (doc['type']) {
      case 'session':
        events.add(Session(
          start: start,
          duration: duration,
          location: location,
          title: doc['title'],
          description: doc['description'],
          tags: ((doc['tags'] ?? []) as List).map((tag) {
            switch (tag) {
              case 'ai':
                return SessionTag.ai;
              case 'android':
                return SessionTag.android;
              case 'design':
                return SessionTag.design;
              case 'flutter':
                return SessionTag.flutter;
            }
          }).toList(),
        ));
        break;
      case 'codelab':
        events.add(Codelab(
          start: start,
          duration: duration,
          location: location,
          title: doc['title'],
        ));
        break;
      case 'hackathon':
        events.add(Hackathon(
          start: start,
          duration: duration,
          location: location,
        ));
        break;
      case 'meal':
        events.add(Meal(start: start, duration: duration, location: location));
        break;
    }
  }

  print('Parsed events are $events');
  return events;
}
