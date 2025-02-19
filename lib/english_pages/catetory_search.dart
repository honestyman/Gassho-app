import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gassho/english_pages/audio_page.dart';
import 'package:gassho/english_pages/send_searchiddata.dart';
import 'package:gassho/english_pages/video_page.dart';
import 'package:gassho/pages/send_data.dart';
import 'package:http/http.dart' as http;
import 'package:gassho/pages/requesturl.dart' as requesturl;

void main() {
  runApp(const EnCategorySearchPage());
}

class EnCategorySearchPage extends StatefulWidget {
  const EnCategorySearchPage({super.key});
  static const routeName = '/category_search';

  @override
  State<EnCategorySearchPage> createState() => _EnCategorySearchPageState();
}

class _EnCategorySearchPageState extends State<EnCategorySearchPage> {
  Future<List<Data>> getRequest(int id) async {
    String url = "${requesturl.Constants.url}/api/items/category_search?id=$id";
    final response = await http.get(Uri.parse(url));
    var reasonData = json.decode(response.body);
    List<Data> items = [];
    for (var singleItem in reasonData) {
      Data item = Data(
          id: singleItem["id"],
          title: singleItem["englishtitle"],
          type: singleItem["type"],
          time: singleItem["time"],
          main_image_url: singleItem["main_image_url"],
          description: singleItem["englishdescription"],
          filename: singleItem["filename"]);
      items.add(item);
    }
    return items;
  }

  // final formKey = GlobalKey<FormState>();
  // final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as EnSendSearchIdDatas;
    return MaterialApp(
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/search_child.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            padding: const EdgeInsets.only(top: 63.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            icon: const ImageIcon(
                              AssetImage("assets/images/before_arrow.png"),
                              color: Colors.white,
                            ))),
                    // const SizedBox(
                    //   width: 100,
                    // ),
                    Expanded(child: TitleSection(name: args.title)),
                    const SizedBox(
                      width: 50,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24.5,
                ),
                Flexible(
                  child: FutureBuilder(
                    future: getRequest(args.id),
                    builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (ctx, index) => MaterialButton(
                                onPressed: () {
                                  if (snapshot.data[index].type == '音声') {
                                    Navigator.pushNamed(
                                        context, EnAudioPlayPage.routeName,
                                        arguments: SendDatas(
                                            snapshot.data[index].id,
                                            snapshot.data[index].title,
                                            snapshot.data[index].time,
                                            snapshot.data[index].description,
                                            snapshot.data[index].filename));
                                  } else {
                                    Navigator.pushNamed(
                                        context, EnVideoPlayPage.routeName,
                                        arguments: SendDatas(
                                            snapshot.data[index].id,
                                            snapshot.data[index].title,
                                            snapshot.data[index].time,
                                            snapshot.data[index].description,
                                            snapshot.data[index].filename));
                                  }
                                },
                                child: DataListItem(
                                    title: snapshot.data[index].title,
                                    type: snapshot.data[index].type,
                                    time: snapshot.data[index].time,
                                    imageUrl: snapshot
                                        .data[index].main_image_url)));
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
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/');
                                },
                                child: const Column(children: [
                                  Icon(
                                    Icons.home,
                                    color: Colors.black45,
                                  ),
                                  Text(
                                    'Home',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Nato',
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
                                    color: Colors.black,
                                  ),
                                  Text(
                                    'Find',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Nato',
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
                                        fontFamily: 'Nato',
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
                                        fontFamily: 'Nato',
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
            ),
          ),
        ),
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
                      fontFamily: 'Nato',
                      fontWeight: FontWeight.w400,
                      fontSize: 12
                      ),
                ),
                Text(
                  title,
                  softWrap: true,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Nato',
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Row(
                    children: [
                      Image.asset("assets/images/clock.png"),
                      Container(
                        margin: const EdgeInsets.only(left: 5),
                        child: Text(
                          "${time}minutes",
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

class Data {
  const Data(
      {required this.id,
      required this.title,
      required this.type,
      required this.time,
      // ignore: non_constant_identifier_names
      required this.main_image_url,
      required this.description,
      required this.filename});
  final int id;
  final String title;
  final String type;
  final int time;
  // ignore: non_constant_identifier_names
  final String main_image_url;
  final String description;
  final String filename;
}

class TitleSection extends StatelessWidget {
  const TitleSection({
    super.key,
    required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      '「$name」',
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Nato'),
    );
  }
}
