import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoDetailPage extends StatelessWidget {
  final String videoUrl;

  const VideoDetailPage({Key? key, required this.videoUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Detail'),
      ),
      body: Center(
        child: YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: YoutubePlayer.convertUrlToId(videoUrl) ?? '',
            flags: const YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
            ),
          ),
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
          progressColors: const ProgressBarColors(
            playedColor: Colors.blue,
            handleColor: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}
