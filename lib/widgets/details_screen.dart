import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({
    @required this.tag,
    @required this.backgroundColor,
    this.iconColor = Colors.black,
    @required this.child,
  });

  final Object tag;
  final Color backgroundColor;
  final Color iconColor;
  final Widget child;

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
          child: SafeArea(child: widget.child),
        ),
      ),
    );
  }
}

class DetailsCloseButton extends StatelessWidget {
  DetailsCloseButton({
    this.iconColor = Colors.black,
  }) : assert(iconColor != null);

  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: Icon(Icons.close, color: iconColor),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
