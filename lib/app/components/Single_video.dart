import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SingleVideoPlayer extends StatefulWidget {
  final String videoLink;

  const SingleVideoPlayer({super.key, required this.videoLink});

  @override
  _SingleVideoPlayerState createState() => _SingleVideoPlayerState();
}

class _SingleVideoPlayerState extends State<SingleVideoPlayer> {
  late ChewieController chewieController;
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    super.initState();
    chewieController = ChewieController(
      videoPlayerController:
          VideoPlayerController.networkUrl(Uri.parse(widget.videoLink)),
    );
  }

  @override
  void dispose() {
    chewieController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: AspectRatio(
            aspectRatio:
                chewieController.videoPlayerController.value.aspectRatio,
            child: Chewie(controller: chewieController)),
      ),
    );
  }
}
