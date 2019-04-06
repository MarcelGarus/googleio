import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc_provider.dart';
import 'event_parser.dart';
import 'hackathon_parser.dart';
import 'models.dart';
import 'streamed_property.dart';

export 'models.dart';

/// The BLoC.
class Bloc {
  final _events = StreamedProperty<List<Event>>();
  ValueObservable<List<Event>> get eventsStream => _events.stream;

  final _hackathon = StreamedProperty<HackathonSession>();
  ValueObservable<HackathonSession> get hackathonStream => _hackathon.stream;

  /// This method allows subtree widgets to access this bloc.
  static Bloc of(BuildContext context) {
    assert(context != null);
    final BlocProvider holder = context.ancestorWidgetOfExactType(BlocProvider);
    return holder?.bloc;
  }

  /// Initializes the BLoC.
  void initialize() {
    debugPrint('Initializing the BLoC.');

    // Configure the messaging synchronously.
    /*_messaging.requestNotificationPermissions();
    _messaging.configure(onMessageReceived: () async {
      await _refreshGame();
    });*/

    refreshSessions();
    _subscribeToHackathon();
  }

  void dispose() {
    _events.dispose();
  }

  Future<void> refreshSessions() async {
    try {
      var snapshot =
          await Firestore.instance.collection('events').getDocuments();
      _events.value = parseDocuments(snapshot.documents);
    } catch (e) {
      _events.addError(e);
    }
  }

  Future<void> _subscribeToHackathon() async {
    try {
      var snapshots = Firestore.instance
          .collection('hackathons')
          .document("hackathon")
          .snapshots();

      snapshots.listen(
        (snapshot) async {
          var hackathon = parseHackathon(snapshot.data);
          if (!hackathon.isBeforePresentations) {
            // Load teams.
            var teams = await Firestore.instance
                .collection('hackathons')
                .document('hackathon')
                .collection('teams')
                .getDocuments();
            hackathon = hackathon.withTeams(parseTeams(teams));
          }
          _hackathon.value = hackathon;
        },
        onError: (e, s) => _hackathon.addError('Error:\n$e\n\nStacktrace:\n$s'),
      );
    } catch (e) {
      _hackathon.addError(e);
    }
  }
}
