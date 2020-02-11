import 'package:flutter/material.dart';

import 'package:vuwit_app_ios/login.dart';
//import 'package:vuwit_app_ios/login_page.dart';
//import 'package:vuwit_app_ios/vuwitapp_home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: "VuwitApp",
      theme: new ThemeData(
        primaryColor: new Color(0xFF0D47A1),
        accentColor: new Color(0xFFFFFFFF)
      ),
      debugShowCheckedModeBanner: false,
      //home: new VuwitAppHome()
      //home: LoginHome(),
      home: LoginScreen(title: "Enter Your Phone Number",),
    );
  }
}