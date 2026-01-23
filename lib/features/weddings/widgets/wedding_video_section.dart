import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WeddingVideoSection extends StatefulWidget {
  final String videoUrl;

  const WeddingVideoSection({
    super.key,
    required this.videoUrl,
  });

  @override
  State<WeddingVideoSection> createState() => _WeddingVideoSectionState();
}

class _WeddingVideoSectionState extends State<WeddingVideoSection> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );

    await _controller.initialize();

    _controller
      ..setLooping(true)
      ..setVolume(0) // muted
      ..play();

    if (mounted) {
      setState(() => _isInitialized = true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const SizedBox(
        height: 240,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      ),
    );
  }
}
