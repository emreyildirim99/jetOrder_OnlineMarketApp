import 'package:emre_yildirim_jetorder/pages/ShoppingCartPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'pages/LoginPage.dart';
import 'pages/RegisterPage.dart';
import 'pages/HomePage.dart';
import 'pages/ProductInfoPage.dart';
import 'pages/ProductListPage.dart';
import 'pages/ProfilePage.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //Check session
  dynamic userID = await FlutterSession().get('userID');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: userID != 0 ? HomePage() : LoginPage(),
    routes: {
      '/LoginPage': (context)=>LoginPage(),
      '/RegisterPage': (context)=>RegisterPage(),
      '/HomePage': (context)=>HomePage(),
      '/ProductListPage': (context)=>ProductListPage(),
      '/ProductInfoPage' : (context)=>ProductInfo(),
      '/ShoppingCartPage' : (context)=>ShoppingCartPage(),
      '/ProfilePage' : (context)=>ProfilePage(),
    },
  ));

}

