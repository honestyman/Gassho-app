import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/newpassword_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/pages/requesturl.dart' as requesturl;


void main() {
  runApp(
    const MaterialApp(
      home: VerifyPage(),
    ),
  );
}

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool light=true;
  // String _username, _password;
  final apiUrl = "${requesturl.Constants.url}/api/users/verify";
  TextEditingController verifyController = TextEditingController();

  Future<void> sendPostRequest() async {
    const storage = FlutterSecureStorage();
    String? email=await storage.read(key: 'email');
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email.toString(),
        'verifycode': verifyController.text
      }),
    );
    if (response.statusCode == 200) {
      
        // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NewPasswordPage()));   
          
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
  Widget build(BuildContext context) {
    return Material(
        key: scaffoldKey,
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/back.png"),
            fit: BoxFit.cover,
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 93.5),
                child: TitleSection(name: 'メール認証') 
              ),
              Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20, 24.5, 20, 16),
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
                                  '認証コード',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Noto Sans CJK JP',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -1),
                                ),
                              ),
                              TextFormField(
                                controller: verifyController,
                                decoration: InputDecoration(
                                    isDense: true,
                                    filled: true,
                                    fillColor: Colors.white,
                                    // floatingLabelBehavior: FloatingLabelBehavior.always,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white),
                                        borderRadius:
                                            BorderRadius.circular(5))),
                              ),
                            ],
                          )),
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
                            onPressed: () {
                              //  Navigator.of(context).pushNamed('/home');
                              sendPostRequest();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(138, 86, 172, 1),
                            ),
                            child: const Text(
                              '送信',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Noto Sans JP',
                                  letterSpacing: -1),
                            )),
                      ),
                    ],
                  )),
            ],
          ),
        ));
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
    return Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:15),
            child:  IconButton(
              onPressed: (){
                Navigator.pop(context,true);
              },
              icon: const ImageIcon(
                AssetImage("assets/images/before_arrow.png"),
                color: Colors.white,
              )
            ) 
          ),  
          Expanded(
            child: Text(
                name,
                textAlign:TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Noto Sans CJK JP',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1
                  ),
                  softWrap: true,
                ),
          ),
          const SizedBox(
            width: 50,
          )
        ],
      );
  }
}