// ignore_for_file: deprecated_member_use, prefer_const_constructors, use_key_in_widget_constructors, avoid_print, prefer_typing_uninitialized_variables

import 'dart:async';
import 'package:cloud_kitchen/core/provider/app_provider.dart';
import 'package:cloud_kitchen/pageviews/auth/authorization/login.dart';
import 'package:cloud_kitchen/pageviews/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AppProvider appProvider = AppProvider();
  var token;
  startTimeout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    return Timer(Duration(seconds: 3), changeScreen);
  }

  changeScreen() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return token == null ? LoginPage() : HomePage();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 40.0, right: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/logo/splash.png",
              ),
            ),
            Text('Cloud', style: appProvider.theme.textTheme.subtitle1),
            Text('kitchen', style: appProvider.theme.textTheme.subtitle1)
          ],
        ),
      ),
    );
  }
}
