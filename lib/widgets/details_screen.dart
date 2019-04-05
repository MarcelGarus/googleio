import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({
    @required this.tag,
    @required this.backgroundColor,
    this.iconColor = Colors.black,
    @required this.children,
  });

  final Object tag;
  final Color backgroundColor;
  final Color iconColor;
  final List<Widget> children;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Hero(
        tag: widget.tag,
        child: Material(
          color: widget.backgroundColor,
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: Icon(Icons.close, color: widget.iconColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ].followedBy(widget.children).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
