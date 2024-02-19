import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/give_page.dart';
import 'package:flutter_app/pages/send_data.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter_app/pages/requesturl.dart' as requesturl;
import 'package:path_provider/path_provider.dart';

void main() async{
  // WidgetsFlutterBinding.ensureInitialized();
  // await FlutterDownloader.initialize(debug: true); 
  runApp(
    const MaterialApp(
      home: AudioPlayPage(),
    ),
  );
}

class Item {
  const Item({required this.name});
  final String name;
}

class AudioPlayPage extends StatefulWidget {
  const AudioPlayPage({super.key});

  static const routeName = '/audio';

  @override
  State<AudioPlayPage> createState() => _AudioPlayPageState();
}

class _AudioPlayPageState extends State<AudioPlayPage> {
  var player = AudioPlayer();
  // final DownloadManager downloadManager = DownloadManager();
  late final String fileUrl;
  late final String fileName;

  bool loaded = false;

  bool playing = false;

  void loadMusic() async{
    // final file=ModalRoute.of(context)!.settings.arguments as SendDatas;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final file = ModalRoute.of(context)?.settings.arguments as SendDatas;
      await player.setAsset("assets/music/${file.filename}");
      fileUrl="assets/music/${file.filename}";
      // ignore: unnecessary_string_interpolations
      fileName="${file.filename}"; 
      //  WidgetsFlutterBinding.ensureInitialized();
      // await FlutterDownloader.initialize(debug: true);
    });
    setState(() {
      loaded = true;
    });
  }

  void playMusic() async {
    setState(() {
      playing = true;
    });
    await player.play();
  }

  void pauseMusic() async {
    setState(() {
      playing = false;
    });
    await player.pause();
  }

  @override
  void initState(){
    loadMusic();
    super.initState();
  }

//   static void downloadCallback(
//   String id,
//   DownloadTaskStatus status,
//   int progress,
// ) {
//   if (status == DownloadTaskStatus.complete) {
//     print('Download completed');
//   }
// }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future<List<Item>> getTab(int id) async {
    String url = "${requesturl.Constants.url}/api/items/tab?id=$id";
    final response = await http.get(Uri.parse(url));
    var reasonData = json.decode(response.body);
    List<Item> tabs = [];
    for (var singleTab in reasonData) {
      Item tab = Item(name: singleTab["name"]);
      tabs.add(tab);
    }
    return tabs;
  }

  Future<void> addLike(int id) async {
    const storage = FlutterSecureStorage();
    String? email = await storage.read(key: 'email');
    String url = "${requesturl.Constants.url}/api/items/like";
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'itemID': id.toString(),
        'email': email.toString(),
      }),
    );
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (_) => Center(
                  // Aligns the container to center
                  child: Container(
                // A simplified version of dialog.
                width: 244,
                height: 111,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromRGBO(43, 43, 55, 1),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(
                        'お気に入りに登録しました!',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Noto Sans CJK JP',
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 15),
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.white30, width: 0.5))),
                        child: TextButton(
                            onPressed: () {
                              // Navigator.of(content).pop(false);
                              Navigator.of(context, rootNavigator: true)
                                  .pop(false);
                            },
                            child: const Text(
                              'OK',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(95, 134, 222, 1),
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    )
                  ],
                ),
              )));
    }
  }

   Future<void> _startDownload() async {
    // ignore: unused_local_variable

    final appDir = await getApplicationDocumentsDirectory();
    // ignore: unused_local_variable
    final savedDir = appDir.path;
    
    // ignore: unused_local_variable
    final taskId = await FlutterDownloader.enqueue(
      url: fileUrl,
      savedDir: "/sdcard/Download/",
      fileName: fileName,
      showNotification: true,
      openFileFromNotification: true,
    );
    
  }
  Future<void> addDownload(int id) async {
    const storage = FlutterSecureStorage();
    String? email = await storage.read(key: 'email');
    String url = "${requesturl.Constants.url}/api/items/download";
    // ignore: unused_local_variable
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'itemID': id.toString(),
        'email': email.toString(),
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as SendDatas;

    return MaterialApp(
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/audio_back.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            margin: const EdgeInsets.only(
              left: 18,
              right: 18,
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 62),
                  height: 40,
                  child: Row(
                    children: [
                      Container(
                          alignment: Alignment.topLeft,
                          child: CircleAvatar(
                            backgroundColor:
                                const Color.fromRGBO(138, 86, 172, 0.5),
                            foregroundColor: Colors.white,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              icon: const ImageIcon(
                                  AssetImage("assets/images/cancel.png")),
                            ),
                          )),
                      Expanded(
                        child: Container(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                              backgroundColor: Colors.white30.withOpacity(0.2),
                              foregroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                  addDownload(args.id);
                                  _startDownload();
                                },
                                icon: const ImageIcon(
                                    AssetImage("assets/images/download.png")),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Text(
                          args.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 24,
                              fontFamily: 'Noto Sans JP',
                              letterSpacing: -2),
                        )),
                    Container(
                      margin: const EdgeInsets.only(top: 9.8, bottom: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/clock.png"),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: Text(
                              args.time.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Noto Sans CJK JP',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 18, right: 18),
                    child: FutureBuilder(
                      future: getTab(args.id),
                      builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Column(
                            children: [
                              Expanded(
                                child: Container(
                                  transformAlignment: Alignment.center,
                                  child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            childAspectRatio: 70 / 32),
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (ctx, index) => Container(
                                      margin: const EdgeInsets.only(
                                          top: 8, left: 4, right: 4),
                                      // padding: const EdgeInsets.all(10),
                                      height: 30,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color:
                                              Colors.white30.withOpacity(0.2)),
                                      child: Center(
                                        child: Text(
                                          snapshot.data[index].name,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontFamily: 'Noto Sans CJK JP'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    width: 354,
                    height: 114,
                    child: Text(
                      args.description,
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Noto Sans JP',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -2),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 37.2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 35,
                          width: 35,
                          child: CircleAvatar(
                            backgroundColor: Colors.white30.withOpacity(0.2),
                            foregroundColor: Colors.white,
                            child: IconButton(
                              onPressed: loaded
                                  ? () async {
                                      if (player.position.inSeconds >= 10) {
                                        await player.seek(Duration(
                                            seconds: player.position.inSeconds -
                                                10));
                                      } else {
                                        await player
                                            .seek(const Duration(seconds: 0));
                                      }
                                    }
                                  : null,
                              icon: const ImageIcon(
                                  AssetImage("assets/images/pre_15.png")),
                            ),
                          )),
                      Container(
                        height: 79,
                        width: 79,
                        margin: const EdgeInsets.only(left: 39, right: 39),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white30),
                        child: IconButton(
                            onPressed: loaded
                                ? () {
                                    if (playing) {
                                      pauseMusic();
                                    } else {
                                      playMusic();
                                    }
                                  }
                                : null,
                            icon: Icon(
                              playing ? Icons.pause : Icons.play_arrow,
                              color: Colors.white,
                              size: 30,
                            )),
                      ),
                      SizedBox(
                          height: 35,
                          width: 35,
                          child: CircleAvatar(
                            backgroundColor: Colors.white30.withOpacity(0.2),
                            foregroundColor: Colors.white,
                            child: IconButton(
                              onPressed: loaded
                                  ? () async {
                                      if (player.position.inSeconds + 10 <=
                                          player.duration!.inSeconds) {
                                        await player.seek(Duration(
                                            seconds: player.position.inSeconds +
                                                10));
                                      } else {
                                        await player
                                            .seek(const Duration(seconds: 0));
                                      }
                                    }
                                  : null,
                              icon: const ImageIcon(
                                  AssetImage("assets/images/next_15.png")),
                            ),
                          )),
                    ],
                  ),
                ),
                Padding(
                  // padding: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.only(top: 35.9),
                  child: StreamBuilder(
                      stream: player.positionStream,
                      builder: (context, snapshot1) {
                        final Duration duration;
                        if (loaded) {
                          if (snapshot1.data != null) {
                            duration = snapshot1.data as Duration;
                          } else {
                            duration = const Duration(seconds: 0);
                          }
                        } else {
                          duration = const Duration(seconds: 0);
                        }
                        return StreamBuilder(
                            stream: player.bufferedPositionStream,
                            builder: (context, snapshot2) {
                              final Duration bufferedDuration;
                              if (loaded) {
                                if (snapshot2.data != null) {
                                  bufferedDuration = snapshot2.data as Duration;
                                }else{
                                  bufferedDuration = const Duration(seconds: 0);
                                }
                              } else {
                                bufferedDuration = const Duration(seconds: 0);
                              }
                              return SizedBox(
                                height: 30,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: ProgressBar(
                                    progress: duration,
                                    total: player.duration ??
                                        const Duration(seconds: 0),
                                    buffered: bufferedDuration,
                                    timeLabelPadding: -1,
                                    timeLabelTextStyle: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.white,
                                        fontFamily: 'Jost'),
                                    progressBarColor: Colors.white,
                                    baseBarColor:
                                        Colors.white30.withOpacity(0.5),
                                    // bufferedBarColor: Colors.white30.withOpacity(0.2),
                                    thumbColor: Colors.white,
                                    onSeek: loaded
                                        ? (duration) async {
                                            await player.seek(duration);
                                          }
                                        : null,
                                  ),
                                ),
                              );
                            });
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 0, left: 121, right: 118, bottom: 28.2),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white30.withOpacity(0.2),
                            foregroundColor: Colors.red,
                            radius: 16,
                            child: IconButton(
                              onPressed: () {
                                addLike(args.id);
                              },
                              icon: const ImageIcon(
                                  AssetImage("assets/images/like.png")),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'お気に入り',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Noto Sans JP',
                                fontSize: 11,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white30.withOpacity(0.2),
                              foregroundColor: Colors.white,
                              radius: 16,
                              child: IconButton(
                                onPressed: () {},
                                icon: const ImageIcon(
                                    AssetImage("assets/images/share.png")),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              '共有',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Noto Sans JP',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 354,
                  height: 44,
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(138, 86, 172, 1),
                      borderRadius: BorderRadius.circular(5),
                      border: const Border(
                          bottom: BorderSide(
                              color: Color.fromRGBO(98, 59, 124, 1),
                              width: 3))),
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pushNamed(context, GivePage.routeName,
                          arguments: SendDatas(args.id, args.title, args.time,
                              args.description, args.filename));
                      // Navigator.pushNamed(context, GivePage.routeName,
                      // arguments: null);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageIcon(
                          AssetImage("assets/images/flower.png"),
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 26.2, right: 26.2),
                          child: Text(
                            'こちらのお寺にご志納をする',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Noto Sans CJK JP',
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -1),
                          ),
                        ),
                        ImageIcon(
                          AssetImage("assets/images/flower.png"),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
