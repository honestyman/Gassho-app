
import 'package:flutter/material.dart';


void main() {
  runApp(
    const EnAccountDeleteApp()
  );
}

class EnAccountDeleteApp extends StatefulWidget{
  const EnAccountDeleteApp({super.key});
  static const routeName='/en_account_delete';

  @override
  State<EnAccountDeleteApp> createState() => _EnAccountDeleteAppState();
}

class _EnAccountDeleteAppState extends State<EnAccountDeleteApp> {

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
                          Navigator.of(context).pushNamed('/en_account_setting');
                        },
                        icon: const ImageIcon(
                          AssetImage("assets/images/before_arrow.png"),
                          color: Colors.white,
                        )
                      ) 
                    ),
                    const Expanded(
                      child: Text(
                          'Delete account',
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 53.5,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left:18, right: 18),
                          child: Text(
                            'Your account is registered with an auto-renewing subscription. You need to cancel the subscription before deleting the account.',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Nato',
                              fontSize: 15,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: TextButton(
                            onPressed: () {
                                  Navigator.of(context).pushNamed('/subscription');
                            },
                            child: RichText(
                              text: const TextSpan(
                                text: 'For cancellation instructions, please refer to ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Nato',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: '"Subscriptions"', 
                                    
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline
                                  )),
                                  TextSpan(text: 'in the "Settings" screen.'),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left:18, right: 18),
                          child: Text(
                            'After canceling the subscription, please return to this page to delete your account.',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Nato',
                              fontSize: 15,
                              fontWeight: FontWeight.w400
                            ),
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
                'アカウント情報を更新しますか？',
                style: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Nato',
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






