import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gassho/english_pages/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:gassho/pages/requesturl.dart' as requesturl;

void main() {
  runApp(
    const MaterialApp(
      home: EnPasswordForgetPage(),
    ),
  );
}

class EnPasswordForgetPage extends StatefulWidget {
  const EnPasswordForgetPage({super.key});

  @override
  State<EnPasswordForgetPage> createState() => _EnPasswordForgetPageState();
}

class _EnPasswordForgetPageState extends State<EnPasswordForgetPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // String _username, _password;
  final apiUrl = "${requesturl.Constants.url}/api/auth/forget_password";
  TextEditingController emailController = TextEditingController();

  Future<void> sendPostRequest() async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': emailController.text
      }),
    );
    if (response.statusCode == 200) {
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
                   Padding(
                    padding: const EdgeInsets.only(top:20, left: 20, right: 20),
                    child: Text(
                      'Since you sent an email to ${emailController.text}, please set a new password.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Noto Sans CJK JP',
                        fontSize:14 
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 240,
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
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const EnLoginPage()));      
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
                child: TitleSection(name: "Forgot your password?") 
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
                                controller: emailController,
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
                              'Send',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nato'
                                  ),
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
                  fontFamily: 'Nato',
                  fontSize: 18,
                  fontWeight: FontWeight.bold
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
