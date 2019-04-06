import 'package:flutter/material.dart';

class OopsError extends StatelessWidget {
  OopsError({
    @required this.error,
    @required this.technicalDetails,
  });

  final String error;
  final String technicalDetails;

  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Oh no!',
              style: TextStyle(fontFamily: 'Signature', fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(error, textAlign: TextAlign.center),
            SizedBox(height: 16),
            Text(
              'Show this to Marcel!',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
        onLongPress: () {
          showDialog(
            context: context,
            builder: (ctx) {
              return Scaffold(
                body: ListView(
                  children: <Widget>[ErrorWidget(technicalDetails)],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
