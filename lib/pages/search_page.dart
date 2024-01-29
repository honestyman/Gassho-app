
import 'package:flutter/material.dart';


void main() {
  runApp(
    const SearchApp()
  );
}

class SearchApp extends StatefulWidget{
  const SearchApp({super.key});

  static const routeName='/search';

  @override
  State<SearchApp> createState() => _SearchAppState();
}

class _SearchAppState extends State<SearchApp> {
  @override
  Widget build(BuildContext context){
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
              const SizedBox(
                height: 44.8,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                padding: const EdgeInsets.only(bottom: 27),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white54
                    )
                  )
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 104,
                          height: 104,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              image: AssetImage("assets/images/1.png"),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              color: const Color.fromRGBO(227, 183, 255, 0.8),
                              width: 5
                            )
                          ),
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,          
                              ),
                              child: const Text(
                                '紹介',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Noto Sans CJK JP',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 104,
                          height: 104,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              image: AssetImage("assets/images/2.png"),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              color: const Color.fromRGBO(227, 183, 255, 0.8),
                              width: 5
                            )
                          ),
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,          
                              ),
                              child: const Text(
                                '瞑想',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Noto Sans CJK JP',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 104,
                          height: 104,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              image: AssetImage("assets/images/3.png"),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              color: const Color.fromRGBO(227, 183, 255, 0.8),
                              width: 5
                            )
                          ),
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,          
                              ),
                              child: const Text(
                                'リラックス\n＆睡眠',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Noto Sans CJK JP',
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -2
                                ),
                              ),
                            ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 14.2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 104,
                          height: 104,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              image: AssetImage("assets/images/4.png"),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              color: const Color.fromRGBO(227, 183, 255, 0.8),
                              width: 5
                            )
                          ),
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,          
                              ),
                              child: const Text(
                                '智慧',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Noto Sans CJK JP',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 104,
                          height: 104,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              image: AssetImage("assets/images/5.png"),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              color: const Color.fromRGBO(227, 183, 255, 0.8),
                              width: 5
                            )
                          ),
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,          
                              ),
                              child: const Text(
                                'ご利益',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Noto Sans CJK JP',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          width: 104,
                          height: 104,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              image: AssetImage("assets/images/6.png"),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              color: const Color.fromRGBO(227, 183, 255, 0.8),
                              width: 5
                            )
                          ),
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,          
                              ),
                              child: const Text(
                                '雑談',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Noto Sans CJK JP',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top:25),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                            width: 70,
                            height: 32,
                            margin: const EdgeInsets.only(left: 5, right: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white30.withOpacity(0.2)
                            ),
                            child:  Center(
                              child: TextButton(
                                onPressed: () {
                                  
                                },
                                child: const Text(
                                    '#タグ01',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Noto Sans CJK JP'
                                    ),
                                  ),
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
                                
                              },
                              child: const Column(
                                children: [
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
                                Navigator.of(context).pushNamed('/mypage');
                              },
                              child: const Column(
                                children: [
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






