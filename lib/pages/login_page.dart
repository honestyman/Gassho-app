import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/pages/password_forgetpage.dart';
import 'package:flutter_app/pages/questions_page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_app/pages/requesturl.dart' as requesturl;
import 'package:onesignal_flutter/onesignal_flutter.dart';

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
  // String _username, _password;
  final apiUrl = "${requesturl.Constants.url}/api/auth/";
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() { 
    OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
  // Extract notification data
      String title = result.notification.title.toString();
      // ignore: unused_local_variable
      String notificationId = result.notification.notificationId;

      // Additional custom data
      Map<String, dynamic> additionalData = result.notification.additionalData ?? {};

      final String japanese = additionalData['japanese'];
      // Handle the opened notification based on your requirements
      // For example, you can navigate to a specific screen or perform an action
      // using the extracted data from the notification
      if (additionalData.containsKey('screen')) {
        String screenName = additionalData['screen'];
        // Navigate to a specific screen
        // Example using the named routes approach:
        Navigator.pushNamed(context, screenName);
      } else {
        // Perform a default action
        // Example: Show an alert dialog with the notification details
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(title),
            content: Text(japanese),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop(false);
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      }
    });
    super.initState(); 
  }

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
          MaterialPageRoute(builder: (context) => const HomeApp()));   
      //    
    } else {
       var error = String.fromCharCodes(response.bodyBytes);
      final string=jsonDecode(error);
      var str="";
      if(string=="Please include a valid Email"){
         str="有効なメールアドレスを入力してください";
      }
      if(string=="Password is required"){
         str="パスワードが必要です";
      }
      if(string=="Invalid Credentials"){
         str="無効な資格情報";
      }
      if(string=="Your account is already deleted!"){
        str="あなたのアカウントはすでに削除されています！";
      }
      if(string=="Server Error"){
         str="サーバーエラー";
      }
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(str),
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
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const PasswordForgetPage()));
                            },
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
                              // Navigator.of(context).pushNamed("/question");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const QuestionsApp()));
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));

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
