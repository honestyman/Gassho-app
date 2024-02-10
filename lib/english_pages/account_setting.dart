import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(
    const EnAccountSettingApp()
  );
}

class EnAccountSettingApp extends StatefulWidget{
  const EnAccountSettingApp({super.key});
  static const routeName='/en_account_setting';

  @override
  State<EnAccountSettingApp> createState() => _EnAccountSettingAppState();
}

class _EnAccountSettingAppState extends State<EnAccountSettingApp> {

  // ignore: non_constant_identifier_names
  showAlertDialog(BuildContext context) async{
  // ignore: use_build_context_synchronously
  showDialog(
    context: context,
    builder: (_) => Center( // Aligns the container to center
      child: Container( // A simplified version of dialog. 
        width: 244,
        height: 111,
        padding: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color.fromRGBO(43, 43, 55, 1),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top:20, left: 20, right: 20),
              child: Text(
                'Are you sure you want to delete your account?',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nato',
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
                        deleteAccount();
                        exit(0);                            // showAlertDialog_2(context);
                      },
                      child: const Text(
                        'OK',
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
                      onPressed: (){
                        // Navigator.of(content).pop(false);
                        // Navigator.of(context, rootNavigator: true).pop(false);
                        Navigator.of(context, rootNavigator: true).pop(false);
                      },
                      child: const Text(
                        'Cancel',
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

  Future<void> deleteAccount() async {
    const storage = FlutterSecureStorage();
    String? email=await storage.read(key: 'email');
    String url="http://localhost:5000/api/users/delete?email=$email";
    final response = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
      if (response.statusCode == 200) { 
        // ignore: use_build_context_synchronously
        storage.deleteAll();
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
          body: Container(
            padding: const EdgeInsets.only(top: 63.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:13),
                      child:  IconButton(
                        onPressed: (){
                          Navigator.of(context).pushNamed('/en_setting');
                        },
                        icon: const ImageIcon(
                          AssetImage("assets/images/before_arrow.png"),
                          color: Colors.white,
                        )
                      ) 
                    ),
                    const Expanded(
                      child: Text(
                          'Account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Nato',
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                            ),
                            softWrap: true,
                          ),
                    ),
                    const SizedBox(
                      width: 50,
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
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/en_account_edit');
                            },
                            child: const Row(
                              children: [
                                SizedBox(
                                  width: 13,
                                ),   
                                Expanded(
                                  child: Text(
                                    'Edit account information',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Nato',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400
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
                              //  Navigator.of(context).pushNamed('/en_account_delete');
                              showAlertDialog(context);
                            },
                            child: const Row(
                              children: [
                                SizedBox(
                                  width: 13,
                                ),   
                                Expanded(
                                  child: Text(
                                    'Delete account',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Nato',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400
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
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1
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
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1
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
                                  Navigator.of(context).pushNamed('/en_mypage');
                                },
                                child: const Column(
                                  children: [
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
                                      color: Colors.black,
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
          fontFamily: 'Nato'
        ),
      ),
      );
  }
}






