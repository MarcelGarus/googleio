import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

import '../bloc/models.dart';
import '../widgets/details_screen.dart';
import '../widgets/session.dart';

class SessionScreen extends StatefulWidget {
  SessionScreen({@required this.session});

  final Session session;

  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  VideoPlayerController _controller;
  VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    _listener = () => setState(() {});

    // TODO: get url from https://you-link.herokuapp.com?url=https://www.youtube.com/...
    // array of json objects with {url, quality, type, itag}
    // remove &C=WEB from the url
    _controller = VideoPlayerController.network(
        'http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
      ..addListener(_listener)
      ..setVolume(1.0)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even
        // before the play button has been pressed.
        setState(() {});
        _controller.play();
      });
  }

  @override
  void deactivate() {
    _controller
      ..setVolume(0.0)
      ..removeListener(_listener);
    super.deactivate();
  }

  Widget build(BuildContext context) {
    var start = widget.session.start;
    var end = widget.session.start.add(widget.session.duration);
    var formatDate = DateFormat.yMMMd().format;
    var formatTime = DateFormat.Hm().format;
    var timeString =
        '${formatDate(start)}, ${formatTime(start)} - ${formatTime(end)}';

    return DetailsScreen(
      tag: widget.session,
      backgroundColor: kSessionColor,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          DetailsCloseButton(),
          Text(
            widget.session.title,
            style: TextStyle(fontFamily: 'Signature', fontSize: 42),
          ),
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          SizedBox(height: 16),
          Text(timeString),
          SizedBox(height: 8),
          Text(widget.session.location),
          SizedBox(height: 16),
          Text(widget.session.description),
          SizedBox(height: 16),
          Wrap(
            children:
                widget.session.tags.map((tag) => SessionTagLabel(tag)).toList(),
          ),
        ],
      ),
    );
  }
}
