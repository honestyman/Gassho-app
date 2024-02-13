

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/pages/requesturl.dart' as requesturl;



void main() {
  runApp(
    const SettingsPageApp()
  );
}

class SettingsPageApp extends StatefulWidget{
  const SettingsPageApp({super.key});
  static const routeName='/setting';

  @override
  State<SettingsPageApp> createState() => _SettingsPageAppState();
}

class _SettingsPageAppState extends State<SettingsPageApp> {

  showAlertDialog(BuildContext context) async{
  const storage = FlutterSecureStorage();
  String? email=await storage.read(key: 'email');
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
                'ログアウトしますか？',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Noto Sans CJK JP',
                  fontSize:14 ,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:5),
              child: Text(
                email.toString(),
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Noto Sans CJK JP',
                  fontSize:14 ,
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
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
                        'キャンセル',
                        textAlign: TextAlign.center,
                         style: TextStyle(
                           color: Color.fromRGBO(95, 134, 222, 1),
                           fontWeight: FontWeight.bold
                         ),
                      )
                    ),
                  ),
                  Container(
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
                      onPressed: () async{
                        // Navigator.of(content).pop(false);
                        // Navigator.of(context, rootNavigator: true).pop(false);
                        storage.delete(key: 'jwt');
                        storage.delete(key: 'email');
                        String? token=await storage.read(key: 'jwt');
                        String? email=await storage.read(key: 'email');
                        if(token==null && email==null){
                        // ignore: use_build_context_synchronously
                         Navigator.of(context, rootNavigator: true).pop(false);
                        // ignore: use_build_context_synchronously
                         Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const HomeApp()));
                        //  exit(0);
                        }
                        // else{
                        //   storage.delete(key: 'jwt');
                        //   storage.delete(key: 'email');
                        //   // exit(0);
                        // }
                      },
                      child: const Text(
                        'ログアウト',
                        textAlign: TextAlign.center,
                         style: TextStyle(
                           color: Color.fromRGBO(95, 134, 222, 1),
                           fontWeight: FontWeight.bold
                         ),
                      )
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        )
      )
    );
  }

  accountDeleteDialog(BuildContext context) async{
  const storage = FlutterSecureStorage();
  String? email=await storage.read(key: 'email');
  // ignore: use_build_context_synchronously
  showDialog(
    context: context,
    builder: (_) => Center( // Aligns the container to center
      child: Container( // A simplified version of dialog. 
        width: 244,
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color.fromRGBO(43, 43, 55, 1),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top:20, left: 20, right: 20),
              child: Text(
                'アカウントを削除してもよろしいですか？',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Noto Sans CJK JP',
                  fontSize:14 ,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:10),
              child: Text(
                email.toString(),
                style: const TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Noto Sans CJK JP',
                  fontSize:14 ,
                ),
              ),
            ),
            Container(
              width: 244,
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container( 
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
                        DeleteOnly();
                      },
                      child: const Text(
                        '確認',
                        textAlign: TextAlign.center,
                         style: TextStyle(
                           color: Color.fromRGBO(95, 134, 222, 1),
                           fontWeight: FontWeight.bold
                         ),
                      )
                    ),
                  ),
                  Container(
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
                        Navigator.of(context, rootNavigator: true).pop(false);
                      },
                      child: const Text(
                        'キャンセル',
                        textAlign: TextAlign.center,
                         style: TextStyle(
                           color: Color.fromRGBO(95, 134, 222, 1),
                           fontWeight: FontWeight.bold
                         ),
                      )
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        )
      )
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> DeleteOnly() async {
    const storage = FlutterSecureStorage();
    String? email=await storage.read(key: 'email');
    String url="${requesturl.Constants.url}/api/users/onlydelete?email=$email";
    final response = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
      if (response.statusCode == 200) { 
        // ignore: use_build_context_synchronously
        storage.deleteAll();
        exit(0);
      } 
  }

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
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              
              const TitleSection(name: '設定'),
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
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/subscription');
                            
                          },
                          child: const Row(
                            children: [
                              SizedBox(
                                width: 13,
                              ),   
                              Expanded(
                                child: Text(
                                  'サブスクリプション',
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
                          color: Colors.white.withOpacity(0.2)
                        ),
                        margin: const EdgeInsets.only(left: 17.8, right: 17.8),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/account_setting');
                          },
                          child: const Row(
                            children: [
                              SizedBox(
                                width: 13,
                              ),   
                              Expanded(
                                child: Text(
                                  'アカウント',
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
                          color: Colors.white.withOpacity(0.2)
                        ),
                        margin: const EdgeInsets.only(left: 17.8, right: 17.8),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/change_password');
                          },
                          child: const Row(
                            children: [
                              SizedBox(
                                width: 13,
                              ),   
                              Expanded(
                                child: Text(
                                  'パスワード',
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
                          color: Colors.white.withOpacity(0.2)
                        ),
                        margin: const EdgeInsets.only(left: 17.8, right: 17.8),
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/notification');
                          },
                          child: const Row(
                            children: [
                              SizedBox(
                                width: 13,
                              ),   
                              Expanded(
                                child: Text(
                                  '通知',
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
                          color: Colors.white.withOpacity(0.2)
                        ),
                        margin: const EdgeInsets.only(left: 17.8, right: 17.8),
                        child: MaterialButton(
                          onPressed: () {
                             Navigator.of(context).pushNamed('/change_language');
                          },
                          child: const Row(
                            children: [
                              SizedBox(
                                width: 13,
                              ),   
                              Expanded(
                                child: Text(
                                  '言語',
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
                        height: 25,
                      ),
                      // ----------------------------------
                      Container(
                        padding: const EdgeInsets.only(top:25),
                        margin: const EdgeInsets.only(left: 17.8, right: 17.8),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: Colors.white.withOpacity(0.2),
                              width: 2
                            )
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 51,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white.withOpacity(0.2)
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  
                                },
                                child: const Row(
                                  children: [
                                    SizedBox(
                                      width: 13,
                                    ),   
                                    Expanded(
                                      child: Text(
                                        'ヘルプ＆サポート',
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
                                color: Colors.white.withOpacity(0.2)
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  
                                },
                                child: const Row(
                                  children: [
                                    SizedBox(
                                      width: 13,
                                    ),   
                                    Expanded(
                                      child: Text(
                                        '利用規約',
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
                                color: Colors.white.withOpacity(0.2)
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  
                                },
                                child: const Row(
                                  children: [
                                    SizedBox(
                                      width: 13,
                                    ),   
                                    Expanded(
                                      child: Text(
                                        'プライバシーポリシー',
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
                                color: Colors.white.withOpacity(0.2)
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  
                                },
                                child: const Row(
                                  children: [
                                    SizedBox(
                                      width: 13,
                                    ),   
                                    Expanded(
                                      child: Text(
                                        '特定商取引法ガイド',
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
                                color: Colors.white.withOpacity(0.2)
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  showAlertDialog(context);
                                },
                                child: const Row(
                                  children: [
                                    SizedBox(
                                      width: 13,
                                    ),   
                                    Expanded(
                                      child: Text(
                                        'ログアウト',
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
                      Padding(
                              padding: const EdgeInsets.only(top:10, left: 20, bottom: 10),
                              child: TextButton(
                                onPressed: (){
                                  accountDeleteDialog(context);
                                },
                                child: const Text( 
                                        '退会',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Noto Sans CJK JP',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.white,
                                          decorationThickness: 2,
                                          letterSpacing: -1
                                        ),
                                        softWrap: true,
                                      )
                              ),
                            )
          
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
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => const LoginPage()));
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




