
import 'package:flutter/material.dart';


void main() {
  runApp(
    const EnMyPageApp()
  );
}

class EnMyPageApp extends StatefulWidget{
  const EnMyPageApp({super.key});
  static const routeName='/en_mypage';

  @override
  State<EnMyPageApp> createState() => _EnMyPageAppState();
}

class _EnMyPageAppState extends State<EnMyPageApp> {
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
              
              const TitleSection(name: 'My Page'),
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
                            Navigator.of(context).pushNamed('/en_likepage');
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
                                  'Favorites',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Nato',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
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
                            Navigator.of(context).pushNamed('/en_playpage');
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
                                  'History',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Nato',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
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
                            Navigator.of(context).pushNamed('/en_downloadpage');
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
                                  'Downloads',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Nato',
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
                                    'Home',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Nato',
                                      fontSize: 10,
                                      letterSpacing: 1,
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
                                Navigator.of(context).pushNamed('/en_search');
                              },
                              child: const Column(
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: Colors.black45,
                                  ),
                                  Text(
                                    'Find',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Nato',
                                      fontSize: 10,
                                      letterSpacing: 1,
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
                                    'My Page',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Nato',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1
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
                                Navigator.of(context).pushNamed('/en_setting');
                              },
                              child: const Column(
                                children: [
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
          fontFamily: 'Nato'
        ),
      ),
      );
  }
}






