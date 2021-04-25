import 'package:flutter/material.dart';
import 'package:section7/main.dart';
import 'package:splashscreen/splashscreen.dart';

class MainSplashScreen extends StatefulWidget {
  MainSplashScreen();
  @override
  _MainSplashScreen createState() => _MainSplashScreen();

}
  class _MainSplashScreen extends State<MainSplashScreen>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     home: Scaffold(
        body: SplashScreen(
          seconds: 5,
          title: Text('Hello World'),
          loaderColor: Colors.red,
          loadingText: Text('loading'),
          backgroundColor: Colors.amberAccent,
          image: Image.asset('assets/images/mmm.jpg'),
          photoSize: 180,
          navigateAfterSeconds: MyHomePage(),
        ),
      )
    );
  }

}
