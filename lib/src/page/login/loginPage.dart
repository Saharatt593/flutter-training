import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0XFF000000),
                      Color(0XFFffffff),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.5])),
          ),
          Column(

              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 48,),
                Image.asset("assets/images/cdgs_logo.png",
                width: 200,),
                Text("Header"),
                Text("Login"),
                Text("Login button"),
                Text("forget button"),
                Text("sso"),
              ])
        ],
      ),
    );
  }
}
