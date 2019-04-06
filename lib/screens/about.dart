import 'package:flutter/material.dart';
//import 'package:webview_flutter/webview_flutter.dart';

import '../widgets/codelab.dart';
import '../widgets/hackathon.dart';
import '../widgets/meal.dart';
import '../widgets/schedule.dart';
import '../widgets/session.dart';

class AboutScreen extends StatelessWidget {
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
          SizedBox(height: 16),
          AboutApp(),
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
              "direction if you get stuck.",
          color: kCodelabColor,
        ),
        AboutType(
          title: 'Hackathon',
          description: "Callaborate intensively on software for the duration "
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
        tag: 'type $title',
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
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('About this app', style: kSectionTitleStyle),
        SizedBox(height: 8),
        Text("This app is independently developed by Marcel Garus. "
            "Feel free to leave a star on GitHub."),
        Container(
          height: 200,
          width: 300,
          color: Colors.red,
          /*child: WebView(
            initialUrl: 'https://flutter.io',
            javascriptMode: JavascriptMode.unrestricted,
          ),*/
        ),
      ],
    );
  }
}
