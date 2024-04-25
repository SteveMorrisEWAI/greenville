import 'package:flutter/material.dart';
import 'package:aiseek/core/commons/app_constants.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatefulWidget {
  @override
  ErrorPageState createState() => ErrorPageState();
}

class ErrorPageState extends State<ErrorPage> {
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          title: Text(AppConstants.errorPageTitle, style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold
          )),
          flexibleSpace: Container(decoration: BoxDecoration(color: Colors.white)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              return context.goNamed(AppConstants.promptPageRouteName);
            },
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Text(
            'Failed to Complete Install',
            style: TextStyle(color: Colors.red),
          ),
        ));
  }
}
