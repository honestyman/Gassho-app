import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/english_pages/give_page.dart';
import 'package:flutter_app/pages/send_data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    const MaterialApp(
      home: EnVideoPlayPage(),
    ),
  );
}
class Item{
  const Item({required this.name});
  final String name;
}

class EnVideoPlayPage extends StatefulWidget{
  const EnVideoPlayPage({super.key});

  static const routeName='/video';

  @override
  State<EnVideoPlayPage> createState() => _EnVideoPlayPageState();
}

class _EnVideoPlayPageState extends State<EnVideoPlayPage> {
  
  late VideoPlayerController videoPlayerController;
  // videoPlayerController=VideoPlayerController.asset(dataSource)
  
  late ChewieController chewieController;
  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var file_name;

  bool loaded=false;

  // @override
  // void initState() {
  //    super.initState();
  // }

 
  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
 
    super.dispose();
  }

  Widget _playView(){
     final file=ModalRoute.of(context)?.settings.arguments as SendDatas;
     videoPlayerController = VideoPlayerController.asset("assets/video/${file.filename}");

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: false,
      looping: true,
      // Try playing around with some of these other options:
      showControls: true,
      materialProgressColors: ChewieProgressColors(
        playedColor:  Colors.blue,
        // handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.white30,
      ),
      placeholder: Container(
        color: Colors.black,
      ),
    );
    chewieController.play();
    return Chewie(controller: chewieController);
  }

  Future<List<Item>> getTab(int id) async{
    
    String url="http://localhost:5000/api/items/tab?id=$id";
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
    String url="http://localhost:5000/api/items/like";
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
                      'I registered as a favorite!',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nato',
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

  Future<void> addDownload(int id) async{
    const storage=FlutterSecureStorage();
    String? email=await storage.read(key: 'email');
    String url="http://localhost:5000/api/items/download";
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
                  Container(
                    margin: const EdgeInsets.only(top:18),
                    height: 220,
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
                                  fontFamily: 'Nato',
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
                                      args.time,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Nato',
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
                                                  fontFamily: 'Nato'
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
                            fontFamily: 'Nato',
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
                              'Favorite',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Nato',
                                fontSize: 12,
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
                                'Share',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Nato',
                                  fontSize: 12,
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
                      Navigator.pushNamed(context, EnGivePage.routeName,
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
                            'Make a donation to this temple',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Nato',
                              fontSize: 13,
                              fontWeight: FontWeight.w400
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

