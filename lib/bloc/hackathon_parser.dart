import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';

HackathonSession parseHackathon(Map<String, dynamic> data) {
  return HackathonSession(
    startOfCoding: DateTime.fromMicrosecondsSinceEpoch(
        (data['startOfCoding'] as Timestamp).microsecondsSinceEpoch),
    endOfCoding: DateTime.fromMicrosecondsSinceEpoch(
        (data['endOfCoding'] as Timestamp).microsecondsSinceEpoch),
    currentlyPresenting: data['currentlyPresenting'],
    isOver: data['isOver'],
    hackers: {},
  );
}

Map<String, Hacker> parseHackers(QuerySnapshot data) {
  var hackers = Map<String, Hacker>();

  for (var doc in data.documents) {
    hackers[doc.documentID] = parseHacker(doc);
  }

  return hackers;
}

Hacker parseHacker(DocumentSnapshot doc) {
  var data = doc.data;

  return Hacker(
    name: data['name'],
    appName: data['appName'],
    appDescription: data['appDescription'],
    idea: parseRating(Map<String, dynamic>.from(data['idea'])),
    design: parseRating(Map<String, dynamic>.from(data['design'])),
    implementation:
        parseRating(Map<String, dynamic>.from(data['implementation'])),
    weightedRating: data['weightedRating'],
  );
}

Rating parseRating(Map<String, dynamic> data) {
  return Rating(
    votes: {
      1: data['1'],
      2: data['2'],
      3: data['3'],
      4: data['4'],
      5: data['5'],
    },
  );
}
