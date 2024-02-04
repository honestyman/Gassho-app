
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


void main() {
  runApp(
    const EnNotificationApp()
  );
}

class EnNotificationApp extends StatefulWidget{
  const EnNotificationApp({super.key});
  static const routeName='/en_notification';

  @override
  State<EnNotificationApp> createState() => _EnNotificationAppState();
}

class _EnNotificationAppState extends State<EnNotificationApp> {
  
  bool light=true;  
  
  @override 
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
    //     final args=ModalRoute.of(context)?.settings.arguments as SendNotification;
    //     light=args.noti;        
    // }); 
    super.initState();
    getNotification(); 
  }
  
  
 Future<void> setNotifiaction() async {
    // String url="http://localhost:5000/api/users/notification";
    const storage = FlutterSecureStorage();
    await storage.write(key: 'notification', value: light.toString());
    // ignore: unused_local_variable
    // final response = await http.post(
    //     Uri.parse(url),
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //     body: jsonEncode(<String, String>{
    //       'email':email.toString(),
    //       'notification':light.toString(),
    //     }),
    //   );
  }
  Future<void> getNotification() async {
    const storage = FlutterSecureStorage();
    var noti= await storage.read(key: 'notification');
    setState(() {
      if(noti.toString()=="true"){
        light = true;
      }else{
        light = false;
      }  
    });
    
    
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
              mainAxisAlignment: MainAxisAlignment.center,
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
                          'Notifications',
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
                    ),
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
                                    'Updates',
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
                                        setNotifiaction();
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






