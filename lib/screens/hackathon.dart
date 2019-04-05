import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

import '../bloc/bloc.dart';
import '../widgets/details_screen.dart';

class HackathonScreen extends StatefulWidget {
  HackathonScreen({
    @required this.hackathon,
  });

  final Hackathon hackathon;

  @override
  _HackathonScreenState createState() => _HackathonScreenState();
}

class _HackathonScreenState extends State<HackathonScreen> {
  Widget build(BuildContext context) {
    return DetailsScreen(
      tag: widget.hackathon,
      backgroundColor: Colors.black87,
      iconColor: Colors.white,
      children: <Widget>[
        SizedBox(
          width: 200,
          height: 200,
          child: FlareActor(
            'assets/hackathon.flr',
            animation: 'typing',
          ),
        ),
        Text('Hackathon', style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
