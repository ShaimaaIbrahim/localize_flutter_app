import 'package:flutter/material.dart';
import 'package:flutter_localization_app/localization/set_localization.dart';
import 'package:flutter_localization_app/routes/custom_route.dart';
import 'package:flutter_localization_app/routes/route_names.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'localization/localization_methods.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  // get widget state and set state for set language......
  static void setLocal(BuildContext context , Locale locale){
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Locale _locale;

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale= locale;
      });
    });
    super.didChangeDependencies();
  }

  void setLocale(Locale locale){
   setState(() {
     _locale = locale;
   });
  }

  @override
  Widget build(BuildContext context) {
    if(_locale==null){
      return Container(
        child: Center(
        child: CircularProgressIndicator(),
        ),
      );
    }else{
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primaryColor: Colors.blue
        ),
        locale: _locale,
        supportedLocales: [
          Locale('ar', 'AR'), Locale('en', 'US')
        ],
        localeResolutionCallback: (deviceLocal, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == deviceLocal.languageCode &&
                supportedLocale.countryCode == deviceLocal.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        localizationsDelegates: [
          SetLocalization.delegete,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        onGenerateRoute: CustomeRoute.allRoute,
        initialRoute: homeRoute,
      );
    }
  }
}



