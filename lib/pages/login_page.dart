import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/pages/register_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(
    const MaterialApp(
      home: LoginPage(),
    ),
  );
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool light=true;
  // String _username, _password;
  final apiUrl = "http://localhost:5000/api/auth/";
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
      String? reasons=await storage.read(key: 'reasons');
      String? introductions=await storage.read(key: 'introductions');
      // await storage.deleteAll();
      await storage.delete(key: 'reasons');
      await storage.delete(key: 'introductions');
      final token = jsonDecode(response.body)['token'];
      await storage.write(key: 'jwt', value: token);
      await storage.write(key: 'email', value: emailController.text);
      await storage.write(key: 'notification', value: light.toString());

        // ignore: use_build_context_synchronously
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const HomeApp()));   
        if(reasons!=null && introductions!=null){
          List<dynamic> listReasons=jsonDecode(reasons);
          List<dynamic> listIntroductions=jsonDecode(introductions);

      // ignore: unused_local_variable
          final reasonData= await http.post(Uri.parse('http://localhost:5000/api/reasons/user_reasons/add'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'email': emailController.text.toString(),
              'reasons': jsonEncode(listReasons),
              'introductions': jsonEncode(listIntroductions),         
            })
          );
        }   
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
                  'ログイン',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Noto Sans CJK JP',
                      decoration: TextDecoration.none,
                      letterSpacing: -1),
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
                                  'メールアドレス',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Noto Sans CJK JP',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -1),
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
                                  'パスワード',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Noto Sans CJK JP',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: -1),
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
                              'ログイン',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Noto Sans JP',
                                  letterSpacing: -1),
                            )),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            onPressed: () {},
                            child: const Text(
                              'パスワードをお忘れの方はこちら',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Noto Sans CJK JP',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -2,
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
                              // Navigator.of(context).pushNamed("/register");
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));

                            },
                            style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                    width: 2,
                                    color: Color.fromRGBO(138, 86, 172, 1),
                                    style: BorderStyle.solid)),
                            child: const Text(
                              'アカウント作成はこちら',
                              style: TextStyle(
                                  color: Color.fromRGBO(138, 86, 172, 1),
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
