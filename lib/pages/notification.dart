
import 'package:flutter/material.dart';


void main() {
  runApp(
    const NotificationApp()
  );
}

class NotificationApp extends StatefulWidget{
  const NotificationApp({super.key});
  static const routeName='/notification';


  @override
  State<NotificationApp> createState() => _NotificationAppState();
}

class _NotificationAppState extends State<NotificationApp> {
  bool light=true;  

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      
      home: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/settings_back.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            padding: const EdgeInsets.only(top: 63.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:13),
                      child:  IconButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed('/setting');
                        },
                        icon: const ImageIcon(
                          AssetImage("assets/images/before_arrow.png"),
                          color: Colors.white,
                        )
                      ) 
                    ),
                    const SizedBox(
                      width: 120,
                    ),  
                    const Text(
                        '通知',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Noto Sans CJK JP',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1
                          ),
                          softWrap: true,
                        )
                  ],
                ),
                const SizedBox(
                  height: 27.6,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 51,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white.withOpacity(0.2)
                          ),
                          margin: const EdgeInsets.only(left: 17.8, right: 17.8),
                          
                            child: Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left:13, right:13),
                                  child: ImageIcon(
                                    AssetImage("assets/images/notification.png"),
                                    color: Colors.white,
                                  ) 
                                ),   
                                const Expanded(
                                  child: Text(
                                    'アカウント情報を編集',
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
                                Container(
                                  margin: const EdgeInsets.only(right:13),
                                  width: 42.35,
                                  height: 23,
                                  child:  Switch(
                                    value: light, 
                                    activeColor: Colors.green,
                                    onChanged: (bool value){
                                      setState((){
                                        light=value;
                                      });
                                    }
                                    ) 
                                  ),    
                              ],
                            ),
                        ),
                        const SizedBox(
                          height: 14,
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
                                  Navigator.of(context).pushNamed('/home');
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
                                  
                                },
                                child: const Column(
                                  children: [
                                    Icon(
                                      Icons.settings_rounded,
                                      color: Colors.black,
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






