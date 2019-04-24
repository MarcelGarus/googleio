import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

import '../main.dart';
import '../widgets/codelab.dart';
import '../widgets/hackathon.dart';
import '../widgets/meal.dart';
import '../widgets/schedule.dart';
import '../widgets/session.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  bool showPhone = true;

  Future<bool> customPop() async {
    if (!showPhone) return true;

    setState(() => showPhone = false);
    Future.delayed(
      Duration.zero,
      () => Navigator.of(context).pop(),
    );
    return false;
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: customPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).padding.top),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: customPop,
              ),
            ),
            AboutGoogleIO(),
            SizedBox(height: 16),
            AboutEventTypes(),
            SizedBox(height: 16),
            AboutApp(showPhone: showPhone),
          ],
        ),
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
        AboutType(
          title: 'Session',
          description:
              "Speakers from Google present interesting aspects of their "
              "products on stage. We live stream these or watch them "
              "afterwards. All sessions are publicly available on YouTube.",
          color: kSessionColor,
        ),
        AboutType(
          title: 'Codelab',
          description:
              "Get hands-on experience with various stuff. Bring your own "
              "machine, and we'll try to give you helpful advice and provide "
              "directions if you get stuck.",
          color: kCodelabColor,
        ),
        AboutType(
          title: 'Hackathon',
          description: "Collaborate intensively on software for the duration "
              "of less than a day. There are prices for those who create the "
              "best product!",
          color: kHackathonColor,
          foregroundColor: Colors.white,
        ),
        AboutType(
          title: 'Meals',
          description: "Eat and drink while exchanging thoughts about sessions "
              "with other developers.",
          color: kMealColor,
          foregroundColor: Colors.white,
        ),
      ],
    );
  }
}

class AboutType extends StatelessWidget {
  AboutType({
    @required this.title,
    @required this.description,
    @required this.color,
    this.foregroundColor = Colors.black,
  });

  final String title;
  final String description;
  final Color color;
  final Color foregroundColor;

  Widget build(BuildContext context) {
    var titleStyle = TextStyle(
      fontFamily: 'Signature',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: foregroundColor,
    );

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: EventInSchedule(
        tag: 'about type $title',
        color: color,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: titleStyle),
            SizedBox(height: 8),
            Text(description, style: TextStyle(color: foregroundColor)),
          ],
        ),
      ),
    );
  }
}

class AboutApp extends StatelessWidget {
  AboutApp({this.showPhone = true});

  final bool showPhone;

  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('About this app', style: kSectionTitleStyle),
        SizedBox(height: 8),
        Text("This app is independently developed by Marcel Garus. "
            "Feel free to leave a star on GitHub."),
        FittedBox(child: _buildPhone()),
      ],
    );
  }

  Widget _buildPhone() {
    return Container(
      width: 400,
      height: 300,
      child: Stack(
        children: <Widget>[
          Positioned.fill(child: FlareActor("assets/phone.flr")),
          Positioned(
            top: 39,
            left: 62,
            child: Transform.rotate(
              angle: -0.1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 107,
                  height: 196,
                  color: Colors.white,
                  child: FittedBox(
                    child: Container(
                      width: 428,
                      height: 784,
                      color: Colors.white,
                      child: !showPhone
                          ? null
                          : MaterialApp(
                              theme: ThemeData(primarySwatch: Colors.red),
                              home: MainScreen(),
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
