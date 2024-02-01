

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/first_language.dart';
//  import 'package:flutter_app/pages/first.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/newpassword_page.dart';
import 'package:flutter_app/pages/password_forgetpage.dart';
import 'package:flutter_app/pages/plan_page.dart';
import 'package:flutter_app/pages/register_page.dart';

import 'package:flutter_app/pages/questions_page.dart';
import 'package:flutter_app/pages/questionnaire_page.dart';
import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/pages/verify_page.dart';

final routes={
  '/question':(BuildContext context)=>const QuestionsApp(),
  // '/':(BuildContext context)=>const FirstApp(),
  '/login':(BuildContext context)=>const LoginPage(),
  '/register':(BuildContext context)=>const RegisterPage(),
  '/plan':(BuildContext context)=>const PlanPage(),
  '/questionnaire':(BuildContext context)=>const QuestionnairesApp(),
  '/home':(BuildContext context)=>const HomeApp(),
  '/passwordforget':(BuildContext context)=>const PasswordForgetPage(),
  '/verify':(BuildContext context)=>const VerifyPage(),
  '/newpassword':(BuildContext context)=>const NewPasswordPage(),
  '/':(BuildContext context)=>const FirstChangeLanguage(),

};

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: routes,
    );
  }
}