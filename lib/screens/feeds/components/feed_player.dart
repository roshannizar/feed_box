/**
 * Video controller class loading the video from the initstate
 */

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';

class FeedPlayer extends StatefulWidget {
  final String url;
  FeedPlayer({this.url});
  @override
  _FeedPlayerState createState() => _FeedPlayerState();
}

class _FeedPlayerState extends State<FeedPlayer> {
  //videoplayer initializer
  VideoPlayerController _controller;


  @override
  void initState() {
    super.initState();
    //intializing video to the controller
    _controller = VideoPlayerController.network('${widget.url}')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    //disposing the video controller as soon the screen is closed
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
      },
          child: Container(
        alignment: Alignment.center,
        child: _controller.value.initialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(alignment: Alignment.center, child: SpinKitCircle(color: Colors.blue)),
      ),
    );
  }
}
