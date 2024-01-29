

import 'package:flutter/material.dart';
//  import 'package:flutter_app/pages/first.dart';
import 'package:flutter_app/pages/login_page.dart';
import 'package:flutter_app/pages/plan_page.dart';
import 'package:flutter_app/pages/register_page.dart';

import 'package:flutter_app/pages/questions_page.dart';
import 'package:flutter_app/pages/questionnaire_page.dart';
import 'package:flutter_app/pages/home_page.dart';

final routes={
  '/':(BuildContext context)=>const QuestionsApp(),
  // '/':(BuildContext context)=>const FirstApp(),
  '/login':(BuildContext context)=>const LoginPage(),
  '/register':(BuildContext context)=>const RegisterPage(),
  '/plan':(BuildContext context)=>const PlanPage(),
  '/questionnaire':(BuildContext context)=>const QuestionnairesApp(),
  '/home':(BuildContext context)=>const HomeApp(),

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