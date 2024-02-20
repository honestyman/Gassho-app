import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/send_data.dart';
import 'package:flutter_app/pages/give_page.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pod_player/pod_player.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/pages/requesturl.dart' as requesturl;


void main() async{
  runApp(
    const MaterialApp(
      home: VideoPlayPage(),
    ),
  );
}
class Item{
  const Item({required this.name});
  final String name;
}

class VideoPlayPage extends StatefulWidget{
  const VideoPlayPage({super.key});

  static const routeName='/video';

  @override
  State<VideoPlayPage> createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  
  late final String fileUrl;
  late final String fileName;
  late final PodPlayerController controller;
  
  bool loaded=false;

  @override
  void initState() {
     loadVideo();
    super.initState();
    
  }
   void loadVideo() async{
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final file = ModalRoute.of(context)?.settings.arguments as SendDatas;  
      fileUrl="https://vimeo.com/${file.filename}";
      fileName=file.filename; 
    });
    setState(() {
      loaded = true;
    });
  }
 
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _playView(){
     final file=ModalRoute.of(context)?.settings.arguments as SendDatas;
     controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.vimeo(file.filename),
     )..initialise();
    return PodVideoPlayer(controller: controller);
  }

  Future<List<Item>> getTab(int id) async{
    String url = "${requesturl.Constants.url}/api/items/tab?id=$id";
    final response=await http.get(Uri.parse(url));
    var reasonData=json.decode(response.body);
    List<Item> tabs=[];
    for(var singleTab in reasonData){
      Item tab=Item(name: singleTab["name"]);
      tabs.add(tab);
    }
    return tabs;
  }

  Future<void> addLike(int id) async{
    const storage=FlutterSecureStorage();
    String? email=await storage.read(key: 'email');
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
    if(response.statusCode==200){
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (_) => Center( // Aligns the container to center
            child: Container( // A simplified version of dialog. 
              width: 244,
              height: 111,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color.fromRGBO(43, 43, 55, 1),
              ),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top:15),
                    child: Text(
                      'お気に入りに登録しました!',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Noto Sans CJK JP',
                        fontSize:14 ,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 15),
                      decoration: const BoxDecoration(
                        border:Border(
                          top: BorderSide(
                            color: Colors.white30,
                            width: 0.5
                          )
                        )
                      ),
                      child: TextButton(
                        onPressed: (){
                          // Navigator.of(content).pop(false);
                          Navigator.of(context, rootNavigator: true).pop(false);
                        },
                        child: const Text(
                          'OK',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromRGBO(95, 134, 222, 1),
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ),
                    ),
                  )
                ],
              ),
              )
            )
      );
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

  Future<void> addDownload(int id) async{
    const storage=FlutterSecureStorage();
    String? email=await storage.read(key: 'email');
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
  Widget build(BuildContext context){

    final args=ModalRoute.of(context)!.settings.arguments as SendDatas;

    return MaterialApp(
      
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/video_back.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
                  children: [
                    Container(
                      height: 40,
                      margin: const EdgeInsets.only(
                        left: 18,
                        right: 18,
                        top: 62
                      ),
                      child: Row(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                              child: CircleAvatar(
                                backgroundColor: const Color.fromRGBO(138, 86, 172, 0.5),
                                foregroundColor: Colors.white,
                                child: IconButton(
                                  onPressed: (){
                                    Navigator.pop(context,true);
                                  },
                                   icon: const ImageIcon(
                                    AssetImage("assets/images/cancel.png")
                                   ),
                                  ),
                              )
                            ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.topRight,
                              child: CircleAvatar(
                                backgroundColor: Colors.white30.withOpacity(0.2),
                                foregroundColor: Colors.white,
                                child: IconButton(
                                  onPressed: (){
                                    addDownload(args.id);
                                    _startDownload();
                                  },
                                   icon: const ImageIcon(
                                    AssetImage("assets/images/download.png")
                                   ),
                                  ),
                              )
                            ),
                          )
                        ],
                      ),
                    ),
                    // const SizedBox(
                    //   height: 18,
                    // ),
                    Container(
                      margin: const EdgeInsets.only(top:18),
                      height: 250,
                      child: _playView(),
                    ),
      
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Container(
                          padding: const EdgeInsets.only(top: 24.2),
                          child: Text(
                                args.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 24 ,
                                  fontFamily: 'Noto Sans JP',
                                  letterSpacing: -2
                                ),
                          )
                        ),
                        Container(
                            margin: const EdgeInsets.only(top:9.8),
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
                      padding: const EdgeInsets.only(top:10, left: 18, right: 18),
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
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        childAspectRatio: 70/32
                                        ),
                                      itemCount: snapshot.data.length,
                                      
                                      itemBuilder: (ctx, index) =>
                                       Container(
                                          margin: const EdgeInsets.only(left: 4, right: 4),
                                          // padding: const EdgeInsets.all(10),
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: Colors.white30.withOpacity(0.2)
                                          ), 
                                            child: Center(
                                              child: Text(
                                                snapshot.data[index].name,  
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontFamily: 'Noto Sans CJK JP'
                                                ),
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
                            letterSpacing: -2
                          ),
                        ),
                      ),
                    ),
                    
                  const SizedBox( 
                    height: 35, 
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 0, left: 121, right: 118, bottom: 28.2),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                                  backgroundColor: Colors.white30.withOpacity(0.2),
                                  foregroundColor: Colors.red,
                                  radius: 16,
                                  child: IconButton(
                                    onPressed: (){
                                      addLike(args.id);
                                    },
                                    icon: const ImageIcon(
                                      AssetImage("assets/images/like.png")
                                    ),
                                  ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'お気に入り',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Noto Sans JP',
                                fontSize: 11,
                                fontWeight: FontWeight.w400
                              ),
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
                                      onPressed: (){
                                        
                                      },
                                      icon: const ImageIcon(
                                        AssetImage("assets/images/share.png")
                                      ),
                                    ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                '共有',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Noto Sans JP',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400
                                ),
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
                  decoration:BoxDecoration(
                    color: const Color.fromRGBO(138, 86, 172, 1),
                    borderRadius: BorderRadius.circular(5),
                    border: const Border(
                      bottom: BorderSide(
                        color: Color.fromRGBO(98, 59, 124, 1),
                        width: 3 
                      )
                    )
                  ),
                  child: MaterialButton(
                    onPressed: (){
                      Navigator.pushNamed(context, GivePage.routeName,
                                      arguments: SendDatas(args.id, args.title, args.time, args.description, args.filename));
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
                              letterSpacing: -1
                            ),
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
    );
  }
}

