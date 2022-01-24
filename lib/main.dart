import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:translatorapp/helper/constant.dart';
import 'package:translatorapp/view/home_view.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:translatorapp/view_model/lang_view_model.dart';
import 'model/app_local.dart';




void main() async {

  LangViewModel Translate = LangViewModel();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("lang", "en");
  Locale locale = Locale(sharedPreferences.getString("lang")!, " ");

  runApp(MyApp(locale));
}

class MyApp extends StatefulWidget {
  final Locale? locale;

  MyApp(this.locale);

  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  LangViewModel Translate = Get.put(LangViewModel());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        AppLocal.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', ''),
        Locale('en', ''),
        Locale('fr', ''),
      ],
      locale: widget.locale,
      localeResolutionCallback: (currentLocale, supportedLocales) {
        if (currentLocale != null) {
          for (Locale locale in supportedLocales) {
            if (currentLocale.languageCode == locale.languageCode) {
              return currentLocale;
            }
          }
        }
        return supportedLocales.first;
      },
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splashIconSize: 250,
        duration: 3000,
        splash: Icon(Icons.translate ,color: const Color(0xFF0A3157),size: 250,),
        nextScreen: HomeScreen(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Color(0xFFB5C1CC),
      ),
    );
  }
}



/*
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(

    MyApp(),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter GetX Theme'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(Icons.account_circle),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.art_track,
              size: 150,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          RaisedButton(
            child: Text('Change Theme'),
            onPressed: () {
              Get.isDarkMode
                  ? Get.changeTheme(ThemeData.light())
                  : Get.changeTheme(ThemeData.dark());
            },
          )
        ],
      ),
    );
  }
}*/