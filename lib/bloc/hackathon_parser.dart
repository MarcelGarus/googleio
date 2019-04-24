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
      ratings: {
        parseRating("idea", Map<String, dynamic>.from(data['idea'])),
        parseRating("design", Map<String, dynamic>.from(data['design'])),
      },
      weightedRating: data['weightedRating'],
    );
  }

  return teams;
}

Rating parseRating(String dimension, Map<String, dynamic> data) {
  return Rating(
    dimension: dimension,
    votes: {
      1: data['1'],
      2: data['2'],
      3: data['3'],
      4: data['4'],
      5: data['5'],
    },
  );
}
