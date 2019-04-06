import 'package:flutter/material.dart';

import '../bloc/model.dart';

class EventInSchedule extends StatelessWidget {
  EventInSchedule({
    @required this.tag,
    this.color,
    this.onTap,
    @required this.child,
  });

  final Object tag;
  final Color color;
  final VoidCallback onTap;
  final Widget child;

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 4, 8, 4),
      child: Hero(
        tag: tag ?? '_',
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onTap,
            child: Padding(padding: const EdgeInsets.all(8), child: child),
          ),
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
