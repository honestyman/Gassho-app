
import 'package:flutter/material.dart';


void main() {
  runApp(
    const ChangePasswordApp()
  );
}

class ChangePasswordApp extends StatefulWidget{
  const ChangePasswordApp({super.key});
  static const routeName='/change_password';


  @override
  State<ChangePasswordApp> createState() => _ChangePasswordAppState();
}

class _ChangePasswordAppState extends State<ChangePasswordApp> {

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
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
                          Navigator.of(context).pushNamed('/setting');
                        },
                        icon: const ImageIcon(
                          AssetImage("assets/images/before_arrow.png"),
                          color: Colors.white,
                        )
                      ) 
                    ),  
                    const SizedBox(
                      width: 62.5,
                    ),
                    const Text(
                        'パスワードの変更',
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(top: 92.5, bottom: 84.7),
                            child: const Center(
                                child: ImageIcon(
                                      AssetImage("assets/images/mainicon.png"),
                                      color: Colors.white,
                                      size: 80,
                                ),
                              ),
                          ),
                        Form(
                            key: formKey,
                            child:  Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                      Container(
                                          margin: const EdgeInsets.only(
                                            left: 0,
                                            top: 0,
                                            bottom: 9,
                                            right: 0,
                                          ),
                                          child: const Text(
                                            '現在のパスワード',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Noto Sans CJK JP',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: -1
                                            ),
                                          ),
                                        ),
                                        TextFormField(
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            filled: true,
                                            fillColor: Colors.white,
                                            // floatingLabelBehavior: FloatingLabelBehavior.always,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(color: Colors.white),
                                              borderRadius: BorderRadius.circular(5),
                                              
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(color: Colors.white),
                                              borderRadius: BorderRadius.circular(5)
                                            )
                                          ),
                                        ),
                                    ],) 
                                    
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20,0,20,0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                            left: 0,
                                            top: 16,
                                            bottom: 9,
                                            right: 0,
                                          ),
                                          child: const Text(
                                            '新しいパスワード',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Noto Sans CJK JP',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: -1
                                            ),
                                          ),
                                        ),
                                        TextFormField(
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            filled: true,
                                            fillColor: Colors.white,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(color: Colors.white),
                                              borderRadius: BorderRadius.circular(5),
                                              
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(color: Colors.white),
                                              borderRadius: BorderRadius.circular(5)
                                            )
                                          ),
                                        ),
                                    ],) 
                                  ),
                                  Container(
                                    width: 354,
                                    height: 47,
                                    margin: const EdgeInsets.only(
                                      left: 20,
                                      top: 31,
                                      bottom: 40,
                                      right: 20,
                                    ),
                                    child: ElevatedButton(
                                      onPressed:() {
                                        showAlertDialog(context);
                                      },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(138, 86, 172, 1),
                                    ),
                                    child: const Text(
                                        '更新',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Noto Sans JP',
                                          letterSpacing: -1
                                        ),
                                      )
                                      ),
                                  ), 
                                ],
                            )
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

showAlertDialog(BuildContext context){
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
              padding: EdgeInsets.only(top:20),
              child: Text(
                'パスワードを変更しますか？',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Noto Sans CJK JP',
                  fontSize:14 ,
                  letterSpacing: -1
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
                        Navigator.of(context).pushNamed('/account_setting');
                        // showAlertDialog_2(context);
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
                        Navigator.of(context, rootNavigator: true).pop(false);
                      },
                      child: const Text(
                        'CANCEL',
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






