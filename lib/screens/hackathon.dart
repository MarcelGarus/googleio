import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

import '../bloc/bloc.dart';
import '../widgets/details_screen.dart';
import '../widgets/error.dart';
import '../widgets/hackathon.dart';

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
    return StreamBuilder<HackathonSession>(
      stream: Bloc.of(context).hackathonStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return OopsError(
            error:
                'Something went wrong while getting the Hackathon session...',
            technicalDetails: snapshot.error.toString(),
          );
        }

        if (!snapshot.hasData) {
          return DetailsScreen(
            tag: widget.hackathon,
            backgroundColor: kHackathonColor,
            iconColor: Colors.white,
            children: [
              Expanded(child: Center(child: CircularProgressIndicator())),
            ],
          );
        }

        var hackathon = snapshot.data;
        List<Widget> children;

        if (hackathon.isBeforePresentations) {
          children = _buildGeneralInfo();
        } else if (hackathon.isSomeonePresenting) {
          children = _buildDuringPresentation(hackathon);
        } else {
          children = _buildResults(hackathon);
        }

        return DetailsScreen(
          tag: widget.hackathon,
          backgroundColor: kHackathonColor,
          iconColor: Colors.white,
          children: children,
        );
      },
    );
  }

  List<Widget> _buildGeneralInfo() {
    return <Widget>[
      SizedBox(
        width: 200,
        height: 200,
        child: FlareActor('assets/hackathon.flr', animation: 'typing'),
      ),
      Text('Hackathon', style: TextStyle(color: Colors.white)),
    ];
  }

  List<Widget> _buildDuringPresentation(HackathonSession hackathon) {
    var presenter = hackathon.presenter;

    return <Widget>[
      Text(
        '${presenter.name} is currently presenting.',
        style: TextStyle(color: Colors.white),
      ),
    ];
  }

  List<Widget> _buildResults(HackathonSession hackathon) {
    return <Widget>[
      Text('Hackathon over', style: TextStyle(color: Colors.white)),
    ];
  }
}
