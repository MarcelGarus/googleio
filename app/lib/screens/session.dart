import 'package:flutter/material.dart';

import '../bloc/model.dart';

class SessionScreen extends StatelessWidget {
  SessionScreen({@required this.session});

  final Session session;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(session.title),
      ),
      body: Container(),
    );
  }
}
