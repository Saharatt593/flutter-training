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
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: 48,
            ),
            Image.asset(
              "assets/images/cdgs_logo.png",
              width: 200,
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Card(
                  margin: const EdgeInsets.only(
                    top: 22,
                    bottom: 24,
                    right: 22,
                    left: 22,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 22,
                      bottom: 62,
                      right: 22,
                      left: 22,
                    ),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                              hintText: "login",
                              labelText: "username",
                              icon: Icon(Icons.person),
                              border: InputBorder.none),
                        ),
                        Divider(
                          height: 22,
                          indent: 22,
                          endIndent: 22,
                        ),
                        TextField(
                          decoration: InputDecoration(
                              labelText: "password",
                              icon: Icon(Icons.lock),
                              border: InputBorder.none),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 280,
                  height: 52,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "Login",
                        style:
                            TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),
            Text("Login button"),
            Text("forget button"),
            Text("sso"),
          ])
        ],
      ),
    );
  }
}
