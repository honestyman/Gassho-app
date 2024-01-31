
import 'package:flutter/material.dart';


void main() {
  runApp(
    const MyPageApp()
  );
}

class MyPageApp extends StatefulWidget{
  const MyPageApp({super.key});
  static const routeName='/mypage';

  @override
  State<MyPageApp> createState() => _MyPageAppState();
}

class _MyPageAppState extends State<MyPageApp> {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/mypage_back.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              const TitleSection(name: 'マイページ'),
              const SizedBox(
                height: 27.6,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 51,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white.withOpacity(0.5)
                        ),
                        margin: const EdgeInsets.only(left: 17.8, right: 17.8),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/likepage');
                          },
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left:13, right:13),
                                child: ImageIcon(
                                  AssetImage("assets/images/like1.png"),
                                  color: Colors.white,
                                ) 
                              ),   
                              Expanded(
                                child: Text(
                                  'お気に入り',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Noto Sans CJK JP',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -1
                                  ),
                                  softWrap: true,
                                )
                                ),
                              Padding(
                                padding: EdgeInsets.only(right:13),
                                child:  ImageIcon(
                                  AssetImage("assets/images/arrow.png"),
                                  color: Colors.white,
                                ) 
                                ),    
                            ],
                          ),
                        ),  
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Container(
                        height: 51,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white.withOpacity(0.5)
                        ),
                        margin: const EdgeInsets.only(left: 17.8, right: 17.8),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/playpage');
                          },
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left:13, right:13),
                                child: ImageIcon(
                                  AssetImage("assets/images/play1.png"),
                                  color: Colors.white,
                                ) 
                              ),   
                              Expanded(
                                child: Text(
                                  '再生履歴',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Noto Sans CJK JP',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -1
                                  ),
                                  softWrap: true,
                                )
                                ),
                              Padding(
                                padding: EdgeInsets.only(right:13),
                                child:  ImageIcon(
                                  AssetImage("assets/images/arrow.png"),
                                  color: Colors.white,
                                ) 
                                ),    
                            ],
                          ),
                        ),  
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Container(
                        height: 51,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white.withOpacity(0.5)
                        ),
                        margin: const EdgeInsets.only(left: 17.8, right: 17.8),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/downloadpage');
                          },
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left:13, right:13),
                                child: ImageIcon(
                                  AssetImage("assets/images/download1.png"),
                                  color: Colors.white,
                                ) 
                              ),   
                              Expanded(
                                child: Text(
                                  'ダウンロード',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Noto Sans CJK JP',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -1
                                  ),
                                  softWrap: true,
                                )
                                ),
                              Padding(
                                padding: EdgeInsets.only(right:13),
                                child:  ImageIcon(
                                  AssetImage("assets/images/arrow.png"),
                                  color: Colors.white,
                                ) 
                                ),    
                            ],
                          ),
                        ),  
                      ),
                      
                    ],
                  ),
                ),
              ),
              
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height:75,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding:const EdgeInsets.fromLTRB(0, 7.4, 0, 20.5), 
                      child: Row(
                        children: [
                          SizedBox(
                            width: 97.5,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/');
                              },
                              child: const Column(
                                children: [
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
                                      fontWeight: FontWeight.w400
                                    ),
                                  )
                                ]
                                ),
                            ),
                          ),
                          SizedBox(
                            width: 97.5,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/search');
                              },
                              child: const Column(
                                children: [
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
                                      fontWeight: FontWeight.w400
                                    ),
                                  )
                                ]
                                ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              width: 97.5,
                              child: MaterialButton(
                              onPressed: () {
                                
                              },
                              child: const Column(
                                children: [
                                  ImageIcon(
                                    AssetImage("assets/images/mypage.png"),
                                    // color:Color.fromRGBO(196, 174, 216, 1),
                                    color: Colors.black,
                                  ),
                                  Text(
                                    'マイページ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Noto Sans CJK JP',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400
                                    ),
                                  )
                                ]
                                ),
                            ), 
                            )
                            ),
                          SizedBox(
                            width: 97.5,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/setting');
                              },
                              child: const Column(
                                children: [
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
                                      fontWeight: FontWeight.w400
                                    ),
                                  )
                                ]
                                ),
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

class TitleSection extends StatelessWidget{
  const TitleSection({
    super.key,
    required this.name,
  });
  final String name;

  @override
  Widget build(BuildContext context){
    return Container(
       padding: const EdgeInsets.only(top: 63.5),
       child: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 20,
          letterSpacing: -2,
          fontFamily: 'Noto Sans JP'
        ),
      ),
      );
  }
}






