import 'package:flutter/material.dart';
import 'package:flutter_app2/src/conf/appRount.dart';
import 'package:flutter_app2/src/constants/appSetting.dart';
import 'package:flutter_app2/src/page/home/homePage.dart';
import 'package:flutter_app2/src/page/login/loginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppRount().rount,
      // debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context,snapshort){
          if(!snapshort.hasData){
            return Container(
              color: Colors.white,
            );

          }
          final token = snapshort.data.getString(AppSetting.tokenSetting) ?? "";
          if(token.isNotEmpty){
            return HomePage();
          }else{
            return LoginPage();
          }
        },
      ),
    );
  }
}