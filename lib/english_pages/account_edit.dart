import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:gassho/pages/requesturl.dart' as requesturl;



void main() {
  runApp(
    const EnAccountEditApp()
  );
}

class EnAccountEditApp extends StatefulWidget{
  const EnAccountEditApp({super.key});
  static const routeName='/en_account_edit';
  
  @override
  State<EnAccountEditApp> createState() => _EnAccountEditAppState();
}

class _EnAccountEditAppState extends State<EnAccountEditApp> {

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String name="";
  String email1="";

  TextEditingController newName = TextEditingController();
  TextEditingController newEmail = TextEditingController();
  
  @override
  void initState() {
    loadUser();
    super.initState();
  }

  void loadUser() async {
    const storage = FlutterSecureStorage();
    String? email=await storage.read(key: 'email');
    String url = "${requesturl.Constants.url}/api/users/getname?email=$email";
    final response = await http.get(Uri.parse(url));
    var reasonData = json.decode(response.body);
    setState(() {
      name=reasonData.toString();
      email1 = email.toString();
    });
  }

  Future<void> editAccount() async {
    String url="${requesturl.Constants.url}/api/user/editaccount";
    const storage = FlutterSecureStorage();
    String? email=await storage.read(key: 'email');
    final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email':email.toString(),
          'newName':newName.text,
          'newEmail': newEmail.text,
        }),
      );
      if (response.statusCode == 200) { 
        await storage.delete(key: 'email');
        await storage.write(key: 'email', value: newEmail.text);
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
                    padding: EdgeInsets.only(top:20, left: 20, right: 20),
                    child: Text(
                      'Your account information has been corrected correctly!',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nato',
                        fontSize:14 
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
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
                          Navigator.of(context, rootNavigator: true).pop(false);
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
                  )
                ],
              ),
              )
            )
        );
      } else {
        var error = String.fromCharCodes(response.bodyBytes);
        final string=jsonDecode(error);
     // ignore: use_build_context_synchronously
        showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(string),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
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
                          'Edit account information',
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
                                            'Name',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Nato',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: newName,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            filled: true,
                                            hintText: name,
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
                                            'Email',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Nato',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        ),
                                        TextFormField(
                                          controller: newEmail,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            filled: true,
                                            fillColor: Colors.white,
                                            hintText: email1,
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
                                        editAccount();
                                      },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(138, 86, 172, 1),
                                    ),
                                    child: const Text(
                                        'Update',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Nato'
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
          fontFamily: 'Nato'
        ),
      ),
      );
  }
}
