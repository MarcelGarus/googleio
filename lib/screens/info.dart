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
      appBar: TabBar(
        controller: _controller,
        labelPadding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black54,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 16),
        indicatorWeight: 3,
        indicatorColor: Colors.deepOrange,
        tabs: <Widget>[
          Tab(text: 'Event'),
          Tab(text: 'Travel'),
          Tab(text: 'About'),
          Tab(text: 'Settings'),
        ],
      ),
      body: TabBarView(
        controller: _controller,
        children: <Widget>[
          EventInfo(),
          TravelInfo(),
          Container(),
          Container(),
        ],
      ),
    );
  }
}

class EventInfo extends StatelessWidget {
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Text('WIFI'),
        Text('Wifi network: "io2019"'),
        Text('hassoisagreatman'),
        Text('EVENT TYPES'),
        Text('Sessions'),
        Text('Codelabs'),
        Text('Hackathons'),
        Text('Meals'),
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
