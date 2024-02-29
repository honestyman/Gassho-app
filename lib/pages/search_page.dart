// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gassho/pages/content_search.dart';
import 'package:gassho/pages/catetory_search.dart';
import 'package:gassho/pages/send_searchdata.dart';
import 'package:gassho/pages/tab_search.dart';
import 'package:http/http.dart' as http;
import 'package:gassho/pages/requesturl.dart' as requesturl;

import 'send_searchiddata.dart';

void main() {
  runApp(const SearchApp());
}

class SearchApp extends StatefulWidget {
  const SearchApp({super.key});

  static const routeName = '/search';

  @override
  State<SearchApp> createState() => _SearchAppState();
}

class _SearchAppState extends State<SearchApp> {

  TextEditingController searchController = TextEditingController();


  Future<List<TabItem>> getAllTab() async{
    
    String url="${requesturl.Constants.url}/api/items/getalltab";
    final response=await http.get(Uri.parse(url));
    var reasonData=json.decode(response.body);
    List<TabItem> tabs=[];
    for(var singleTab in reasonData){
      TabItem tab=TabItem(id:singleTab["id"], name: singleTab["name"]);
      tabs.add(tab);
    }
    return tabs;
  }

  Future<List<CategoryItem>> getAllCategory() async{
    
    String url="${requesturl.Constants.url}/api/items/getallcategory";
    final response=await http.get(Uri.parse(url));
    var reasonData=json.decode(response.body);
    List<CategoryItem> categorys=[];
    for(var singleCategory in reasonData){
      CategoryItem category=CategoryItem(id:singleCategory["id"], name: singleCategory["name"], image_name: singleCategory['image_name']);
      categorys.add(category);
    }
    return categorys;
  }

  void sendContent(){
    //  Navigator.of(context).pushNamed('/content_search');
     Navigator.pushNamed(context, ContentSearchPage.routeName,
                arguments: SendSearchDatas(searchController.text));
  }
  void sendSearchCateoryId(int id, String title){
    Navigator.pushNamed(context, CategorySearchPage.routeName,
                arguments: SendSearchIdDatas(id, title));
  }
  void sendSearchTabId(int id, String title){
    Navigator.pushNamed(context, TabSearchPage.routeName,
                arguments: SendSearchIdDatas(id, title));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/search_back.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TitleSection(name: 'さがす'),
              // const Icon(
              //   Icons.settings_rounded,
              //   color: Colors.black45,
              // ),
              Container(
                height: 34,
                margin: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5)
                    )
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.search,
                        color: Colors.black45,
                      ),
                    ),
                   Expanded(
                     child: Padding(
                       padding: const EdgeInsets.only(top:2, right:8.0, bottom: 2),
                       child: TextFormField(
                                    controller: searchController,
                                    onEditingComplete:() {
                                      sendContent();
                                    },
                                    // onChanged: (value) {
                                    //   Navigator.of(context).pushNamed('/likepage');
                                    // },
                                    decoration: const InputDecoration(
                                        isDense: true,
                                        filled: true,
                                        fillColor: Colors.white,
                                        // floatingLabelBehavior: FloatingLabelBehavior.always,
                                        focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        )),
                                  ),
                     ),
                   ),
                  ]),
                 
              ),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.white54))),
                  child: FutureBuilder(
                    future: getAllCategory(),
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
                                    crossAxisCount: 3,
                                    childAspectRatio: 114/114
                                    ),
                                  itemCount: snapshot.data.length,
                                  
                                  itemBuilder: (ctx, index) =>
                                    Container(
                                      width: 114,
                                      height: 114,
                                      margin: const EdgeInsets.only(top:4, left: 2, right: 2),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage("assets/images/${snapshot.data[index].image_name}"),
                                          fit: BoxFit.cover,
                                        ),
                                        border: Border.all(
                                          color: const Color.fromRGBO(227, 183, 255, 0.8),
                                          width: 5
                                        )
                                      ),
                                      child: ElevatedButton(
                                          onPressed: () {
                                            sendSearchCateoryId(snapshot.data[index].id, snapshot.data[index].name);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                          ),
                                          child: Text(
                                            snapshot.data[index].name,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Noto Sans CJK JP',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                    ),
                                    ) 
                              ),
                            ),
                          ],
                        ); 
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top:10, left: 18, right: 18),
                      child: FutureBuilder(
                        future: getAllTab(),
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
                                              child: TextButton(
                                                onPressed: () {
                                                   sendSearchTabId(snapshot.data[index].id, snapshot.data[index].name);
                                                },
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
                                        ) 
                                  ),
                                ),
                              ],
                            ); 
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
                              onPressed: () {
                                Navigator.of(context).pushNamed('/');
                              },
                              child: const Column(children: [
                                Icon(
                                  Icons.home,
                                  color: Colors.black45,
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
                              onPressed: () {},
                              child: const Column(children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.black,
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
          ),
        ),
      ),
    );
  }
}

class TabItem{
  const TabItem({required this.id, required this.name});
  final int id;
  final String name;
}
class CategoryItem{
  const CategoryItem({required this.id, required this.name, required this.image_name});
  final int id;
  final String name;
  final String image_name;
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
      padding: const EdgeInsets.only(top: 63.5),
      child: Text(
        name,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
            letterSpacing: -2,
            fontFamily: 'Noto Sans JP'),
      ),
    );
  }
}
