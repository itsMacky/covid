import 'package:covid/datasource.dart';
import 'package:flutter/material.dart';
import 'package:covid/homepage.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'Quicksand',
      primaryColor: primaryBlack,
    ),
    home: HomePage(),
  ));
}