import 'package:flutter/material.dart';
import 'package:aiseek/core/commons/app_constants.dart';
import 'package:go_router/go_router.dart';
import 'package:aiseek/core/commons/globals.dart';

//ignore: must_be_immutable
class ErrorRoutePage extends StatelessWidget {
  final Exception? error;
  late String message;

  ErrorRoutePage({Key? key, this.error}) : super(key: key) {
    Globals.printDebug(inText: 'Got to error route page - started');
    if (error != null) {
      message = error.toString();
    } else {
      message = 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    Globals.printDebug(inText: "Start Error Routes page");
    return Scaffold(
      appBar: AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: Text(AppConstants.navigationErrorPageTitle, style: TextStyle(
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
        child: Row(
          children: [
            Text(message),
            SizedBox(height: 24),
            Text('Error = $Exception'),
          ],
        ),
      ),
    );
  }
}
