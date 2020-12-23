import 'package:flutter/material.dart';
import 'package:flutter_localization_app/pages/about_page.dart';
import 'package:flutter_localization_app/pages/home_page.dart';
import 'package:flutter_localization_app/pages/not_found_page.dart';
import 'package:flutter_localization_app/pages/setting_page.dart';
import 'package:flutter_localization_app/routes/route_names.dart';

class CustomeRoute {

  static Route<dynamic> allRoute(RouteSettings settings){

     switch(settings.name){

       case homeRoute:
         return MaterialPageRoute(builder: (_) => HomePage());

       case aboutRoute:
         return MaterialPageRoute(builder: (_) => AboutPage());

       case settingsRoute:
         return MaterialPageRoute(builder: (_) => SettingPage());
     }
     return MaterialPageRoute(builder: (_) => NotFoundPage());

  }

}