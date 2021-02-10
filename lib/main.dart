import 'package:flutter/material.dart';
import 'pages/LoginPage.dart';
import 'pages/RegisterPage.dart';

void main() {
  runApp(JetOrder());
}

class JetOrder extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: {
        '/LoginPage': (context)=>LoginPage(),
        '/RegisterPage': (context)=>RegisterPage(),
      },
    );
  }
}
