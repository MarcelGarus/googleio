import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc_provider.dart';
import 'event_parser.dart';
import 'model.dart';
import 'streamed_property.dart';

export 'model.dart';

/// The BLoC.
class Bloc {
  final _events = StreamedProperty<List<Event>>();
  ValueObservable<List<Event>> get eventsStream => _events.stream;

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
}
