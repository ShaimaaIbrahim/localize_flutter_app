import 'package:flutter/material.dart';
import 'package:flutter_localization_app/routes/route_names.dart';


class AboutPage extends StatefulWidget {

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Page'),),
      body: Container(
        child: MaterialButton(
          onPressed: () {
            Navigator.pushNamed(context, settingsRoute);
          },
          color: Colors.blue,
          child: Text('to settings page'),

        ),
      ),
    );
  }
}
