import 'package:flutter/foundation.dart';

@immutable
class HackathonSession {
  final Map<String, Hacker> hackers;
  final String currentlyPresenting;
  final bool isOver;
  final DateTime startOfCoding;
  final DateTime endOfCoding;

  const HackathonSession({
    @required this.hackers,
    @required this.currentlyPresenting,
    @required this.isOver,
    @required this.startOfCoding,
    @required this.endOfCoding,
  });

  bool get isBeforePresentations => !isSomeonePresenting && !isOver;
  bool get isSomeonePresenting => currentlyPresenting != null;
  Hacker get presenter => hackers[currentlyPresenting];

  HackathonSession withHackers(Map<String, Hacker> hackers) {
    return HackathonSession(
      hackers: hackers,
      currentlyPresenting: currentlyPresenting,
      isOver: false,
      startOfCoding: startOfCoding,
      endOfCoding: endOfCoding,
    );
  }
}

@immutable
class Hacker {
  final String name;
  final String appName;
  final String appDescription;
  final Rating idea;
  final Rating design;
  final Rating implementation;
  final double weightedRating;

  const Hacker({
    @required this.name,
    @required this.appName,
    @required this.appDescription,
    @required this.idea,
    @required this.design,
    @required this.implementation,
    @required this.weightedRating,
  });
}

@immutable
class Rating {
  final Map<int, int> votes;

  double get average =>
      votes.entries.map((e) => e.key * e.value).reduce((a, b) => a + b) /
      votes.length;

  const Rating({@required this.votes});
}
