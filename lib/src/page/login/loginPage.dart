import 'package:flutter/material.dart';
import 'package:flutter_app2/src/page/login/backGroundTheme.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: BackGroundTheme.gradient),
          ),
          SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
            ]),
          )
        ],
      ),
    );
  }
  BoxDecoration _boxDecoration() {
    final gradientStart = BackGroundTheme().gradientStart;
    final gradientEnd = BackGroundTheme().gradientEnd;

    final boxShadowItem = (Color color) => BoxShadow(
      color: color,
      offset: Offset(1.0, 6.0),
      blurRadius: 20.0,
    );

    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      boxShadow: <BoxShadow>[
        boxShadowItem(gradientStart),
        boxShadowItem(gradientEnd),
      ],
      gradient: LinearGradient(
        colors: [
          gradientEnd,
          gradientStart,
        ],
        begin: const FractionalOffset(0, 0),
        end: const FractionalOffset(1.0, 1.0),
        stops: [0.0, 1.0],
      ),
    );
  }
}
