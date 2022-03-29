import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final XFile? video;
  const CustomVideoPlayer({required this.video, Key? key}) : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  bool showControls = false;
  Duration currentPosition = Duration();
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    super.initState();

    initController();
  }

  void initController() async {
    videoPlayerController = VideoPlayerController.file(
      File(widget.video!.path),
    );

    await videoPlayerController!.initialize();

    videoPlayerController!.addListener(() {
      final currentPosition = videoPlayerController!.value.position;

      setState(() {
        this.currentPosition = currentPosition;
      });
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (videoPlayerController == null) {
      return CircularProgressIndicator();
    }

    return AspectRatio(
      aspectRatio: videoPlayerController!.value.aspectRatio,
      child: GestureDetector(
        onTap: () {
          setState(() {
            showControls = !showControls;
          });
        },
        child: Stack(
          children: [
            VideoPlayer(
              videoPlayerController!,
            ),
            if (showControls)
              _Controls(
                onReversePressed: onReversePressed,
                onForwardPressed: onForwardPressed,
                onPlayPressed: onPlayPressed,
                isPlaying: videoPlayerController!.value.isPlaying,
              ),
            if (showControls)
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(children: [
                    Text(
                      '${currentPosition.inMinutes} : ${(currentPosition.inSeconds % 60).toString().padLeft(2, '0')}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Expanded(
                      child: Slider(
                        max: videoPlayerController!.value.duration.inSeconds
                            .toDouble(),
                        min: 0,
                        value: currentPosition.inSeconds.toDouble(),
                        onChanged: (val) {
                          videoPlayerController!
                              .seekTo(Duration(seconds: val.toInt()));
                        },
                      ),
                    ),
                    Text(
                      '${videoPlayerController!.value.duration.inMinutes} : ${(videoPlayerController!.value.duration.inSeconds % 60).toString().padLeft(2, '0')}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ]),
                ),
              )
          ],
        ),
      ),
    );
  }

  void onNewVideoPressed() {}

  void onForwardPressed() {
    final currentPosition = videoPlayerController!.value.position;

    Duration seekingPosition = videoPlayerController!.value.duration;

    if ((seekingPosition - currentPosition).inSeconds > 3) {
      seekingPosition = currentPosition + Duration(seconds: 3);
    }

    videoPlayerController!.seekTo(seekingPosition);
  }

  void onReversePressed() {
    final currentPosition = videoPlayerController!.value.position;

    Duration seekingPosition = Duration();

    if (currentPosition.inSeconds > 3) {
      seekingPosition = currentPosition - Duration(seconds: 3);
    }

    videoPlayerController!.seekTo(seekingPosition);
  }

  void onPlayPressed() {
    setState(() {
      videoPlayerController!.value.isPlaying
          ? videoPlayerController!.pause()
          : videoPlayerController!.play();
    });
  }
}

class _NewVideo extends StatelessWidget {
  final VoidCallback onPressed;

  const _NewVideo({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: IconButton(
        color: Colors.white,
        onPressed: onPressed,
        icon: Icon(
          Icons.photo_camera_back,
        ),
      ),
    );
  }
}

class _Controls extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlayPressed;
  final VoidCallback onReversePressed;
  final VoidCallback onForwardPressed;

  const _Controls(
      {Key? key,
      required this.onForwardPressed,
      required this.onPlayPressed,
      required this.onReversePressed,
      required this.isPlaying})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(0.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          renderIconButton(
              onPressed: onReversePressed, iconData: Icons.rotate_left),
          renderIconButton(
              onPressed: onPlayPressed,
              iconData: isPlaying ? Icons.pause : Icons.play_arrow),
          renderIconButton(
              onPressed: onForwardPressed, iconData: Icons.rotate_right),
        ],
      ),
    );
  }

  Widget renderIconButton(
      {required VoidCallback onPressed, required IconData iconData}) {
    return IconButton(
      color: Colors.white,
      onPressed: onPressed,
      icon: Icon(iconData),
    );
  }
}
