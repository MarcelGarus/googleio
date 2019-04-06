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
  final Rating ideaRating;
  final Rating designRating;
  final double weightedRating;

  const Team({
    this.name = '',
    this.appName = '',
    this.appDescription = '',
    this.members = const [],
    this.ideaRating,
    this.designRating,
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
  final int one, two, three, four, five;
  double get average =>
      (one + 2 * two + 3 * three + 4 * four + 5 * five) /
      (one + two + three + four + five);

  const Rating({
    @required this.one,
    @required this.two,
    @required this.three,
    @required this.four,
    @required this.five,
  });
}
