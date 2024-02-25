

import 'package:flutter/material.dart';
import 'package:flutter_app/english_pages/first_language.dart';
import 'package:flutter_app/english_pages/home_page.dart';
import 'package:flutter_app/english_pages/login_page.dart';
import 'package:flutter_app/english_pages/password_forgetpage.dart';
import 'package:flutter_app/english_pages/plan_page.dart';
import 'package:flutter_app/english_pages/questionnaire_page.dart';
import 'package:flutter_app/english_pages/questions_page.dart';
import 'package:flutter_app/english_pages/register_page.dart';
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
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';


final routes={
  '/question':(BuildContext context)=>const QuestionsApp(),
  '/en_question':(BuildContext context)=>const EnQuestionsApp(),
  // '/':(BuildContext context)=>const FirstApp(),
  '/login':(BuildContext context)=>const LoginPage(),
  '/en_login':(BuildContext context)=>const EnLoginPage(),
  '/register':(BuildContext context)=>const RegisterPage(),
  '/en_register':(BuildContext context)=>const EnRegisterPage(),
  '/plan':(BuildContext context)=>const PlanPage(),
  '/en_plan':(BuildContext context)=>const EnPlanPage(),
  '/questionnaire':(BuildContext context)=>const QuestionnairesApp(),
  '/en_questionnaire':(BuildContext context)=>const EnQuestionnairesApp(),
  '/home':(BuildContext context)=>const HomeApp(),
  '/en_home':(BuildContext context)=>const EnHomeApp(),
  '/passwordforget':(BuildContext context)=>const PasswordForgetPage(),
  '/en_passwordforget':(BuildContext context)=>const EnPasswordForgetPage(),
  '/verify':(BuildContext context)=>const VerifyPage(),
  '/newpassword':(BuildContext context)=>const NewPasswordPage(),
  '/english_languagechange':(BuildContext context)=>const EnFirstChangeLanguage(),
  '/':(BuildContext context)=>const FirstChangeLanguage(),

};

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

@override
void initState() {
  initPlatform();
  super.initState();
}

Future<void> initPlatform() async{
   const storage = FlutterSecureStorage();
   var noti= await storage.read(key: 'notification');
   await OneSignal.shared.setAppId("60e87cd5-8d05-48d7-ad50-7c36f424ef29");
   await OneSignal.shared.getDeviceState().then((value) => {
    // ignore: avoid_print
    print(value!.userId)
   });
   if(noti.toString() == "true"){
    OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) { 
      event.complete(null);
    });
   }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.teal),
      routes: routes,
    );
  }
}