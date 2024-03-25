import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:practice/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'firebase_provider.dart';
import 'package:practice/mail/auth_page.dart';

import 'login.dart';

import 'package:crypto/crypto.dart'; // password hashing algorithms
import 'dart:convert'; // for the utf8.encode method

/// Firebase Initialize
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /// Firebase Initialize 코드
  await Firebase.initializeApp(
    options:
  DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {  //앱의 메인페이지 MyApp
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home : const HomePage(),
      title: 'SWith',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
            primary: Color(0xff19A7CE),
            secondary: Colors.lightBlueAccent,
            background: Colors.white54,
        ),
        primaryColor: Colors.lightBlueAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("Flutter Firebase")),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Google Sign-In Demo"),
            subtitle: Text("google_sign_in Plugin"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GoogleSignInDemo()));
            },
          ),
          ListTile(
            title: Text("Firebase Auth"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AuthPage()));
            },
          )
        ].map((child) {
          return Card(
            child: child,
          );
        }).toList(),
      ),
    );
  }
}

//스플래시화면
class SplashScreen extends StatefulWidget {
  //const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds:3), (){  //3초동안 스플래시 후 홈스크린으로 이동
      Navigator.of(context).pushReplacementNamed('/HomeScreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/image/potato.png'),
      ),

    );
  }
}
