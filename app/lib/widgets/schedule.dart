import 'package:flutter/material.dart';

class EventInSchedule extends StatelessWidget {
  EventInSchedule({
    this.color,
    this.onTap,
    @required this.child,
  });

  final Color color;
  final VoidCallback onTap;
  final Widget child;

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 4, bottom: 4, right: 8),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Padding(padding: const EdgeInsets.all(8), child: child),
        ),
      ),
    );
  }
}

const scheduleTitleStyle = TextStyle(
  fontSize: 16,
  fontFamily: 'Signature',
  fontWeight: FontWeight.w600,
);
