import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/english_pages/home_page.dart';
import 'package:flutter_app/english_pages/password_forgetpage.dart';
import 'package:flutter_app/english_pages/questions_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_app/pages/requesturl.dart' as requesturl;


void main() {
  runApp(
    const MaterialApp(
      home: EnLoginPage(),
    ),
  );
}

class EnLoginPage extends StatefulWidget {
  const EnLoginPage({super.key});

  @override
  State<EnLoginPage> createState() => _EnLoginPageState();
}

class _EnLoginPageState extends State<EnLoginPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // String _username, _password;
  final apiUrl = "${requesturl.Constants.url}/api/auth/";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> sendPostRequest() async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': emailController.text,
        'password': passwordController.text,
      }),
    );
    if (response.statusCode == 200) {
      const storage = FlutterSecureStorage();
      final token = jsonDecode(response.body)['token'];
      await storage.write(key: 'jwt', value: token);
      await storage.write(key: 'email', value: emailController.text);

        // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const EnHomeApp()));   
      //    
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
                child: Text(
                  'Log in',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato',
                      decoration: TextDecoration.none
                      ),
                ),
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
                                      fontFamily: 'Lato',
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
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                                  'Password',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Lato',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400
                                      ),
                                ),
                              ),
                              TextFormField(
                                controller: passwordController,
                                obscureText: true,
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
                              'Log in',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Lato'
                                  ),
                            )),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const EnPasswordForgetPage()));
                            },
                            child: const Text(
                              'Tap here if you forgot your password',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white),
                            ),
                          )
                        ],
                      ),
                      Container(
                        width: 354,
                        height: 47,
                        margin: const EdgeInsets.only(
                          left: 20,
                          top: 40,
                          bottom: 0,
                          right: 20,
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                              // Navigator.of(context).pushNamed("/en_question");
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const EnQuestionsApp()));

                            },
                            style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                    width: 2,
                                    color: Color.fromRGBO(138, 86, 172, 1),
                                    style: BorderStyle.solid)),
                            child: const Text(
                              'Create account',
                              style: TextStyle(
                                  color: Color.fromRGBO(138, 86, 172, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Lato'
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

class Album {
  final int id;
  final String title;

  const Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'title': String title,
      } =>
        Album(id: id, title: title),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}
