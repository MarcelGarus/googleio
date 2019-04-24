import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

import '../bloc/bloc.dart';
import '../widgets/details_screen.dart';
import '../widgets/error.dart';
import '../widgets/hackathon.dart';
import '../widgets/rating.dart';

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
        Widget child;

        if (hackathon.isBeforePresentations) {
          child = _buildGeneralInfo();
        } else if (hackathon.isSomeonePresenting) {
          child = _buildDuringPresentation(hackathon);
        } else {
          child = _buildResults(hackathon);
        }

        return DetailsScreen(
          tag: widget.hackathon,
          backgroundColor: kHackathonColor,
          iconColor: Colors.white,
          children: [child],
        );
      },
    );
  }

  Widget _buildGeneralInfo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 200,
          height: 200,
          child: FlareActor('assets/hackathon.flr', animation: 'typing'),
        ),
        Text('Hackathon', style: TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildDuringPresentation(HackathonSession hackathon) {
    var presenter = hackathon.presenter;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('Currently presenting', style: TextStyle(color: Colors.white)),
        SizedBox(height: 16),
        Text(
          '${presenter.name}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontFamily: 'Signature',
          ),
        ),
        SizedBox(height: 32),
        Text(
          'Please listen to the presentation and afterwards,\ngive your feedback:',
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 32),
        RatingInput(
          title: 'Idea',
          onRatingChanged: (rating) {},
        ),
        SizedBox(height: 32),
        RatingInput(
          title: 'Design',
          onRatingChanged: (rating) {},
        ),
        SizedBox(height: 32),
        RaisedButton(
          child: Text('Submit rating'),
          color: Colors.white,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildResults(HackathonSession hackathon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('Over', style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
