import 'package:flutter/widgets.dart';

import 'model.dart';
import 'bloc_provider.dart';
import 'streamed_property.dart';

export 'model.dart';

/// The BLoC.
class Bloc {
  final _events = StreamedProperty<List<Event>>();
  get eventsStream => _events.stream;

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

    _events.value = [
      Session(
        title: 'Google Keynote',
        description:
            'Learn about the latest product and platform innovations at '
            'Google.',
        start: DateTime(2019, DateTime.may, 7, 14, 10),
        duration: Duration(hours: 2),
        location: 'Dachterrasse',
      ),
      Codelab(
        title: 'AndroidX',
        start: DateTime(2019, DateTime.may, 7, 14, 10),
        duration: Duration(hours: 2),
        location: 'H-E.51',
      ),
      Session(
        title: 'Beyond Mobile: Material Design, Adaptable UIs, and Flutter',
        description:
            "The Material Components library has grown since Flutter's "
            "launch. Learn what's new, how to use it with our iOS Design Language "
            "library Cupertino, and how to apply it across varying screen sizes, "
            "interaction models, and viewing distances.",
        start: DateTime(2019, DateTime.may, 7, 14),
        duration: Duration(hours: 1),
        location: 'Dachterrasse',
        tags: [SessionTag.flutter],
      ),
      Hackathon(
        start: DateTime(2019, DateTime.may, 7, 16),
        duration: Duration(hours: 3),
        location: 'd.space',
      ),
    ];
  }

  void dispose() {
    _events.dispose();
  }
}
