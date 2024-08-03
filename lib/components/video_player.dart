import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:the_movie_app/models/video/video.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({
    Key? key,
    required this.videos,
  }) : super(key: key);

  final List<Video> videos;

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerControllerProvider(
      controller: _controller,
      child: YoutubePlayerIFrame(
        aspectRatio: 16 / 9,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final _playlist = widget.videos.map((video) => video.key ?? '').toList();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videos.first.key ?? '',
      params: YoutubePlayerParams(
        playlist: _playlist,
        showControls: true,
        showFullscreenButton: true,
        desktopMode: false,
        privacyEnhanced: true,
        useHybridComposition: true,
        autoPlay: false,
      ),
    );
    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      log('Entered Fullscreen');
    };
    _controller.onExitFullscreen = () {
      log('Exited Fullscreen');
    };
  }

  @override
  void dispose() {
    super.dispose();
    _controller.close();
  }
}
