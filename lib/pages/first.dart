

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/account_delete.dart';
import 'package:flutter_app/pages/account_edit.dart';
import 'package:flutter_app/pages/account_setting.dart';
import 'package:flutter_app/pages/audio_page.dart';
import 'package:flutter_app/pages/change_password.dart';
import 'package:flutter_app/pages/give_page.dart';
import 'package:flutter_app/pages/mypage.dart';
import 'package:flutter_app/pages/notification.dart';
import 'package:flutter_app/pages/search_page.dart';
import 'package:flutter_app/pages/settings_page.dart';
import 'package:flutter_app/pages/subscription_page.dart';
import 'package:flutter_app/pages/video_page.dart';
import 'package:flutter_app/pages/send_data.dart';

void main() {
  runApp(const HomeApp());
}

class HomeApp extends StatelessWidget {
  const HomeApp({super.key});

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
          body: DataList(
            datas: [
              Data(
                  name: 'こころをととのえる',
                  type: '動画',
                  time: '10分',
                  picture: 'main1.png'),
              Data(
                  name: '深い集中力', type: '音声', time: '10分', picture: 'main2.png'),
            ],
          )
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

class Data {
  const Data(
      {required this.name,
      required this.type,
      required this.time,
      required this.picture});

  final String name;
  final String type;
  final String time;
  final String picture;
}

typedef CartChangedCallback = Function(Data data, bool inChecked);

class DataListItem extends StatelessWidget {
  const DataListItem({
    super.key,
    required this.data,
  });

  final Data data;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: () {
          if (data.type == '音声') {
            // Navigator.pushNamed(context, AudioPlayPage.routeName,
            //     arguments: SendDatas(data.name, data.time));
            // Navigator.of(context).pushNamed('/audio');
          } else {
            // Navigator.pushNamed(context, VideoPlayPage.routeName,
            //     arguments: SendDatas(data.name, data.time));
          }
        },
        child: Container(
          width: 354,
          height: 113,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(0.3)),
          margin: const EdgeInsets.only(
            left: 18,
            top: 0,
            bottom: 8,
            right: 18,
          ),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.all(6),
                width: 100,
                height: 100,
                child: Image.asset("assets/images/${data.picture}"),
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
                      data.type,
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
                      data.name,
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
                              data.time,
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
        ));
  }
}

class DataList extends StatefulWidget {
  const DataList({required this.datas, super.key});

  final List<Data> datas;

  // The framework calls createState the first time
  // a widget appears at a given location in the tree.
  // If the parent rebuilds and uses the same type of
  // widget (with the same key), the framework re-uses
  // the State object instead of creating a new State object.

  @override
  State<DataList> createState() => _DataListState();
}

class _DataListState extends State<DataList> {
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
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: widget.datas.map((data) {
                return DataListItem(
                  data: data,
                );
              }).toList(),
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
