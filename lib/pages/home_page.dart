import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization_app/localization/localization_methods.dart';
import 'package:flutter_localization_app/localization/set_localization.dart';
import 'package:flutter_localization_app/main.dart';
import 'package:flutter_localization_app/models/language.dart';
import 'package:flutter_localization_app/routes/route_names.dart';

//https://github.com/ShaimaaIbrahim/localize_flutter_app.git
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _drawerList(),
      appBar: AppBar(
        title: Text(getTranslated(context , 'home_page')),
        actions: [
          Padding(
            padding: EdgeInsets.all(8),
            child: DropdownButton(
              underline: SizedBox(),
              icon: Icon(
                Icons.language,
                color: Colors.white,
              ),
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
                      value: lang,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            lang.name,
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            lang.flag,
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      )))
                  .toList(),
                 onChanged: (Language lang) {
                _changeLanguage(lang);
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: _mainForm(context),
        ),
      ),
    );
  }

  Form _mainForm(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 4,
            child: Center(
              child: Text(
                getTranslated(context ,'Personal Information') ,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          TextFormField(
            validator: (val) {
              if (val.isEmpty) {
                return 'required field';
              }
              return null;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: getTranslated(context ,'Name'),
                hintText: 'Enter Name'),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (val) {
              if (val.isEmpty) {
                return 'required field';
              }
              return null;
            },
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: getTranslated(context ,'Email') ,
                hintText: 'Enter Email'),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Date',
                hintText: 'Select Date Of Birth'),
            onTap: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(DateTime.now().year),
                  lastDate: DateTime(DateTime.now().year + 20));
            },
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () {
              if (_key.currentState.validate()) {
                _showSuccessDialoge();
              }
            },
            height: 50,
            shape: StadiumBorder(),
            color: Theme.of(context).primaryColor,
            child: Text(
              getTranslated(context ,'Submit Info') ,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  // show time picker
  void _showSuccessDialoge() {
    showTimePicker(context: context, initialTime: TimeOfDay.now());
  }

  //widget drawer
  Container _drawerList() {
    TextStyle _textStyle = TextStyle(color: Colors.white, fontSize: 24);
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      color: Theme.of(context).primaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(
            height: 100,
            child: CircleAvatar(),
          )),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              'About Us',
              style: _textStyle,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, aboutRoute);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.white,
              size: 30,
            ),
            title: Text(
              'About Us',
              style: _textStyle,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, settingsRoute);
            },
          ),
        ],
      ),
    );
  }

  void _changeLanguage(Language lang) async{
    Locale _temp = await setLocale(lang.languageCode);
    MyApp.setLocal(context, _temp);
  }
}
