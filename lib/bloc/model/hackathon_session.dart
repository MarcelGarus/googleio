import 'package:flutter/foundation.dart';

@immutable
class HackathonSession {
  final Map<String, Team> teams;
  final String _currentlyPresenting;
  final bool isOver;
  final DateTime startOfCoding;
  final DateTime endOfCoding;

  const HackathonSession({
    @required this.teams,
    currentlyPresenting,
    this.isOver = false,
    this.startOfCoding,
    this.endOfCoding,
  }) : _currentlyPresenting = currentlyPresenting;

  bool get isBeforePresentations => !isSomeonePresenting && !isOver;
  bool get isSomeonePresenting => _currentlyPresenting != null;
  Team get presenter => teams[_currentlyPresenting];

  HackathonSession withTeams(Map<String, Team> teams) {
    return HackathonSession(
      teams: teams,
      currentlyPresenting: _currentlyPresenting,
      startOfCoding: startOfCoding,
      endOfCoding: endOfCoding,
    );
  }
}

@immutable
class Team {
  final String name;
  final String appName;
  final String appDescription;
  final List<Member> members;
  final Set<Rating> ratings;
  final double weightedRating;

  const Team({
    this.name = '',
    this.appName = '',
    this.appDescription = '',
    this.members = const [],
    this.ratings,
    this.weightedRating,
  });
}

@immutable
class Member {
  final String name;

  Member(this.name);
}

@immutable
class Rating {
  final String dimension;
  final Map<int, int> votes;

  double get average =>
      votes.entries.map((e) => e.key * e.value).reduce((a, b) => a + b) /
      votes.length;

  const Rating({
    @required this.dimension,
    @required this.votes,
  });
}
