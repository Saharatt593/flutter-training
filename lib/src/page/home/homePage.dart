import 'package:flutter/material.dart';
import 'package:flutter_app2/src/conf/appRount.dart';
import 'package:flutter_app2/src/page/login/backGroundTheme.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CommonDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CommonDrawer extends StatelessWidget {
  const CommonDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Name'),
            accountEmail: Text('Email'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/cdgs_logo.png"),
            ),
            decoration: BoxDecoration(gradient: BackGroundTheme.gradient),
          ),
          Spacer(),
          ListTile(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRount.loginRount, (route) => false);
            },
            leading: Icon(Icons.exit_to_app),
            title: Text("Logout"),
          )
        ],
      ),
    );
  }
}
