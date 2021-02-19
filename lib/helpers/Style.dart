import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

TextStyle headingStyle = TextStyle(
    fontSize: 19,
    fontWeight: FontWeight.w700
);
TextStyle contentStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
);
LinearGradient gradientStyle = LinearGradient(
    colors: [HexColor("#06D6A0"),HexColor("#92e3a9")],
    stops: [0,1],
    begin: Alignment.topCenter
);