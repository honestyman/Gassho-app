

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/english_pages/home_page.dart';
import 'package:flutter_app/pages/account_delete.dart';
import 'package:flutter_app/pages/account_edit.dart';
import 'package:flutter_app/pages/account_setting.dart';
import 'package:flutter_app/pages/audio_page.dart';
import 'package:flutter_app/pages/catetory_search.dart';
import 'package:flutter_app/pages/change_language.dart';
import 'package:flutter_app/pages/change_password.dart';
import 'package:flutter_app/pages/content_search.dart';
import 'package:flutter_app/pages/download_page.dart';
import 'package:flutter_app/pages/give_page.dart';
import 'package:flutter_app/pages/like_page.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/mypage.dart';
import 'package:flutter_app/pages/notification.dart';
import 'package:flutter_app/pages/play_page.dart';
import 'package:flutter_app/pages/search_page.dart';
import 'package:flutter_app/pages/settings_page.dart';
import 'package:flutter_app/pages/subscription_page.dart';
import 'package:flutter_app/pages/tab_search.dart';
import 'package:flutter_app/pages/video_page.dart';
import 'package:flutter_app/pages/send_data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/pages/requesturl.dart' as requesturl;
import 'package:onesignal_flutter/onesignal_flutter.dart';


void main() async{
  
  runApp(const HomeApp());
}

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});
  static const routeName='/home'; 

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {

  @override
  void initState(){
    getState();
    // getUser();
    messageProcess();  
    super.initState();
  }
  Future<void> messageProcess() async{

    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
  // Extract notification data
      String title = result.notification.title.toString();
      // ignore: unused_local_variable
      String notificationId = result.notification.notificationId;

      // Additional custom data
      Map<String, dynamic> additionalData = result.notification.additionalData ?? {};

      final String japanese= additionalData['japanese'];
      // Handle the opened notification based on your requirements
      // For example, you can navigate to a specific screen or perform an action
      // using the extracted data from the notification
      if (additionalData.containsKey('screen')) {
        String screenName = additionalData['screen'];
        // Navigate to a specific screen
        // Example using the named routes approach:
        Navigator.pushNamed(context, screenName);
      } else {
        // Perform a default action
        // Example: Show an alert dialog with the notification details
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(title),
            content: Text(japanese),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      }
    });
}

  void getState() async{
    
    const storage = FlutterSecureStorage();
    String? language=await storage.read(key: 'language');
    String? token=await storage.read(key: 'jwt');
    if(language.toString()=="English"){
      // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const EnHomeApp()));
    }
    if(token == null){
      // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        AudioPlayPage.routeName: (context) => const AudioPlayPage(),
        VideoPlayPage.routeName: (context) => const VideoPlayPage(),
        GivePage.routeName: (context) => const GivePage(),
        SearchApp.routeName: (context) => const SearchApp(),
        MyPageApp.routeName: (context) => const MyPageApp(),
        SettingsPageApp.routeName: (context) => const SettingsPageApp(),
        AccountSettingApp.routeName: (context) => const AccountSettingApp(),
        AccountEditApp.routeName: (context) => const AccountEditApp(),
        AccountDeleteApp.routeName: (context) => const AccountDeleteApp(),
        ChangePasswordApp.routeName: (context) => const ChangePasswordApp(),
        NotificationApp.routeName: (context) => const NotificationApp(),
        SubscriptionPage.routeName: (context) => const SubscriptionPage(),
        LikePageApp.routeName:(context) => const LikePageApp(),
        PlayPageApp.routeName:(context) => const PlayPageApp(), 
        DownloadPageApp.routeName:(context) => const DownloadPageApp(), 
        ContentSearchPage.routeName:(context) => const ContentSearchPage(),
        CategorySearchPage.routeName:(context) =>const CategorySearchPage(),    
        TabSearchPage.routeName:(context) =>const TabSearchPage(),    
        ChangeLanguage.routeName:(context) =>const ChangeLanguage(),    
      },
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/main_back.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: DataList()
          ),  
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({
    super.key,
    required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 45, 0, 13),
      child: Text(
        name,
        textAlign: TextAlign.left,
        style: const TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.white,
            fontSize: 16,
            letterSpacing: -2,
            fontFamily: 'Noto Sans CJK JP'),
      ),
    );
  }
}


class DataListItem extends StatelessWidget {
  const DataListItem({
    super.key,
    required this.title,
    required this.type,
    required this.time,
    required this.imageUrl,
  });

  final String title;
  final String type;
  final int time;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
          width: 354,
          height: 113,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(0.3)),
          margin: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.all(6),
                width: 100,
                height: 100,
                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Image.network("${requesturl.Constants.url}/$imageUrl"),
              ),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(
                  left: 16,
                  top: 25.2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      type,
                      softWrap: true,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Color.fromRGBO(138, 86, 172, 1),
                          fontFamily: 'Noto Sans CJK JP',
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          letterSpacing: -1),
                    ),
                    Text(
                      title,
                      softWrap: true,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Noto Sans CJK JP',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          letterSpacing: -1),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Row(
                        children: [
                          Image.asset("assets/images/clock.png"),
                          Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: Text(
                             "$time分",
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
                    )
                  ],
                ),
              )),
              Container(
                margin: const EdgeInsets.only(
                    left: 12.3, top: 45.7, right: 12.3, bottom: 50.3),
                width: 17,
                height: 17,
                child: Image.asset("assets/images/play.png"),
              ),
            ],
          ),
        );
  }
}

class Data{
  const Data({required this.id, required this.title, required this.type, required this.time, required this.main_image_url, required this.description, required this.filename});
  final int id;
  final String title;
  final String type;
  final int time;
  final String main_image_url;
  final String description;
  final String filename;
}

class DataList extends StatefulWidget {
  const DataList({super.key});

  @override
  State<DataList> createState() => _DataListState();
}

class _DataListState extends State<DataList> {

  Future<List<Data>> getRequest() async {
    String url="${requesturl.Constants.url}/api/items/sort";
    final response=await http.get(Uri.parse(url));
    var reasonData=json.decode(response.body);
    List<Data> items=[];
    for(var singleItem in reasonData){
      Data item=Data(id:singleItem["id"], title: singleItem["japanesetitle"], type: singleItem["type"], time: singleItem["time"], main_image_url: singleItem["main_image_url"], description: singleItem["japanesedescription"], filename: singleItem["filename"]);
      items.add(item);
    }
    return items;
  }
  
  Future<void> addPlays(int id) async{
    const storage=FlutterSecureStorage();
    String? email=await storage.read(key: 'email');
    String url="${requesturl.Constants.url}/api/items/play";
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 45),
          child: const Center(
            child: ImageIcon(
              AssetImage("assets/images/mainicon.png"),
              color: Colors.black,
              size: 80,
            ),
          ),
        ),
        const TitleSection(name: '今日の瞑想'),
        Flexible(
                child: FutureBuilder(
                  future: getRequest(),
                  builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (ctx, index) => 
                          MaterialButton(
                            onPressed: () {
                              if(snapshot.data[index].type=='音声'){
                                addPlays(snapshot.data[index].id);
                                Navigator.pushNamed(context, AudioPlayPage.routeName,
                                    arguments: SendDatas(snapshot.data[index].id, snapshot.data[index].title, snapshot.data[index].time, snapshot.data[index].description, snapshot.data[index].filename));
                              }else{
                                addPlays(snapshot.data[index].id);
                                Navigator.pushNamed(context, VideoPlayPage.routeName,
                                    arguments: SendDatas(snapshot.data[index].id, snapshot.data[index].title, snapshot.data[index].time, snapshot.data[index].description, snapshot.data[index].filename));
                              }
                            },
                            child: DataListItem(title: snapshot.data[index].title, type: snapshot.data[index].type, time: snapshot.data[index].time, imageUrl: snapshot.data[index].main_image_url)
                            ));
                    }
                  },
                ),
                           
              ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 75,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 7.4, 0, 20.5),
                child: Row(
                  children: [
                    SizedBox(
                      width: 97.5,
                      child: MaterialButton(
                        onPressed: () {},
                        child: const Column(children: [
                          Icon(
                            Icons.home,
                            color: Colors.black,
                          ),
                          Text(
                            'ホーム',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Noto Sans CJK JP',
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          )
                        ]),
                      ),
                    ),
                    SizedBox(
                      width: 97.5,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/search');
                        },
                        child: const Column(children: [
                          Icon(
                            Icons.search,
                            color: Colors.black45,
                          ),
                          Text(
                            'さがす',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Noto Sans CJK JP',
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          )
                        ]),
                      ),
                    ),
                    Expanded(
                        child: SizedBox(
                      width: 97.5,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/mypage');
                        },
                        child: const Column(children: [
                          ImageIcon(
                            AssetImage("assets/images/mypage.png"),
                            // color:Color.fromRGBO(196, 174, 216, 1),
                            color: Colors.black45,
                          ),
                          Text(
                            'マイページ',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Noto Sans CJK JP',
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          )
                        ]),
                      ),
                    )),
                    SizedBox(
                      width: 97.5,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/setting');
                        },
                        child: const Column(children: [
                          Icon(
                            Icons.settings_rounded,
                            color: Colors.black45,
                          ),
                          Text(
                            '設定',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Noto Sans CJK JP',
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          )
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
