

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/english_pages/account_delete.dart';
import 'package:flutter_app/english_pages/account_edit.dart';
import 'package:flutter_app/english_pages/account_setting.dart';
import 'package:flutter_app/english_pages/audio_page.dart';
import 'package:flutter_app/english_pages/catetory_search.dart';
import 'package:flutter_app/english_pages/change_language.dart';
import 'package:flutter_app/english_pages/change_password.dart';
import 'package:flutter_app/english_pages/content_search.dart';
import 'package:flutter_app/english_pages/download_page.dart';
import 'package:flutter_app/english_pages/give_page.dart';
import 'package:flutter_app/english_pages/like_page.dart';
import 'package:flutter_app/english_pages/mypage.dart';
import 'package:flutter_app/english_pages/notification.dart';
import 'package:flutter_app/english_pages/play_page.dart';
import 'package:flutter_app/english_pages/search_page.dart';
import 'package:flutter_app/english_pages/settings_page.dart';
import 'package:flutter_app/english_pages/subscription_page.dart';
import 'package:flutter_app/english_pages/tab_search.dart';
import 'package:flutter_app/english_pages/video_page.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/pages/send_data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(const EnHomeApp());
}

class EnHomeApp extends StatefulWidget {
  const EnHomeApp({super.key});
  static const routeName='/en_home'; 

  @override
  State<EnHomeApp> createState() => _EnHomeAppState();
}

class _EnHomeAppState extends State<EnHomeApp> {

  @override
  void initState(){
    getLanguage();  
    super.initState();
  }
  void getLanguage() async{
    const storage = FlutterSecureStorage();
    String? language=await storage.read(key: 'language');
    if(language.toString()=="Japanese"){
      // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const HomeApp()));
      // ignore: use_build_context_synchronously
      // Navigator.of(context).pushNamed('/home');

    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        EnAudioPlayPage.routeName: (context) => const EnAudioPlayPage(),
        EnVideoPlayPage.routeName: (context) => const EnVideoPlayPage(),
        EnGivePage.routeName: (context) => const EnGivePage(),
        EnSearchApp.routeName: (context) => const EnSearchApp(),
        EnMyPageApp.routeName: (context) => const EnMyPageApp(),
        EnSettingsPageApp.routeName: (context) => const EnSettingsPageApp(),
        EnAccountSettingApp.routeName: (context) => const EnAccountSettingApp(),
        EnAccountEditApp.routeName: (context) => const EnAccountEditApp(),
        EnAccountDeleteApp.routeName: (context) => const EnAccountDeleteApp(),
        EnChangePasswordApp.routeName: (context) => const EnChangePasswordApp(),
        EnNotificationApp.routeName: (context) => const EnNotificationApp(),
        EnSubscriptionPage.routeName: (context) => const EnSubscriptionPage(),
        EnLikePageApp.routeName:(context) => const EnLikePageApp(),
        EnPlayPageApp.routeName:(context) => const EnPlayPageApp(), 
        EnDownloadPageApp.routeName:(context) => const EnDownloadPageApp(), 
        EnContentSearchPage.routeName:(context) => const EnContentSearchPage(),
        EnCategorySearchPage.routeName:(context) =>const EnCategorySearchPage(),    
        EnTabSearchPage.routeName:(context) =>const EnTabSearchPage(),    
        EnChangeLanguage.routeName:(context) =>const EnChangeLanguage(),    
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
            fontFamily: 'Lato'),
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
  final String time;
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
                child: Image.asset("assets/images/$imageUrl"),
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
                          fontFamily: 'Lato',
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
                          fontFamily: 'Lato',
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
                              time,
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Lato',
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
  final String time;
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
    String url="http://localhost:5000/api/items/";
    final response=await http.get(Uri.parse(url));
    var reasonData=json.decode(response.body);
    List<Data> items=[];
    for(var singleItem in reasonData){
      Data item=Data(id:singleItem["id"], title: singleItem["title"], type: singleItem["type"], time: singleItem["time"], main_image_url: singleItem["main_image_url"], description: singleItem["description"], filename: singleItem["filename"]);
      items.add(item);
    }
    return items;
  }
  
  Future<void> addPlays(int id) async{
    const storage=FlutterSecureStorage();
    String? email=await storage.read(key: 'email');
    String url="http://localhost:5000/api/items/play";
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
        const TitleSection(name: 'Today’s feature'),
        Expanded(
          child: Flexible(
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
                                  Navigator.pushNamed(context, EnAudioPlayPage.routeName,
                                      arguments: SendDatas(snapshot.data[index].id, snapshot.data[index].title, snapshot.data[index].time, snapshot.data[index].description, snapshot.data[index].filename));
                                }else{
                                  addPlays(snapshot.data[index].id);
                                  Navigator.pushNamed(context, EnVideoPlayPage.routeName,
                                      arguments: SendDatas(snapshot.data[index].id, snapshot.data[index].title, snapshot.data[index].time, snapshot.data[index].description, snapshot.data[index].filename));
                                }
                              },
                              child: DataListItem(title: snapshot.data[index].title, type: snapshot.data[index].type, time: snapshot.data[index].time, imageUrl: snapshot.data[index].main_image_url)
                              ));
                      }
                    },
                  ),
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
                            'Home',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Lato',
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1
                                ),
                          )
                        ]),
                      ),
                    ),
                    SizedBox(
                      width: 97.5,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/en_search');
                        },
                        child: const Column(children: [
                          Icon(
                            Icons.search,
                            color: Colors.black45,
                          ),
                          Text(
                            'Find',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Lato',
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1
                                ),
                          )
                        ]),
                      ),
                    ),
                    Expanded(
                        child: SizedBox(
                      width: 97.5,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/en_mypage');
                        },
                        child: const Column(children: [
                          ImageIcon(
                            AssetImage("assets/images/mypage.png"),
                            // color:Color.fromRGBO(196, 174, 216, 1),
                            color: Colors.black45,
                          ),
                          Text(
                            'My Page',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Lato',
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1
                                ),
                          )
                        ]),
                      ),
                    )),
                    SizedBox(
                      width: 97.5,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('/en_setting');
                        },
                        child: const Column(children: [
                          Icon(
                            Icons.settings_rounded,
                            color: Colors.black45,
                          ),
                          Text(
                            'Settings',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Lato',
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1
                                ),
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
