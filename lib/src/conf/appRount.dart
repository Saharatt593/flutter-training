import 'package:flutter/material.dart';
import 'package:flutter_app2/src/page/pages.dart';
// import 'package:flutter_app2/src/page/pages.dart' show LoginPage;
// import 'package:flutter_app2/src/page/pages.dart' hide LoginPage;

class AppRount{
  static const homeRount ="home";
  static const loginRount ="login";
  static const managementRount ="management";
  static const googleMapPage ="googleMapPage";

  get rount =>_rount;

  final _rount = <String,WidgetBuilder>{
    homeRount:(context) => HomePage(),
    loginRount:(context) => LoginPage(),
    managementRount:(context) => ManagementPage(),
    googleMapPage:(context) => GoogleMapPage(),
  };
}