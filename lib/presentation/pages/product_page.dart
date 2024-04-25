import 'package:flutter/material.dart';
import 'package:aiseek/core/commons/globals.dart';
import 'package:aiseek/core/commons/app_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:go_router/go_router.dart';
// import 'package:share_plus/share_plus.dart';
// import 'dart:io';

// TODO Flesh out Product Page
class ProductPage extends StatefulWidget {
  ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

enum MyMenuItems { Settings, Share, ViewSearch, NewSearch, Exit }

class _ProductPageState extends State<ProductPage> with WidgetsBindingObserver {
  late WebViewController wv_controller;
  var loadingPercentage = 0;

  @override
  void initState() {
    Globals.setLastPage(AppConstants.productPageRouteName);
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    Globals.printDebug(inText: 'ProductPage didChangeAppLifecycleState state = $state');
    super.didChangeAppLifecycleState(state);
    Globals.printDebug(inText: 'ProductPage didChangeAppLifecycleState Returned to');
    if (state == AppLifecycleState.resumed) {
      Globals.printDebug(inText: 'ProductPage didChangeAppLifecycleState state = $state');
    }
  }

  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
    NavigationDelegate(
    onProgress: (int progress) {
    // Update loading bar.
    },
    onPageStarted: (String url) {},
    onPageFinished: (String url) {},
    onWebResourceError: (WebResourceError error) {},
    ),
  )
  ..loadRequest(Uri.parse(AppConstants.ProductPageURL));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBack,
      child: Scaffold(
        appBar: AppBar(
          bottomOpacity: 0.0,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(decoration: BoxDecoration(color: Colors.white)),
          centerTitle: true,
          title: Text(AppConstants.ProductPageTitle, style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold
          )),
        ),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: WebViewWidget(controller: controller),
                ),
                const SizedBox(height: 50),
                const SizedBox(height: 20),
                Container(
                  child: new Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Globals.grayForegroundColor,
                            backgroundColor: Globals.grayBackgroundColor,
                          ),
                          child: Align(alignment: Alignment.center, child: Text('Cancel', overflow: TextOverflow.ellipsis)),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            Globals.printDebug(inText: 'ProductPage Cancel button tapped');
                            FocusScope.of(context).unfocus();
                            Globals.exitFunc(context);
                          }),
                    ),
                    const SizedBox(width: 50),
                    SizedBox(
                      width: 100,
                      child: ElevatedButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Globals.stdForegroundColor,
                            backgroundColor: Globals.stdBackgroundColor,
                          ),
                          child: Align(alignment: Alignment.center, child: Text('Continue', overflow: TextOverflow.ellipsis)),
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            Globals.printDebug(inText: 'ProductPage Subscription button tapped');
                            context.pushNamed(AppConstants.paymentPageRouteName);
                          }),
                    ),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBack() async {
    Globals.printDebug(inText: 'ProductPage _onBack ');
    context.pop();
    return true;
  }

  void showCustomDialog(BuildContext context, {title = String, content = String, buttonText = String}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            ElevatedButton(
              child: Text(buttonText),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
