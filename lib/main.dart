import 'package:flutter/material.dart';
import 'pages/LoginPage.dart';
import 'pages/RegisterPage.dart';
import 'pages/HomePage.dart';
import 'pages/ProductInfoPage.dart';
import 'pages/ProductListPage.dart';


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
        '/HomePage': (context)=>HomePage(),
        '/ProductListPage': (context)=>ProductListPage(),
        '/ProductInfoPage' : (context)=>ProductInfo(),
      },
    );
  }
}
