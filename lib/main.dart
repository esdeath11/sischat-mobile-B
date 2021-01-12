import 'package:flutter/material.dart';
import 'package:sischat_mobile/View/login.dart';
import 'package:animated_splash/animated_splash.dart';

void main(){
  runApp(MaterialApp(
    title: 'route',
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/' : (context) => MyApp(),
    },
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}



