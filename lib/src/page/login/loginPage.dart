import 'package:flutter/material.dart';
import 'package:flutter_app2/src/conf/appRount.dart';
import 'package:flutter_app2/src/constants/appSetting.dart';
import 'package:flutter_app2/src/constants/asset.dart';
import 'package:flutter_app2/src/page/login/backGroundTheme.dart';
import 'package:flutter_app2/src/viewmodels/ssoViewmodel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(gradient: BackGroundTheme.gradient),
          ),
          SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 48,
                  ),
                  Image.asset(
                    Asset.logoImage,
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
                                keyboardType: TextInputType.emailAddress,
                                controller: _userController,
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
                                obscureText: true,
                                controller: _passwordController,
                                decoration: InputDecoration(
                                    labelText: "password",
                                    icon: Icon(Icons.lock),
                                    border: InputBorder.none),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: _boxDecoration(),
                        width: 280,
                        height: 52,
                        child: TextButton(
                            onPressed: () async {
                              final userName = _userController.text;
                              final password = _passwordController.text;
                              if (userName == "aa" && password == "aa") {
                                SharedPreferences tokenPreferences  = await SharedPreferences.getInstance();
                                var token = "asdasdasd";
                                await tokenPreferences.setString(AppSetting.tokenSetting, token);
                                await tokenPreferences.setString(AppSetting.usernameString, userName);
                               Navigator.pushReplacementNamed(context, AppRount.homeRount);
                              }else{
                                print("No");
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            )),
                      )
                    ],
                  ),
                  _buildTextButton("Forger Password", onPressed: () {}),
                  SSoButton(),
                  _buildTextButton("register", onPressed: () {}),
                ]),
          )
        ],
      ),
    );
  }

  Container _buildTextButton(String text, {VoidCallback onPressed}) {
    return Container(
      child: TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: Colors.white70),
          )),
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

class SSoButton extends StatelessWidget {
  const SSoButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: SSOViewModel()
              .item
              .map((e) => FloatingActionButton(
                    heroTag: e.backgroundColor.toString(),
                    onPressed: e.onPressed,
                    child: FaIcon(e.icon),
                    backgroundColor: e.backgroundColor,
                  ))
              .toList()),
    );
  }
}
