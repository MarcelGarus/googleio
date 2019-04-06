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
    teams: {},
  );
}

Map<String, Team> parseTeams(QuerySnapshot data) {
  var teams = Map<String, Team>();

  for (var doc in data.documents) {
    var data = doc.data;

    teams[doc.documentID] = Team(
      name: data['name'],
      appName: data['appName'],
      appDescription: data['appDescription'],
      members: (data['members'] as List).map((name) => Member(name)).toList(),
      ideaRating: parseRating(Map<String, dynamic>.from(data['idea'])),
      designRating: parseRating(Map<String, dynamic>.from(data['design'])),
      weightedRating: data['weightedRating'],
    );
  }

  return teams;
}

Rating parseRating(Map<String, dynamic> data) {
  return Rating(
    one: data['1'],
    two: data['2'],
    three: data['3'],
    four: data['4'],
    five: data['5'],
  );
}
