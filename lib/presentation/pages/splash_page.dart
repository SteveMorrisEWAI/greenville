import 'package:flutter/material.dart';
import 'package:aiseek/core/commons/app_constants.dart';

// TODO Flesh out Splash Page
class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(decoration: BoxDecoration(color: Colors.white)),
        centerTitle: true,
        title: Text(AppConstants.splashPageTitle, style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold
          )),
      ),
    );
  }
}
