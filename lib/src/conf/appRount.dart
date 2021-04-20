import 'package:flutter/material.dart';
import 'package:flutter_app2/src/page/home/homePage.dart';
import 'package:flutter_app2/src/page/login/loginPage.dart';

class AppRount{
  static const homeRount ="home";
  static const loginRount ="login";

  get rount =>_rount;

  final _rount = <String,WidgetBuilder>{
    homeRount:(context) => HomePage(title:"helloHomePage"),
    loginRount:(context) => LoginPage(),
  };
}