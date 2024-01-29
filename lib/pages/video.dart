
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
 
void main() => runApp(const VideoApp());
 
class VideoApp extends StatelessWidget {
  const VideoApp({super.key});

  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      theme: ThemeData( 
        primarySwatch: Colors.green, // Set the app's primary theme color 
      ), 
      debugShowCheckedModeBanner: false, 
      home: Scaffold( 
        appBar: AppBar( 
          title: const Text('Video Player'), 
        ), 
        body: const Center( 
          child: VideoPlayerApp(), 
        ), 
      ), 
    ); 
  } 
}

class VideoPlayerApp extends StatefulWidget {
  const VideoPlayerApp({super.key});
 
  @override 
  // ignore: library_private_types_in_public_api
  _VideoPlayerAppState createState() => _VideoPlayerAppState(); 
} 
  
class _VideoPlayerAppState extends State<VideoPlayerApp> { 
  VideoPlayerController? _controller; 
  
  @override 
  void initState() { 
    super.initState(); 
  
    // Create a VideoPlayerController for the video you want to play. 
    _controller = VideoPlayerController.asset("video/mov_bbb.mp4");
  
    // Initialize the VideoPlayerController. 
    _controller!.initialize(); 
  
    // Play the video. 
    _controller!.play(); 
  } 
  
  @override 
  Widget build(BuildContext context) { 
    return AspectRatio( 
      aspectRatio: _controller!.value.aspectRatio, 
      child: VideoPlayer(_controller!), 
    ); 
  } 
  
  @override 
  void dispose() { 
    super.dispose(); 
  
    // Dispose of the VideoPlayerController. 
    _controller!.dispose(); 
  } 
} 