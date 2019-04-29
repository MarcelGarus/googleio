import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../bloc/models.dart';

typedef void RatingChangeCallback(double rating);

const kRatingColors = {
  0: Colors.white,
  1: Colors.redAccent,
  2: Colors.orangeAccent,
  3: Colors.yellowAccent,
  4: Colors.lightGreen,
  5: Colors.greenAccent,
};

class RatingInput extends StatefulWidget {
  RatingInput({
    @required this.title,
    @required this.onRatingChanged,
  }) : assert(title != null);

  final String title;
  final void Function(int rating) onRatingChanged;

  @override
  _RatingInputState createState() => _RatingInputState();
}

class _RatingInputState extends State<RatingInput> {
  double rating = 0;

  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(widget.title, style: TextStyle(color: Colors.white)),
        SmoothStarRating(
          allowHalfRating: false,
          onRatingChanged: (v) {
            setState(() => rating = v);
            widget.onRatingChanged(v.round());
          },
          starCount: 5,
          rating: rating,
          size: 40.0,
          color: kRatingColors[rating],
          borderColor: Colors.white,
        ),
      ],
    );
  }
}

class RatingView extends StatelessWidget {
  RatingView(this.rating);

  final Rating rating;

  Widget build(BuildContext context) {
    var votes = rating.votes;

    return Stack(
      children: <Widget>[
        _buildBar(Colors.white12, 1),
        _buildBar(kRatingColors[1], 1),
        Container(
          height: 10,
          color: Colors.white12,
        ),
        Container(
          height: 10,
          color: Colors.white12,
        ),
      ],
    );
  }

  Widget _buildBar(Color color, double widthFactor) {
    return Container(
      height: 10,
      alignment: Alignment.centerRight,
      child: FractionallySizedBox(
        heightFactor: 1,
        widthFactor: widthFactor,
        child: Material(color: color, borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}
