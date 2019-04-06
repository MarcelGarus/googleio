import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  void initState() {
    super.initState();
    _controller = TabController(initialIndex: 0, length: 4, vsync: this);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          AboutGoogleIO(),
          SizedBox(height: 16),
          AboutEventTypes(),
        ],
      ),
    );
  }
}

const kSectionTitleStyle = TextStyle(
  fontFamily: 'Signature',
  fontSize: 24,
);

class AboutGoogleIO extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('About Google I/O', style: kSectionTitleStyle),
        SizedBox(height: 8),
        Text(
            "Every year, Google hosts a developer conference in Mountain View, "
            "California, where new features of its products are announced. "
            "Viewing parties around the world collaborate with Google in "
            "building the technologies that shape our future."),
      ],
    );
  }
}

class AboutEventTypes extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('Event types', style: kSectionTitleStyle),
        SizedBox(height: 8),
        Material(
          child: Text('Noice'),
        ),
      ],
    );
  }
}

class TravelInfo extends StatefulWidget {
  @override
  _TravelInfoState createState() => _TravelInfoState();
}

class _TravelInfoState extends State<TravelInfo> {
  final isExpanded = [false, false, false];

  Widget build(BuildContext context) {
    return ListView(children: [
      ExpansionPanelList(
        expansionCallback: (index, oldExpanded) => setState(() {
              isExpanded[index] = !oldExpanded;
            }),
        children: <ExpansionPanel>[
          ExpansionPanel(
            headerBuilder: (ctx, isExpanded) => Text('Driving directions'),
            body: Text('Find directions on Google Maps to ...'),
            isExpanded: isExpanded[0],
          ),
          ExpansionPanel(
            headerBuilder: (ctx, isExpanded) => Text('Public transportation'),
            body: Text(
                'You can take public transportation to station "Griebnitzsee"'),
            isExpanded: isExpanded[1],
          ),
          ExpansionPanel(
            headerBuilder: (ctx, isExpanded) => Text('Biking'),
            body: Text(
                'Complimentary bike parking will be available at the HPI. '
                'Check Google Maps for the best bike routes and directions.'),
            isExpanded: isExpanded[2],
          ),
        ],
      ),
    ]);
  }
}
