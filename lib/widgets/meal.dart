import 'package:flutter/material.dart';

import '../bloc/models.dart';
import 'schedule.dart';

const kMealColor = Color(0xFFD32F2F);

class MealInSchedule extends StatelessWidget {
  MealInSchedule(this.meal);

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return EventInSchedule(
      tag: meal,
      color: kMealColor,
      onTap: () {},
      child: SizedBox(
        height: 100,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: 200,
                alignment: Alignment.centerRight,
                //child: FlareActor('assets/hackathon.flr', animation: 'typing'),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Dinner',
                  style: scheduleTitleStyle.copyWith(color: Colors.white),
                ),
                Spacer(),
                Text(
                  meal.durationAndLocation,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
